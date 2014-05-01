WIDTH = window.innerWidth
HEIGHT = window.innerHeight

game = undefined
virusSprite = undefined
cellSprite = undefined
bacteriaSprite = undefined
viruses = undefined
bacteria = undefined
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
  cell = new Player(cellSprite, (WIDTH-cellSprite.w)/2, HEIGHT-cellSprite.h)

  viruses = []
  bacteria = []
  i = 0
  while i < 10
    i++

    viruses.push(new Player(
      virusSprite,
      Math.floor(
        Math.random() * (WIDTH-virusSprite.w)
      ),
      Math.floor(
        Math.random() * ((HEIGHT-virusSprite.h)/2)
      )
    ))

    bacteria.push(new Player(
      bacteriaSprite,
      Math.floor(
        Math.random() * (WIDTH-bacteriaSprite.w)
      ),
      Math.floor(
        Math.random() * ((HEIGHT-bacteriaSprite.h)/2)
      )
    ))

run = ->
  repeat = ->
    update()
    render()

    window.requestAnimationFrame(repeat, game.canvas)
  window.requestAnimationFrame(repeat, game.canvas)

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

render = ->
  game.clear()

  game.drawSprite(virus.sprite, virus.x, virus.y) for virus in viruses
  game.drawSprite(bacterium.sprite, bacterium.x, bacterium.y) for bacterium in bacteria
  game.drawSprite(cell.sprite, cell.x, cell.y)

main()
