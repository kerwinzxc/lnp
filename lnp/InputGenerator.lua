

local Vec2 = require 'lnp.math.Vec2'


local ForceGenerator = require 'lnp.ForceGenerator'

local InputGenerator = class('InputGenerator', ForceGenerator)

function InputGenerator:update( obj, dt )
	if not obj:isInfiniteMass() then
		if self.checkKeyFunc(26) then
			obj:addForce(Vec2:create(-100000, 0):mul(dt))
		end
		if self.checkKeyFunc(27) then
			obj:addForce(Vec2:create(100000, 0):mul(dt))
		end

		if self.checkKeyFunc(28) then
			obj:addForce(Vec2:create(0, 100000):mul(dt))
		end
		if self.checkKeyFunc(29) then
			obj:addForce(Vec2:create(0, -100000):mul(dt))
		end
	
	end
end

function InputGenerator:ctor( checkKeyFunc )
	self.checkKeyFunc = checkKeyFunc
end


return InputGenerator