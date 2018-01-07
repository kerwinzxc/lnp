local PhysicsNode = require 'test-lnp.PhysicsNode'
local Ball = require 'test-lnp.Ball'
local StringNode = require 'test-lnp.StringNode'
local GravityGenerator = require 'lnp.GravityGenerator'
local InputGenerator = require 'lnp.InputGenerator'
local SpringGenerator = require 'lnp.SpringGenerator'

local keyCache = {}

local function __handleKeyPress( key , ...)
	print(key, ...)
	keyCache[key] = true
end

local function __handleReleasePress( key )
	keyCache[key] = nil
end


local gravityGen = GravityGenerator:create(0)
local InputGen = InputGenerator:create(function ( key )
	return keyCache[key]
end)


local director = cc.Director:getInstance()
local scene = cc.Scene:create()
director:pushScene(scene)

local inputLayer = cc.Layer:create()
scene:addChild(inputLayer)
local keyboardListener = cc.EventListenerKeyboard:create()
keyboardListener:registerScriptHandler(__handleKeyPress, cc.Handler.EVENT_KEYBOARD_PRESSED)
keyboardListener:registerScriptHandler(__handleReleasePress, cc.Handler.EVENT_KEYBOARD_RELEASED)

director:getEventDispatcher():addEventListenerWithSceneGraphPriority(keyboardListener, inputLayer)


local function __update( dt )
	PhysicsNode:updateAll(dt)
	PhysicsNode:updateViewAll()
end

director:getScheduler():scheduleScriptFunc(function ( dt )
	__update(dt)
end, 0, false)


local ball2 = Ball:create()
ball2:getPhyObj():registerForceGenerator(gravityGen)
ball2:getPhyObj():setPos({x = 300, y = 400})
ball2:getPhyObj():setMassInverse(0)

local ball = Ball:create()
ball:getPhyObj():registerForceGenerator(SpringGenerator:create(ball2:getPhyObj(), 100, 100))
ball:getPhyObj():registerForceGenerator(gravityGen)
ball:getPhyObj():setPos({x = 300, y = 300})
ball:getPhyObj():setVelocity({x = 650, y = 780})

ball2:getPhyObj():registerForceGenerator(SpringGenerator:create(ball:getPhyObj(), 100, 100))

local ball3 = Ball:create()
ball3:getPhyObj():registerForceGenerator(SpringGenerator:create(ball:getPhyObj(), 100, 100))
ball3:getPhyObj():registerForceGenerator(gravityGen)
ball3:getPhyObj():registerForceGenerator(InputGen)
ball3:getPhyObj():setPos({x = 200, y = 100})
ball3:getPhyObj():setMassInverse(0)

ball:getPhyObj():registerForceGenerator(SpringGenerator:create(ball3:getPhyObj(), 100, 100))


scene:addChild(ball)
scene:addChild(ball3)
scene:addChild(ball2)
scene:addChild(StringNode:create(ball, ball2))
scene:addChild(StringNode:create(ball, ball3))

