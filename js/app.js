// Generated by CoffeeScript 1.7.1
(function() {
  $(function() {
    var Game, HEIGHT, InputHandler, Sprite, WIDTH, bacteria, bacteriaSprite, cell, cellSprite, game, init, input, main, render, run, update, virusSprite, viruses;
    Game = (function() {
      function Game(width, height) {
        this.width = width;
        this.height = height;
        this.canvas = document.createElement('canvas');
        this.canvas.width = this.width;
        this.canvas.height = this.height;
        this.ctx = this.canvas.getContext('2d');
        $('body').append(this.canvas);
      }

      Game.prototype.clear = function() {
        return this.ctx.clearRect(0, 0, this.width, this.height);
      };

      Game.prototype.drawSprite = function(sp, x, y) {
        return this.ctx.drawImage(sp.img, sp.x, sp.y, sp.w, sp.h, x, y, sp.w, sp.h);
      };

      return Game;

    })();
    Sprite = (function() {
      function Sprite(img, x, y, w, h) {
        this.img = img;
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
      }

      return Sprite;

    })();
    InputHandler = (function() {
      function InputHandler() {
        var _this;
        this.down = {};
        _this = this;
        $(document).on('keydown', function(e) {
          return _this.down[e.keyCode] = true;
        });
        $(document).on('keyup', function(e) {
          return delete _this.down[e.keyCode];
        });
      }

      InputHandler.prototype.isDown = function(code) {
        return this.down[code];
      };

      return InputHandler;

    })();
    WIDTH = window.innerWidth;
    HEIGHT = window.innerHeight;
    game = void 0;
    virusSprite = void 0;
    cellSprite = void 0;
    bacteriaSprite = void 0;
    viruses = void 0;
    bacteria = void 0;
    cell = void 0;
    input = void 0;
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
      cell = {
        sprite: cellSprite,
        x: (WIDTH - cellSprite.w) / 2,
        y: HEIGHT - cellSprite.h
      };
      viruses = [];
      bacteria = [];
      i = 0;
      _results = [];
      while (i < 10) {
        i++;
        viruses.push({
          sprite: virusSprite,
          x: Math.floor(Math.random() * (WIDTH - virusSprite.w)),
          y: Math.floor(Math.random() * ((HEIGHT - virusSprite.h) / 2))
        });
        _results.push(bacteria.push({
          sprite: bacteriaSprite,
          x: Math.floor(Math.random() * (WIDTH - bacteriaSprite.w)),
          y: Math.floor(Math.random() * ((HEIGHT - bacteriaSprite.h) / 2))
        }));
      }
      return _results;
    };
    run = function() {
      var repeat;
      repeat = function() {
        update();
        render();
        return window.requestAnimationFrame(repeat, game.canvas);
      };
      return window.requestAnimationFrame(repeat, game.canvas);
    };
    update = function() {
      if (input.isDown(38)) {
        cell.y -= 10;
      } else if (input.isDown(40)) {
        cell.y += 10;
      } else if (input.isDown(37)) {
        cell.x -= 10;
      } else if (input.isDown(39)) {
        cell.x += 10;
      }
      return cell.x = Math.max(Math.min(cell.x, WIDTH - virusSprite.w), 0);
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
    return main();
  });

}).call(this);
