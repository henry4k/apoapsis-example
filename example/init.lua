local Vec           = require 'core/Vector'
local Quat          = require 'core/Quaternion'
local Mat4          = require 'core/Matrix4'
local Shader        = require 'core/graphics/Shader'
local ShaderProgram = require 'core/graphics/ShaderProgram'
local Camera        = require 'core/graphics/Camera'
local Texture       = require 'core/graphics/Texture'
local BoxCollisionShape = require 'core/physics/BoxCollisionShape'
local Solid         = require 'core/physics/Solid'
local Scaffold      = require 'example/Scaffold/init'
local Wall          = require 'example/Wall/init'
local Pipe          = require 'example/Pipe/init'
local Skybox        = require 'example/Skybox/init'
local Planet        = require 'example/Planet/init'
local WallStructure = require 'example/WallStructure'


local overlayTexture = Texture:load('2d', 'example/Overlay.png', {'filter'})

local simpleShaderProgram = ShaderProgram:load('example/shaders/Simple.vert',
                                               'example/shaders/Simple.frag')

local overlayShaderProgram = ShaderProgram:load('example/shaders/Overlay.vert',
                                                'example/shaders/Overlay.frag')

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

local function AddOverlay( cube, modelWorld )
    local overlayModel = modelWorld:createModel()
    overlayModel:setMesh(cube.model:getMesh())
    overlayModel:setProgramFamily('overlay')
    overlayModel:setTexture(0, overlayTexture)
    overlayModel:setUniform('DiffuseSampler', 0, 'int')
    overlayModel:setAttachmentTarget(cube.model:getAttachmentTarget())
    overlayModel:setOverlayLevel(1)

    cube.overlayModel = overlayModel
end

local function genVoxels()
    print(voxelVolume:createStructure(WallStructure, Vec(5,0,0)))
    print(voxelVolume:createStructure(WallStructure, Vec(5,0,1)))
    print(voxelVolume:createStructure(WallStructure, Vec(4,0,1)))
end

local function start()
    renderTarget         = require 'core/graphics/DefaultRenderTarget':get()
    worldCamera          = renderTarget:getCameraByName('world')
    backgroundCamera     = renderTarget:getCameraByName('background')
    worldModelWorld      = worldCamera:getModelWorld()
    backgroundModelWorld = backgroundCamera:getModelWorld()

    renderTarget:getShaderProgramSet():setFamily('simple', simpleShaderProgram)
    renderTarget:getShaderProgramSet():setFamily('overlay', overlayShaderProgram)
    renderTarget:getShaderProgramSet():setFamily('skybox', skyboxShaderProgram)
    renderTarget:getShaderProgramSet():setFamily('planet', planetShaderProgram)
    renderTarget:getShaderProgramSet():setFamily('planet-clouds', planetCloudsShaderProgram)

    cubeShape = BoxCollisionShape(Vec(0.5, 0.5, 0.5))

    local function MakeCube( clazz, mass, position )
        local solid = Solid(mass, position, Quat(), cubeShape)

        local cube = clazz(worldModelWorld)
        cube.model:setAttachmentTarget(solid)
        cube.solid = solid

        return cube
    end

    pipe1 = MakeCube(Pipe, 0, Vec(0.0, -1.0, 2.0))
    pipe2 = MakeCube(Pipe, 0, Vec(0.0, -2.0, 2.0))
    pipe3 = MakeCube(Pipe, 0, Vec(0.0, -3.0, 2.0))

    AddOverlay(pipe1, worldModelWorld)
    AddOverlay(pipe2, worldModelWorld)
    AddOverlay(pipe3, worldModelWorld)

    cube1 = MakeCube(Scaffold, 1, Vec(0.6, 2.0, 2.0))
    cube2 = MakeCube(Wall, 4, Vec(0.2, 3.2, 2.0))
    cube2.model:getAttachmentTarget():setCollisionThreshold(0.7)
    cube2.solid:addEventTarget('collision', cube2, function( cube, impulse, ... )
        if impulse > 0.5 then
            print('BOOM!')
            cube.solid:applyImpulse(Vec(0, 3, 0))
        end
    end)

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

    genVoxels()
end

return { start=start }
