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
