->
	math.randomseed os.time!
	return ->
		template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
		return string.gsub template, '[xy]', (c) ->
			v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
			string.format '%x', v