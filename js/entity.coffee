class Entity
  constructor: (@sprite, @x, @y) ->
    @w = @sprite.w
    @h = @sprite.h

  isCollision: (ent) ->
    @x < ent.x+ent.w && ent.x < @x+@w && @y < ent.y+ent.h && ent.y < @y+@h
