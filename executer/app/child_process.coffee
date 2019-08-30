cp = require 'child_process'

module.exports = {
	on_child_exit: (cp) ->
		new Promise (res, rej) ->
			cp.on 'exit', (code) ->
				if code?
					res code
				else
					rej -1
}
