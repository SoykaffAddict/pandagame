function love.load()
	Player = require "actors/player"
	Enemy = require "actors/enemy"
	Bullet = require "actors/bullet"

	--Screen resolution [affects game]
	love.window.setMode(1366, 768, {fullscreen = false, resizable = true})

	--Get screen center
	width = love.graphics.getWidth() / 2
	height = love.graphics.getHeight() / 2

	--Font configuration
	font = love.graphics.newFont(64)
	love.graphics.setFont(font)

	--Actors instance
	player = Player()
	enemy = Enemy()
	listOfBullets = {}

	--Change background color to light pink
	love.graphics.setBackgroundColor(0.9, 0.82, 0.87)

	--Mechanics conditions
	score = 0				--Player score
	enemy_timer = false		--Controls enemy colored time on hit
	restart = false			--Controls asking for restart on missed bullet	
end

local frame = 0
function love.update(dt)
	player:update(dt)
	enemy:update(dt)

	--Updates game score
	text = "Score: " .. score
	vcenter_font = font:getHeight(text) / 2
	hcenter_font = font:getWidth(text) / 2

	--Checks fired bullets
	for k, v in ipairs(listOfBullets) do
		v:update(dt)
		v:checkCollision(enemy)

		--If bullet connect plays sfx, add to score and change color
		if v.dead then
			table.remove(listOfBullets, k)
			score = score + 1
			enemy.sound:play()
			enemy_timer = true
		end

		--Change score text to restart on miss
		if v.y > love.graphics.getHeight() then
			restart = true
		end

	end
	
	--Enemy color change timer
	if enemy_timer == true and 15 > frame then
		frame = frame + 1
	else
		frame = 0
		enemy_timer = false
	end
end

function love.keypressed(key)
	--Check player keys
	player:keyPressed(key)

	--Restart
	if key == "r" then
		love.load()
	end
end

function love.draw()
	player:draw()

	--Enemy color change
	if enemy_timer then
		love.graphics.setColor(1, 0, 0)
		enemy:draw()
	else
		love.graphics.setColor(1, 1, 1)
		enemy:draw()
	end

	--Renders score text 
	if not restart then
		love.graphics.setColor(0, 0, 0)
		love.graphics.print(text, width - (hcenter_font * 0.99), height - (vcenter_font * 0.9))
		love.graphics.setColor(0.9, 0.9, 0.9)
		love.graphics.print(text, width - hcenter_font , height - vcenter_font)
	else
		--Empty players function when failed
		function player:update()
		end
		function player:keyPressed()
		end

		--Restart text configuration
		local text = "Press R to restart"
		local vcenter_font = font:getHeight(text) / 2
		local hcenter_font = font:getWidth(text) / 2

		--Restart text render
		love.graphics.setColor(0, 0, 0)
		love.graphics.print(text, width - (hcenter_font * 0.99), height - (vcenter_font * 0.9))
		love.graphics.setColor(0.9, 0.9, 0.9)
		love.graphics.print(text, width - hcenter_font , height - vcenter_font)
	end

	for k, v in ipairs(listOfBullets) do
		v:draw()
	end
end
