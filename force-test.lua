local Vec           = require 'core/Vector'
local Quat          = require 'core/Quaternion'
local Mat4          = require 'core/Matrix4'
local Shader        = require 'core/Shader'
local ShaderProgram = require 'core/ShaderProgram'
local BoxCollisionShape = require 'core/collision_shapes/BoxCollisionShape'
local Solid         = require 'core/Solid'
local Camera        = require 'core/Camera'
local ReferenceCube = require 'example/ReferenceCube/init'

cubeShape = BoxCollisionShape(Vec(0.5, 0.5, 0.5))
renderTarget = require 'core/DefaultRenderTarget':get()

function MakeCube( mass, position )
    local solid = Solid(mass, position, Quat(), cubeShape)

    local camera = renderTarget:getCamera()
    local modelWorld = camera:getModelWorld()
    local cube = ReferenceCube(modelWorld)
    cube.model:setAttachmentTarget(solid)
    cube.solid = solid

    return cube
end

cube1 = MakeCube(0, Vec(0.0, 0.0, 2.0))
cube2 = MakeCube(1, Vec(0.6, 2.0, 2.0))
cube3 = MakeCube(4, Vec(0.2, 3.2, 2.0))
cube3.model:getAttachmentTarget():setCollisionThreshold(0.7)
local force = cube3.solid:createForce()
force:set(Vec(0,0,1000), Vec(0,0,0), false)
