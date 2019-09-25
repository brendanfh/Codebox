table.contains = (t, v) ->
    for a in *t
        return true if a == v
    return false
