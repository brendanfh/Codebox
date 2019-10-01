require 'utils.string'

-> {
    -- Assumes time is formmated like:
    --      YYYY-MM-DD HH:MM:SS
    time_to_number: (timestamp) ->
        {date, time} = string.split timestamp, " "

        {year, month, day} = string.split date, "-"
        {hour, minute, second} = string.split time, ":"

        return os.time
            year: tonumber(year)
            month: tonumber(month)
            day: tonumber(day)
            hour: tonumber(hour)
            min: tonumber(minute)
            sec: tonumber(second)
}
