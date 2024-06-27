function love.conf(t)
	t.window.title = "Panda Shooter!"
	t.window.icon = "images/panda.png"
	t.modules.joystick = false
    t.modules.physics = false
	t.version = "11.5"
	t.window.setVsync = 1
end
