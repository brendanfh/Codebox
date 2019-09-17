html = require 'lapis.html'

class AccountView extends html.Widget
    content: =>
        h1 "#{@user.username}'s Account"

        div class: 'content', ->
            form class: 'pad-l-48 pad-r-48', method: 'POST', ->
                input type: 'hidden', name: 'csrf_token', value: @csrf_token, ''

                label for: 'username', 'Username'
                p -> input type: 'text', name: 'username', value: @user.username, readonly: true, ''

                label for: 'nickname', 'Display name'
                p -> input type: 'text', name: 'nickname', value: @user.nickname, ''

                label for: 'email', 'Email'
                p -> input type: 'text', name: 'email', value: @user.email, ''

                div class: 'mar-t-24 header-line', -> div 'Change password'
                p -> input type: 'password', name: 'oldpassword', placeholder: 'Old password', ''
                p -> input type: 'password', name: 'newpassword', placeholder: 'New password', ''
                p -> input type: 'password', name: 'confirmpassword', placeholder: 'Confirm new password', ''

                input class: 'mar-t-24', type: 'submit', value: 'Update account'

