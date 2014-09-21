local Vec           = require 'core/Vector'
local Quat          = require 'core/Quaternion'
local Mat4          = require 'core/Matrix4'
local Shader        = require 'core/Shader'
local ShaderProgram = require 'core/ShaderProgram'
local BoxCollisionShape = require 'core/collision_shapes/BoxCollisionShape'
local Solid         = require 'core/Solid'
local Camera        = require 'core/Camera'
local Control       = require 'core/Control'
local ReferenceCube = require 'example/ReferenceCube/init'
local Skybox        = require 'example/Skybox/init'
local HudHelmet     = require 'example/HudHelmet/init'

shaderProgram = ShaderProgram:new(
    Shader:new('core/Shaders/Test.vert'),
    Shader:new('core/Shaders/Test.frag'))

cubeShape = BoxCollisionShape:new(Vec:new(0.5, 0.5, 0.5))

function MakeCube( mass, position )
    local solid = Solid:new(mass, position, Quat:new(), cubeShape)

    local cube = ReferenceCube:new('world', shaderProgram)
    cube.solid = solid
    cube.model:setAttachmentTarget(solid)

    return cube
end

cube1 = MakeCube(0, Vec:new(0.0, 0.0, 2.0))
cube2 = MakeCube(1, Vec:new(0.6, 2.0, 2.0))
cube3 = MakeCube(1, Vec:new(0.2, 3.2, 2.0))

cameraSolid = Solid:new(1, Vec:new(0,3,0), Quat:new(), cubeShape)
Camera.setAttachmentTarget(cameraSolid)
Camera.setFieldOfView(math.rad(80))
Control.registerKey('zoom', function( pressed )
    if pressed then
        Camera.setFieldOfView(math.rad(10))
    else
        Camera.setFieldOfView(math.rad(80))
    end
end)

skybox = Skybox:new()
hudHelmet = HudHelmet:new()
