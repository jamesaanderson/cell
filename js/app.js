// Generated by CoffeeScript 1.7.1
var HEIGHT, WIDTH, bacteria, bacteriaSprite, cell, cellSprite, game, init, input, main, render, run, update, virusSprite, viruses;

WIDTH = window.innerWidth;

HEIGHT = window.innerHeight;

game = virusSprite = cellSprite = bacteriaSprite = viruses = bacteria = cell = input = void 0;

main = function() {
  var img;
  game = new Game(WIDTH, HEIGHT);
  input = new InputHandler();
  img = new Image();
  $(img).on('load', function() {
    virusSprite = new Sprite(this, 0, 0, 44, 52);
    cellSprite = new Sprite(this, 45, 0, 48, 52);
    bacteriaSprite = new Sprite(this, 94, 0, 80, 52);
    init();
    return run();
  });
  return img.src = 'img/sprites.png';
};

init = function() {
  var i, _results;
  cell = new Entity(cellSprite, (WIDTH - cellSprite.w) / 2, HEIGHT - cellSprite.h);
  viruses = [];
  bacteria = [];
  i = 0;
  _results = [];
  while (i < 10) {
    i++;
    viruses.push(new Entity(virusSprite, Math.floor(Math.random() * (WIDTH - virusSprite.w)), Math.floor(Math.random() * ((HEIGHT - virusSprite.h) / 2))));
    _results.push(bacteria.push(new Entity(bacteriaSprite, Math.floor(Math.random() * (WIDTH - bacteriaSprite.w)), Math.floor(Math.random() * ((HEIGHT - bacteriaSprite.h) / 2)))));
  }
  return _results;
};

run = function() {
  var gameLoop;
  gameLoop = function() {
    update();
    render();
    return window.requestAnimationFrame(gameLoop, game.canvas);
  };
  return window.requestAnimationFrame(gameLoop, game.canvas);
};

update = function() {
  var i, _results;
  if (input.isDown(38)) {
    cell.y -= 5;
  } else if (input.isDown(40)) {
    cell.y += 5;
  } else if (input.isDown(37)) {
    cell.x -= 5;
  } else if (input.isDown(39)) {
    cell.x += 5;
  }
  cell.x = Math.max(Math.min(cell.x, WIDTH - virusSprite.w), 0);
  cell.y = Math.min(cell.y, HEIGHT - virusSprite.h);
  i = 0;
  _results = [];
  while (i < bacteria.length) {
    if (game.isCollision(bacteria[i], cell)) {
      bacteria.splice(i, 1);
    }
    _results.push(i++);
  }
  return _results;
};

render = function() {
  var bacterium, virus, _i, _j, _len, _len1;
  game.clear();
  for (_i = 0, _len = viruses.length; _i < _len; _i++) {
    virus = viruses[_i];
    game.drawSprite(virus.sprite, virus.x, virus.y);
  }
  for (_j = 0, _len1 = bacteria.length; _j < _len1; _j++) {
    bacterium = bacteria[_j];
    game.drawSprite(bacterium.sprite, bacterium.x, bacterium.y);
  }
  return game.drawSprite(cell.sprite, cell.x, cell.y);
};

main();
