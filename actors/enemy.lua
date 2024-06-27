local Object = require "libs/classic"
local Enemy = Object:extend()

function Enemy:new()
	self.image = love.graphics.newImage("images/snake.png")
	self.x = 325
	self.y = love.graphics.getHeight() - 150
	self.speed = 100
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	self.sound = love.audio.newSource("sounds/enemy_hit.wav", "static")
end

function Enemy:update(dt)
	--Enemy movement
	local window_width = love.graphics.getWidth()
	self.x = self.x + self.speed * dt

	if self.x < 0 then
		self.x = 0
		self.speed = -self.speed
	elseif self.x + self.width > window_width then
		self.x = window_width - self.width
		self.speed = -self.speed
	end
end

function Enemy:draw()
	love.graphics.draw(self.image, math.floor(self.x), math.floor(self.y))
end

return Enemy
