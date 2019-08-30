{ BaseCompiler } = require './base_compiler'
{ TempFile } = require '../temp_file'

{ spawn } = require 'child_process'
{ on_child_exit } = require '../child_process'

class CCompiler extends BaseCompiler
	compile: (code) ->
		source_file = new TempFile code, 'c'
		exec_file = new TempFile()

		compiler_process = spawn 'gcc', [
			'-Wall',
			'-O2',
			source_file.file_path,
			'./app/compilers/secure/seccomp.c',
			'-lseccomp',
			'-std=c11',
			'-o',
			exec_file.file_path
		]

		compiler_output = ""
		compiler_process.stderr.on 'data', (data) -> compiler_output += data.toString()

		result_code = await on_child_exit(compiler_process)

		source_file.delete_file()
		if result_code == 0
			return exec_file
		else
			exec_file.delete_file()
			throw compiler_output

module.exports = {
	CCompiler: CCompiler
}
