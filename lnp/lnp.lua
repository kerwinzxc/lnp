local LNP = class('LNP')

function LNP:ctor( ... )
	-- body
end

function LNP:createObj( ... )
	return require('lnp.Obj'):create()
end

function LNP:createWorld( ... )
	return require('lnp.World'):create()
end

return LNP