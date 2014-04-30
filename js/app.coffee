$ ->
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

  class Sprite
    constructor: (@img, @x, @y, @w, @h) ->

  class InputHandler
    constructor: ->
      @down = {}

      _this = this
      $(document).on 'keydown', (e) ->
        _this.down[e.keyCode] = true
      $(document).on 'keyup', (e) ->
        delete _this.down[e.keyCode]

    isDown: (code) ->
      @down[code]

  WIDTH = window.innerWidth
  HEIGHT = window.innerHeight

  game = undefined
  virusSprite = undefined
  cellSprite = undefined
  bacteriaSprite = undefined
  viruses = undefined
  cell = undefined
  input = undefined

  main = ->
    game = new Game(WIDTH, HEIGHT)
    input = new InputHandler()

    img = new Image()
    $(img).on 'load',  ->
      virusSprite = new Sprite(this, 0, 0, 44, 52)
      cellSprite = new Sprite(this, 45, 0, 48, 52)
      bacteriaSprite = new Sprite(this, 94, 0, 80, 52)

      init()
      run()
    img.src = 'img/sprites.png'

  init = ->
    cell = {
      sprite: cellSprite,
      x: (WIDTH-cellSprite.w)/2,
      y: HEIGHT-cellSprite.h
    }

    viruses = []
    i = 0
    while i < 10
      i++
      viruses.push(
        sprite: virusSprite,
        x: Math.floor(Math.random()*(WIDTH-virusSprite.w)),
        y: Math.floor(Math.random()*((HEIGHT-virusSprite.h)/2))
      )

  run = ->
    repeat = ->
      update()
      render()

      window.requestAnimationFrame(repeat, game.canvas)
    window.requestAnimationFrame(repeat, game.canvas)

  update = ->
    if input.isDown(38) # Up
      cell.y -= 10
    else if input.isDown(40) # Down
      cell.y += 10
    else if input.isDown(37) # Left
      cell.x -= 10
    else if input.isDown(39) # Right
      cell.x += 10

  render = ->
    game.clear()

    game.drawSprite(virus.sprite, virus.x, virus.y) for virus in viruses
    game.drawSprite(cell.sprite, cell.x, cell.y)

  main()
