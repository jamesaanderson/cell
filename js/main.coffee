WIDTH = window.innerWidth
HEIGHT = window.innerHeight

game = virusSprite = playerSprite = bacteriaSprite = viruses = bacteria = player = input = score = undefined

main = ->
  game = new Game(WIDTH, HEIGHT)
  input = new InputHandler()

  img = new Image()
  $(img).on 'load',  ->
    virusSprite = new Sprite(this, 0, 0, 44, 52)
    playerSprite = new Sprite(this, 45, 0, 48, 52)
    bacteriaSprite = new Sprite(this, 94, 0, 80, 52)
    cellSprite = new Sprite(this, 245, 0, 28, 28)

    init()
    run()
  img.src = 'img/sprites.png'

init = ->
  player = new Entity(playerSprite, (WIDTH-playerSprite.w)/2, HEIGHT-playerSprite.h)

  viruses = []
  bacteria = []
  _(10).times ->
    viruses.push(new Entity(
      virusSprite,
      Math.floor(Math.random()*(WIDTH-virusSprite.w)),
      Math.floor(Math.random()*((HEIGHT-virusSprite.h)/1.5))
    ))

    bacteria.push(new Entity(
      bacteriaSprite,
      Math.floor(Math.random()*(WIDTH-bacteriaSprite.w)),
      Math.floor(Math.random() * ((HEIGHT-bacteriaSprite.h)/1.5))
    ))

  setInterval (->
    if viruses.length + bacteria.length < 30
      viruses.push(new Entity(
        virusSprite,
        Math.floor(Math.random()*(WIDTH-virusSprite.w)),
        Math.floor(Math.random()*((HEIGHT-virusSprite.h)/1.5))
      ))

      bacteria.push(new Entity(
        bacteriaSprite,
        Math.floor(Math.random()*(WIDTH-bacteriaSprite.w)),
        Math.floor(Math.random()*((HEIGHT-bacteriaSprite.h)/1.5))
      ))
    ), 5000

run = ->
  gameLoop = ->
    update()
    render()

    window.requestAnimationFrame(gameLoop, game.canvas)
  window.requestAnimationFrame(gameLoop, game.canvas)

update = ->
  player.y -= 5 if input.isDown(38) or input.isDown(87) # Up/W
  player.y += 5 if input.isDown(40) or input.isDown(83) # Down/S
  player.x -= 5 if input.isDown(37) or input.isDown(65) # Left/A
  player.x += 5 if input.isDown(39) or input.isDown(68) # Right/D

  player.x = Math.max(Math.min(player.x, WIDTH-virusSprite.w), 0)
  player.y = Math.max(Math.min(player.y, HEIGHT-virusSprite.h), 0)

  _(bacteria).each (bacterium) ->
    index = _.indexOf(bacteria, bacterium)
    bacteria.splice(index, 1) if bacterium.isCollision(player)

  _(viruses).each (virus) ->
    init() if virus.isCollision(player)

render = ->
  game.clear()

  game.drawSprite(virus.sprite, virus.x, virus.y) for virus in viruses
  game.drawSprite(bacterium.sprite, bacterium.x, bacterium.y) for bacterium in bacteria
  game.drawSprite(player.sprite, player.x, player.y)

main()
