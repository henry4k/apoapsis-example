local class   = require 'middleclass'
local Object  = class.Object
local Vec     = require 'core/Vector'
local Quat    = require 'core/Quaternion'
local Solid   = require 'core/physics/Solid'
local Model   = require 'core/graphics/Model'
local Mesh    = require 'core/graphics/Mesh'
local Texture = require 'core/graphics/Texture'
local Controllable      = require 'core/Controllable'
local WorldObject       = require 'core/world/WorldObject'
local BoxCollisionShape = require 'core/physics/BoxCollisionShape'


local boxShape = BoxCollisionShape(Vec(0.5, 0.5, 0.5))

local renderTarget    = require 'core/graphics/DefaultRenderTarget':get()
local worldCamera     = renderTarget:getCameraByName('world')
local worldModelWorld = worldCamera:getModelWorld()

local wallMesh = Mesh:load('example/Wall/Scene.json', 'Wall')
local diffuseTexture = Texture:load('2d', 'example/Diffuse.png')


local Drone = class('example/Drone', WorldObject)
Drone:include(Controllable)

local DroneMass = 1
local MaxPower = 1
local MinPower = 0.1

function Drone:initialize( position, rotation )
    WorldObject.initialize(self)

    local solid = Solid(DroneMass, position, rotation, boxShape)
    self.solid = solid

    local model = worldModelWorld:createModel()
    model:setAttachmentTarget(solid)
    model:setMesh(wallMesh)
    model:setProgramFamily('simple')
    model:setTexture(0, diffuseTexture)
    model:setUniform('DiffuseSampler', 0, 'int')
    self.model = model

    self.movePower = MinPower
end

function Drone:destroy()
    self.solid:destroy()
    self.model:destroy()
    WorldObject.destroy(self)
end

function Drone:_move( direction )
    self.solid:applyImpulse(direction*self.movePower, nil, false)
end

Drone:mapControl('boost', function( self, absolute, delta )
    if delta > 0 then
        self.movePower = MaxPower
    else
        self.movePower = MinPower
    end
end)

Drone:mapControl('forward', function( self, absolute, delta )
    if delta > 0 then self:_move(Vec(0, 0, 1)) end
end)

Drone:mapControl('backward', function( self, absolute, delta )
    if delta > 0 then self:_move(Vec(0, 0, -1)) end
end)

Drone:mapControl('left', function( self, absolute, delta )
    if delta > 0 then self:_move(Vec(-1, 0, 0)) end
end)

Drone:mapControl('right', function( self, absolute, delta )
    if delta > 0 then self:_move(Vec(1, 0, 0)) end
end)

Drone:mapControl('up', function( self, absolute, delta )
    if delta > 0 then self:_move(Vec(0, 1, 0)) end
end)

Drone:mapControl('down', function( self, absolute, delta )
    if delta > 0 then self:_move(Vec(0, -1, 0)) end
end)


return Drone
