require "pulse"

player = {}
player.radius = 20
player.pulse_array = {}

function player:init( world )
	self.body = love.physics.newBody( world, 0, 0, "dynamic" )
	self.shape = love.physics.newCircleShape( self.radius )
	self.fixture = love.physics.newFixture( self.body, self.shape, 1 )
	self.fixture:setRestitution(0)
end

function player:x()
	return self.body:getX()
end

function player:y()
	return self.body:getY()
end

function player:update(dt)

	local vel = 300
	local x_vel = 0
	local y_vel = 0

	if love.keyboard.isScancodeDown("right") then
		x_vel = x_vel + vel
	end
	if love.keyboard.isScancodeDown("left") then
		x_vel = x_vel - vel
	end
	if love.keyboard.isScancodeDown("up") then
		y_vel = y_vel - vel
	end
	if love.keyboard.isScancodeDown("down") then
		y_vel = y_vel + vel
	end

	self.body:setLinearVelocity( x_vel, y_vel )

	-- update all pulses
	for i,v in ipairs(self.pulse_array) do
		if v then
			self.pulse_array[i]:update(dt)
		end
	end

	-- remove pulses that are deada
	for i = 1, #self.pulse_array do
		if self.pulse_array[i] ~= nil and self.pulse_array[i].dead == true then
			table.remove( self.pulse_array, i )
		end
	end

	-- local p = 1
	-- while p <= #self.pulse_array do
	-- 	if self.pulse_array[p].dead then
	-- 		table.remove( self.pulse_array[p] )
	-- 	else
	-- 		p = p + 1
	-- 	end
	-- end
end

function player:draw()
	love.graphics.circle("line", self:x(), self:y(), self.radius )
end

function player:draw_pulses()
	-- draw all pulses
	for i,v in ipairs(self.pulse_array) do
		self.pulse_array[i]:draw()
	end
end

function player:pulse()
	table.insert( self.pulse_array, Pulse:new(player:x(), player:y(), 2, 10, 0, 0, 255) )
	print( #self.pulse_array )
end