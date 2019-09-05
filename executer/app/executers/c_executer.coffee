{ BaseExecuter } = require './base_executer'
{ spawn } = require 'child_process'
{ on_child_exit } = require '../child_process'

class CExecuter extends BaseExecuter
	execute: (path, input, time_limit) ->
		bash_shell = spawn 'bash'

		output = ""
		bash_shell.stdout.on 'data', (data) => output += data.toString()

		err_output = ""
		bash_shell.stderr.on 'data', (data) => err_output += data.toString()

		bash_shell.stdin.end "echo #{input} | timeout -s SIGKILL #{time_limit / 1000.0} #{path}"

		start_time = process.hrtime()
		res_code = await on_child_exit bash_shell
		diff_time = process.hrtime start_time

		run_time = diff_time[0] * 1000000 + Math.floor(diff_time[1] / 1000) / 1000000

		if res_code == 0
			return { status: 'SUCCESS', output: output, run_time: run_time }
		else if res_code == 124 or res_code == 137
			bash_shell.kill()
			return { status: 'TIME_LIMIT_EXCEEDED' }
		else
			bash_shell.kill()
			return { status: 'BAD_EXECUTION', err: err_output }

module.exports = {
	CExecuter: CExecuter
}
