local PhysicsNode = require 'test-lnp.PhysicsNode'

local Ball = class('Ball', PhysicsNode)

function Ball:ctor( ... )
	PhysicsNode.ctor(self, ...)

	self.drawNode = cc.DrawNode:create()
	self.drawNode:drawSolidCircle(cc.p(0, 0), 10, 0, 32, cc.c4f(1, 1, 1, 1))
	self:addChild(self.drawNode)

	self.physicsObj:setMass(4)
end

function Ball:updateView( ... )
	local pos = self.physicsObj:getPos()
	self:setPosition(cc.p(pos.x, pos.y))
end

return Ball