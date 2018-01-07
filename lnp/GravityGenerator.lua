local Vec2 = require 'lnp.math.Vec2'


local ForceGenerator = require 'lnp.ForceGenerator'

local GravityGenerator = class('GravityGenerator', ForceGenerator)

function GravityGenerator:update( obj, dt )
	if not obj:isInfiniteMass() then
		local force = Vec2:create(0, -1)
		force:mulInPlace(obj:getMass() * self.g)
		obj:addForce(force)
	end
end

function GravityGenerator:ctor( g )
	self.g = g or 9.8
end

return GravityGenerator