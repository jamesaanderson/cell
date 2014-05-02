WIDTH = window.innerWidth
HEIGHT = window.innerHeight

game = virusSprite = cellSprite = bacteriaSprite = viruses = bacteria = cell = input = undefined

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
  cell = new Entity(cellSprite, (WIDTH-cellSprite.w)/2, HEIGHT-cellSprite.h)

  viruses = []
  bacteria = []
  for i in [0..10]
    viruses.push(new Entity(
      virusSprite,
      Math.floor(
        Math.random() * (WIDTH-virusSprite.w)
      ),
      Math.floor(
        Math.random() * ((HEIGHT-virusSprite.h)/2)
      )
    ))

    bacteria.push(new Entity(
      bacteriaSprite,
      Math.floor(
        Math.random() * (WIDTH-bacteriaSprite.w)
      ),
      Math.floor(
        Math.random() * ((HEIGHT-bacteriaSprite.h)/2)
      )
    ))

run = ->
  gameLoop = ->
    update()
    render()

    window.requestAnimationFrame(gameLoop, game.canvas)
  window.requestAnimationFrame(gameLoop, game.canvas)

update = ->
  if input.isDown(38) # Up
    cell.y -= 5
  else if input.isDown(40) # Down
    cell.y += 5
  else if input.isDown(37) # Left
    cell.x -= 5
  else if input.isDown(39) # Right
    cell.x += 5

  cell.x = Math.max(Math.min(cell.x, WIDTH-virusSprite.w), 0)
  cell.y = Math.min(cell.y, HEIGHT-virusSprite.h)

  i = 0
  while i < bacteria.length
    bacteria.splice(i, 1) if game.isCollision(bacteria[i], cell)

    i++

render = ->
  game.clear()

  game.drawSprite(virus.sprite, virus.x, virus.y) for virus in viruses
  game.drawSprite(bacterium.sprite, bacterium.x, bacterium.y) for bacterium in bacteria
  game.drawSprite(cell.sprite, cell.x, cell.y)

main()
