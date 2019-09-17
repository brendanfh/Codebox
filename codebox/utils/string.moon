string.split = (pattern) =>
    t = {}
    for s in string.gmatch @, "([^#{pattern}]+)"
        table.insert t, s
    t