local Vec           = require 'core/Vector'
local Quat          = require 'core/Quaternion'
local Mat4          = require 'core/Matrix4'
local Shader        = require 'core/Shader'
local ShaderProgram = require 'core/ShaderProgram'
local BoxCollisionShape = require 'core/collision_shapes/BoxCollisionShape'
local Solid         = require 'core/Solid'
local Camera        = require 'core/Camera'
local ReferenceCube = require 'example/ReferenceCube/init'
local Skybox        = require 'example/Skybox/init'
local Planet        = require 'example/Planet/init'

renderTarget = require 'core/DefaultRenderTarget':get()
camera = renderTarget:getCamera()
modelWorld = camera:getModelWorld()

cubeShape = BoxCollisionShape(Vec(0.5, 0.5, 0.5))

function MakeCube( mass, position )
    local solid = Solid(mass, position, Quat(), cubeShape)

    local cube = ReferenceCube(modelWorld)
    cube.model:setAttachmentTarget(solid)
    cube.solid = solid

    return cube
end

cube1 = MakeCube(0, Vec(0.0, 0.0, 2.0))
cube2 = MakeCube(1, Vec(0.6, 2.0, 2.0))
cube3 = MakeCube(4, Vec(0.2, 3.2, 2.0))
cube3.model:getAttachmentTarget():setCollisionThreshold(0.7)


local skyboxShaderProgram = ShaderProgram:load('example/Skybox/shader.vert',
                                               'example/Skybox/shader.frag')
renderTarget:getShaderProgramSet():setFamily('skybox', skyboxShaderProgram)

skybox = Skybox(modelWorld)
planet = Planet(modelWorld)
planet.model:setTransformation(Mat4():translate(Vec(1,0,1)))
