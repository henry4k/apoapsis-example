local Vec           = require 'core/Vector'
local Quat          = require 'core/Quaternion'
local Mat4          = require 'core/Matrix4'
local Shader        = require 'core/graphics/Shader'
local ShaderProgram = require 'core/graphics/ShaderProgram'
local Camera        = require 'core/graphics/Camera'
local BoxCollisionShape = require 'core/physics/BoxCollisionShape'
local Solid         = require 'core/physics/Solid'
local ReferenceCube = require 'example/ReferenceCube/init'
local Skybox        = require 'example/Skybox/init'
local Planet        = require 'example/Planet/init'


local skyboxShaderProgram = ShaderProgram:load('example/Skybox/shader.vert',
                                               'example/Skybox/shader.frag')

local planetShaderProgram = ShaderProgram:load('example/Planet/normal-mapping.vert',
                                               'example/Planet/normal-mapping.frag',
                                               'example/Planet/shader.vert',
                                               'example/Planet/shader.frag')

local planetCloudsShaderProgram = ShaderProgram:load('example/Planet/normal-mapping.vert',
                                                     'example/Planet/normal-mapping.frag',
                                                     'example/Planet/shader.vert',
                                                     'example/Planet/clouds.frag')

local function start()
    renderTarget         = require 'core/graphics/DefaultRenderTarget':get()
    worldCamera          = renderTarget:getCameraByName('world')
    backgroundCamera     = renderTarget:getCameraByName('background')
    worldModelWorld      = worldCamera:getModelWorld()
    backgroundModelWorld = backgroundCamera:getModelWorld()

    renderTarget:getShaderProgramSet():setFamily('skybox', skyboxShaderProgram)
    renderTarget:getShaderProgramSet():setFamily('planet', planetShaderProgram)
    renderTarget:getShaderProgramSet():setFamily('planet-clouds', planetCloudsShaderProgram)

    --[[
    cubeShape = BoxCollisionShape(Vec(0.5, 0.5, 0.5))

    function MakeCube( mass, position )
        local solid = Solid(mass, position, Quat(), cubeShape)

        local cube = ReferenceCube(worldModelWorld)
        cube.model:setAttachmentTarget(solid)
        cube.solid = solid

        return cube
    end

    cube1 = MakeCube(0, Vec(0.0, 0.0, 2.0))
    cube2 = MakeCube(1, Vec(0.6, 2.0, 2.0))
    cube3 = MakeCube(4, Vec(0.2, 3.2, 2.0))
    cube3.model:getAttachmentTarget():setCollisionThreshold(0.7)
    ]]

    skybox = Skybox(backgroundModelWorld)
    --skybox.model:setTransformation(Mat4():scale(99999*1000))
    skybox.model:setTransformation(Mat4():scale(50))

    planet = Planet(backgroundModelWorld)
    local planetDiameter = 4 -- 12756 * 1000
    local meterAboveSurface = 5 -- 400 * 1000
    local planetTransformation = Mat4():translate(Vec(0,0,planetDiameter+meterAboveSurface))
                                       :scale(planetDiameter*2)
                                       :rotate(90, Vec(0,1,0))
    planet:setTransformation(planetTransformation)
end

return { start=start }