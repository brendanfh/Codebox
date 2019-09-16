$(document).ready ->
	$('[data-user-reset-password]').click (e) ->
		username = $(e.target).attr 'data-user-reset-password'

		new_password = prompt 'New password'
		if not new_password? or new_password == ""
			return

		$.post '/admin/users/reset_password', { 'username': username, 'password': new_password }, (data) ->
			if data.success?
				alert("#{username}'s password was changed")

			console.log(data)

	$('[data-user-delete]').click (e) ->
		username = $(e.target).attr 'data-user-delete'

		$.post '/admin/users/delete', { 'username': username }, (data) ->
			if data.success?
				alert "#{username} was deleted"

			window.location.reload()
