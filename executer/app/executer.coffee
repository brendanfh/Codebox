{ make_matcher } = require './matchers'
{ TempFile } = require './temp_file'

{ BaseCompiler } = require './compilers/base_compiler'
{ CCompiler } = require './compilers/c_compiler'
{ CPPCompiler } = require './compilers/cpp_compiler'
{ CExecuter } = require './executers/c_executer'
{ PyExecuter } = require './executers/py_executer'

clean_output = (otpt) ->
	otpt.split '\n'
		.map (s) -> s.trim()
		.filter (s) -> s != ''

create_matchers = (otpt) ->
	otpt.map (s) -> make_matcher s

class Executer
	compilers: {
		'c': new CCompiler(),
		'cpp': new CPPCompiler(),
		'py': new BaseCompiler()
	}

	executers: {
		'c': new CExecuter(),
		'cpp': new CExecuter(),
		'py': new PyExecuter()
	}

	process: (lang, code, test_cases, time_limit) ->
		# Makes function async
		if lang == "word"
			throw 'WORD PROBLEMS NOT SUPPORTED YET'
		else
			yield from @process_code lang, code, test_cases, time_limit
		await return

	process_code: (lang, code, test_cases, time_limit) ->
		compiler = @compilers[lang.toLowerCase()]
		unless compiler?
			yield { status: 7 }
			return

		yield { status: 2 }

		exec_file = 0
		try
			exec_file = await compiler.compile code
		catch err
			yield { status: 9, data: err.substring(0, 4096) }
			return

		executer = @executers[lang]
		unless executer?
			exec_file.delete_file()

			yield { status: 7 }
			return

		total_cases = test_cases.length
		run_times = new Array total_cases
		completed = 0

		# Wait a second so the submission page looks cooler
		await new Promise (res) ->
			setTimeout res, 500

		yield { status: 3, data: { completed: completed, total: total_cases, run_times: run_times } }

		for test_case in test_cases
			res = await executer.execute exec_file.file_path, test_case.input, time_limit
			await new Promise (res) ->
				setTimeout res, 200

			switch (res.status)
				when 'SUCCESS'
					console.log test_case.output, res.output
					output = clean_output res.output
					expected = create_matchers (clean_output test_case.output)

					worked = true
					i = 0
					for matcher in expected
						console.log matcher.line, output[i]
						unless matcher.test output[i]
							worked = false
							break

						i++

					if worked && i != output.length
						worked = false

					run_times[completed] = res.run_time
					if worked
						completed++

						unless completed == total_cases
							# Running more cases
							yield { status: 3, data: { completed: completed, total: total_cases, run_times: run_times } }

						break
					else
						# Wrong answer
						yield { status: 5, data: { completed: completed, total: total_cases, run_times: run_times } }

						exec_file.delete_file()
						return

				when 'BAD_EXECUTION'
					exec_file.delete_file()
					# General error
					yield { status: 10, data: { completed: completed, total: total_cases, run_times: run_times } }
					return

				when 'TIME_LIMIT_EXCEEDED'
					exec_file.delete_file()
					# Time limit exceeded
					yield { status: 6, data: { completed: completed, total: total_cases, run_times: run_times } }
					return

		exec_file.delete_file()
		# Completed successfully
		yield { status: 4, data: { completed: completed, total: total_cases, run_times: run_times } }

module.exports = {
	Executer: Executer
}
