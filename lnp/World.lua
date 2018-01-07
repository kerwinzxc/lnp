require 'game.core.utils'

local World = class('LNP.WORLD')

function World:ctor( ... )
	self.objs = {}

	self.damping = 0.999
end

function World:addObj( obj )
	self.objs[obj] = true
end

function World:removeObj( obj )
	self.objs[obj] = nil
end

function World:update( dt )
	for obj, _ in pairs(self.objs) do
		obj:update(dt, self)
	end
end

return World