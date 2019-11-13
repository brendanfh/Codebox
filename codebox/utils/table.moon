table.contains = (t, v) ->
    for a in *t
        return true if a == v
    return false

table.filter = (t, p) ->
	for i, a in ipairs t
		if not p(a)
			table.remove t, i
