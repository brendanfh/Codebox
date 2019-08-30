fs = require 'fs'
path = require 'path'
genUUID = require 'uuid/v4'

class TempFile
	constructor: (contents, extension = "tmp") ->
		@file_name = "temp-#{genUUID()}.#{extension}"
		@file_path = path.join '/tmp', @file_name

		if contents?
			@populate_file contents

	populate_file: (contents) ->
		fs.writeFileSync @file_path, contents

	delete_file: ->
		try
			fs.unlinkSync @file_path
		catch e
			0


module.exports = {
	TempFile: TempFile
}
