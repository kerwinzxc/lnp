local Vec = class('LNP.MATH.VEC2')

function Vec:ctor( x, y )
	self.x = x
	self.y = y
end

function Vec:length( ... )
	return math.sqrt(self.x*self.x + self.y*self.y)
end

function Vec:length2( ... )
	return self.x*self.x + self.y*self.y
end

function Vec:clone( ... )
	return Vec:create(self.x, self.y)
end

function Vec:normalized( ... )
	local length2 = self:length2()
	if length2 > 0 then
		local len = math.sqrt(length2)
		self.x = self.x / len
		self.y = self.y / len
	end
end

function Vec:normalize( ... )
	local ret = self:clone()
	ret:normalized()
	return ret
end

function Vec:add( other )
	local ret = self:clone()
	ret:addInPlace(other)
	return ret
end

function Vec:addInPlace( other )
	self.x = self.x + other.x
	self.y = self.y + other.y
end

function Vec:sub( other )
	local ret = self:clone()
	ret:subInPlace(other)
	return ret
end

function Vec:subInPlace( other )
	self.x = self.x - other.x
	self.y = self.y - other.y
end

function Vec:mulInPlace( scale )
	self.x = self.x * scale
	self.y = self.y * scale
end

function Vec:mul( scale )
	local ret = self:clone()
	ret:mulInPlace(scale)
	return ret
end

function Vec:dot( other )
	return self.x*other.x + self.y*other.y
end

return Vec