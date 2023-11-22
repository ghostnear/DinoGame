Assets = {}

require('lib.all')
require('objects.all')

function love.load()
    -- Pixel art game, no need to have aliasing.
    love.graphics.setDefaultFilter("nearest")

    GameState.switch(require('game.states.Loading'))
end

function love.draw()
    GameState.draw()
end

function love.update(dt)
    Timer.update(dt)
    GameState.update(dt)
end