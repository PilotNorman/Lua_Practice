Class = require 'class'
require 'Bird'

WINDOW_WIDTH = 512
WINDOW_HEIGHT = 288

local background = love.graphics.newImage('background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('ground.png')
local groundScroll = 0

local BACKGROUND_SCOLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUNG_LOOPING_POINT = 413

local bird = Bird()

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  love.window.setTitle('Fifty Bird')
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })

  love.keyboard.keysPressed = {}
end

function love.keypressed(key)
  love.keyboard.keysPressed[key] = true

  if key == 'escape' then
    love.event.quit()
  end
end

function love.keyboard.wasPressed(key)
  if love.keyboard.keysPressed[key] then
    return true
  else
    return false
  end
end

function love.update(dt)
  backgroundScroll = (backgroundScroll + BACKGROUND_SCOLL_SPEED * dt) % BACKGROUNG_LOOPING_POINT
  groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % WINDOW_WIDTH

  bird:update(dt)

  love.keyboard.keysPressed = {}
end

function love.draw()
  love.graphics.draw(background, -backgroundScroll, 0)
  love.graphics.draw(ground, -groundScroll, WINDOW_HEIGHT - 16)
  bird:render()
end