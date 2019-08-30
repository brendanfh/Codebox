{ TempFile } = require '../temp_file'

class BaseCompiler
	compile: (code) ->
		Promise.resolve (new TempFile code)

module.exports = {
	BaseCompiler: BaseCompiler
}
