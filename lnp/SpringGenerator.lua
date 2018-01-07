

local Vec2 = require 'lnp.math.Vec2'


local ForceGenerator = require 'lnp.ForceGenerator'

local SpringGenerator = class('SpringGenerator', ForceGenerator)

function SpringGenerator:update( obj, dt )
	if not obj:isInfiniteMass() then
		local pointA = self.otherOBJ:getPos()
		local pointB = obj:getPos()
		local pa = Vec2:create(pointA.x, pointA.y)
		local pb = Vec2:create(pointB.x, pointB.y)
		pa:subInPlace(pb)

		-- if pa:length() > obj.oriLen then

			pa:subInPlace(pa:normalize():mul(self.oriLen))
			local force = pa:mul(self.k * dt)
			obj:addForce(force)
		-- end
	end
end

function SpringGenerator:ctor( otherOBJ, oriLen, k)
	self.otherOBJ = otherOBJ
	self.oriLen = oriLen
	self.k = k
end


return SpringGenerator