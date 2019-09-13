$(document).ready ->
    $('piechart').each (_, p) ->
        $p = $ p
        segments = $p.attr 'data-segments'

        canvas = document.createElement "canvas"
        canvas.width = 256
        canvas.height = 256
        $p.append canvas
        ctx = canvas.getContext "2d"

        total = 0
        for i in [1..segments]
            total += parseInt ($p.attr "data-segment-#{i}")
        
        fill_perc = 0

        anim = ->
            acc = 0
            for i in [1..segments]
                ratio = (parseInt ($p.attr "data-segment-#{i}")) * fill_perc
                color = $p.attr "data-segment-#{i}-color"

                ctx.beginPath()
                ctx.moveTo 128, 128
                ctx.arc 128, 128, 128, (-2 * Math.PI * (ratio + acc) / total), (-2 * Math.PI * acc / total)
                ctx.closePath()
                ctx.fillStyle = color
                ctx.fill()

                acc += ratio

            fill_perc += 0.05

            if fill_perc >= 1
                fill_perc = 1
                window.requestAnimationFrame anim

            if fill_perc < 1
                window.requestAnimationFrame anim
        
        window.requestAnimationFrame anim

