import make_controller from require "controllers.controller"
import Users from require 'models'
import assert_valid from require "lapis.validate"
import capture_errors, yield_error from require 'lapis.application'

make_controller
	inject:
		crypto: 'crypto'

	middleware: { 'logged_in' }

	get: =>
		@flow 'csrf_setup'
		render: 'account.account'

    post: capture_errors (=>
        @flow 'csrf_validate'
        assert_valid @params, {
			{ "username", exists: true, min_length: 2, matches_pattern: "^%w+$" }
			{ "nickname", exists: true, min_length: 2 }
			{ "email", exists: true, min_length: 4, matches_pattern: "^%S+@%S+%.%S+$" }
        }

        if @user.username ~=@params.username
            yield_error 'You cannot change your username!'
        
        @user\update
            nickname: @params.nickname
            email: @params.email

        if @params.oldpassword ~= ""
            assert_valid @params, {
                { "newpassword", exists: true, min_length: 2 }
                { "confirmpassword", exists: true, min_length: 2, equals: @params.newpassword, 'Passwords must be the same' }
            }

            if @crypto.verify @params.oldpassword, @user.password_hash
                @user\update
                    password_hash: @crypto.encrypt @params.newpassword
            else
                yield_error 'Incorrect password'

        yield_error { success: true, msg: 'Successfully updated account' }
        render: 'account.account'

    ), (-> render: 'account.account')

