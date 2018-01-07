local PhysicsNode = require 'test-lnp.PhysicsNode'

local StringNode = class('StringNode', PhysicsNode)

function StringNode:ctor( nodeA, nodeB )
	PhysicsNode.ctor(self)
	self.drawNode = cc.DrawNode:create()
	self.nodeA = nodeA
	self.nodeB = nodeB
	self:addChild(self.drawNode)
end

function StringNode:updateView( ... )
	-- body
	local pa = self:convertToNodeSpace(self.nodeA:convertToWorldSpace(cc.p(0, 0)))
	local pb = self:convertToNodeSpace(self.nodeB:convertToWorldSpace(cc.p(0, 0)))

	self.drawNode:clear()
	self.drawNode:drawLine(
		cc.p(pa.x, pa.y),
		cc.p(pb.x, pb.y),
		cc.c4f(1,1,1,1)
	)
end

return StringNode