local Vec2 = require 'lnp.math.Vec2'

local Obj = class('LNP.OBJ')

function Obj:ctor( ... )
	self.pos = Vec2:create(0, 0)
	self.velocity = Vec2:create(0, 0)
	self.forceGenerators = {}
	self.massInverse = 0
	self.force = Vec2:create(0, 0)
end

function Obj:isInfiniteMass( ... )
	return self.massInverse == 0
end

function Obj:getMass( ... )
	if not self:isInfiniteMass() then
		return 1/self.massInverse
	end
end

function Obj:setPos( pos )
	self.pos.x = pos.x
	self.pos.y = pos.y
end

function Obj:setVelocity( v )
	self.velocity.x = v.x
	self.velocity.y = v.y
end

function Obj:setMass( mass )
	self.massInverse = 1 / mass
end

function Obj:setMassInverse( massInverse )
	self.massInverse = massInverse
end

function Obj:getPos( ... )
	return {x = self.pos.x, y = self.pos.y}
end

function Obj:update( dt , world)
	self.force = Vec2:create(0, 0)
	self:calcForce(dt)
	local acceleration = self.force:mul(self.massInverse)
	self.velocity:addInPlace(acceleration:mul(dt))
	self.pos:addInPlace(self.velocity:mul(dt))
	self.velocity:mulInPlace(world.damping)
end

function Obj:registerForceGenerator( fg )
	table.insert(self.forceGenerators, fg)
end

function Obj:unregisterForceGenerator( fg )
	table.removeValue(self.forceGenerators, fg)
end

function Obj:calcForce( dt )
	for _, fg in ipairs(self.forceGenerators) do
		fg:update(self, dt)
	end
end

function Obj:addForce( f )
	self.force:addInPlace(f)
end

return Obj