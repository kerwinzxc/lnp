local lnp = require 'lnp.lnp'

local PhysicsNode = class('PhysicsNode', cc.Node)

local is_physics_init = false
local physics_world = nil

local physics_node_list = {}

local function physics_init( ... )
	physics_world = lnp:createWorld()
end

function PhysicsNode:updateAll( dt )
	physics_world:update(dt)
end

function PhysicsNode:ctor( ... )
	if not is_physics_init then
		physics_init()
		is_physics_init = true
	end
	self.physicsObj = lnp:createObj()
	
	self:registerScriptHandler(function ( evtName )
		if evtName == 'enterTransitionFinish' then
			self:onAddStage()
		elseif evtName == 'exitTransitionStart' then
			self:onRemoveStage()
		elseif evtName == 'cleanup' then
			self:dispose()
		end
	end)

	physics_node_list[self] = true
end

function PhysicsNode:updateViewAll( ... )
	for node, _ in pairs(physics_node_list) do
		node:updateView()
	end
end

function PhysicsNode:getPhyObj()
	return self.physicsObj
end

function PhysicsNode:updateView( ... )
end

function PhysicsNode:onAddStage( ... )
	physics_world:addObj(self.physicsObj)
end

function PhysicsNode:dispose( ... )
	self.physicsObj:dispose()
	self.physicsObj = nil
	physics_node_list[self] = false
end

function PhysicsNode:onRemoveStage( ... )
	physics_world:removeObj(self.physicsObj)
end

return PhysicsNode