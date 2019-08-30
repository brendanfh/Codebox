class OutputMatcher
	constructor: (@line) ->

	test: (str) ->
		str is @line

class RegexOutputMatcher extends OutputMatcher
	constructor: (line) ->
		super ""
		@regex = new RegExp line

	test: (str) ->
		@regex.test str

module.exports = {
	make_matcher: (line) ->
		match = /__REGEXP\((.+)\)$/.exec line

		if match?
			new RegexOutputMatcher match[1]
		else
			new OutputMatcher line
}
