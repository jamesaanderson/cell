class Game
  constructor: (@width, @height) ->
    @canvas = document.createElement('canvas')
    @canvas.width = @width
    @canvas.height = @height
    @ctx = @canvas.getContext('2d')

    $('body').append(@canvas)

  clear: ->
    @ctx.clearRect(0, 0, @width, @height)

  drawSprite: (sp, x, y) ->
    @ctx.drawImage(sp.img, sp.x, sp.y, sp.w, sp.h, x, y, sp.w, sp.h)
