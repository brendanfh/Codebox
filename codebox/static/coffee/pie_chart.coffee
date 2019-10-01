$(document).ready ->
    $('piechart').each (_, p) ->
        $p = $ p

        wait_time = $p.attr 'data-anim-wait'
        if wait_time? and wait_time > 0
            await new Promise (res) -> setTimeout res, wait_time

        segments = $p.attr 'data-segments'
        size = ($p.attr 'data-size') || 256

        canvas = document.createElement "canvas"
        canvas.width = size
        canvas.height = size
        $p.append canvas
        ctx = canvas.getContext "2d"

        total = 0
        for i in [1..segments]
            total += parseInt ($p.attr "data-segment-#{i}")

        half_size = size / 2
        fill_perc = 0.01
        anim = ->
            acc = 0
            for i in [1..segments]
                ratio = (parseInt ($p.attr "data-segment-#{i}")) * fill_perc
                color = $p.attr "data-segment-#{i}-color"

                ctx.beginPath()
                ctx.moveTo half_size, half_size
                ctx.arc half_size, half_size, half_size, (-2 * Math.PI * (ratio + acc) / total), (-2 * Math.PI * acc / total)
                ctx.closePath()
                ctx.fillStyle = color
                ctx.fill()

                acc += ratio

            fill_perc += fill_perc / 10 + 0.01

            if fill_perc >= 1
                fill_perc = 1
                window.requestAnimationFrame anim

            if fill_perc < 1
                window.requestAnimationFrame anim

        window.requestAnimationFrame anim

