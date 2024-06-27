local Object = require "libs/classic"
local Player = Object:extend()

function Player:new()
	self.image = love.graphics.newImage("images/panda.png")
	self.x = 300
	self.y = 20
	self.speed = 500
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	self.sound = love.audio.newSource("sounds/shoot.wav", "static")
end

function Player:update(dt)
	--Horizontal player movement
	if love.keyboard.isDown("left") then
		self.x = self.x - self.speed * dt
	elseif love.keyboard.isDown("right") then
		self.x = self.x + self.speed * dt
	end

	local window_width = love.graphics.getWidth()

	--Screen border collision
	if self.x < 0 then
		self.x = 0
	elseif self.x + self.width > window_width then
		self.x = window_width - self.width
	end
end

function Player:keyPressed(key)
	--Add bullets
	if key == "space" then
		table.insert(listOfBullets, Bullet(self.x + (self.width / 2), self.y + self.height))
		self.sound:play()
	end
end


function Player:draw()
	love.graphics.draw(self.image, math.floor(self.x), math.floor(self.y))
end
return Player
