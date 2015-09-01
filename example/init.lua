local Vec           = require 'core/Vector'
local Quat          = require 'core/Quaternion'
local Control       = require 'core/Control'
local ShaderProgram = require 'core/graphics/ShaderProgram'
local Texture       = require 'core/graphics/Texture'
local PhysicsWorld  = require 'core/physics/PhysicsWorld'
local BoxCollisionShape = require 'core/physics/BoxCollisionShape'
local Solid         = require 'core/physics/Solid'
local DefaultShaderProgramSet = require 'base-game/shaders/DefaultShaderProgramSet'
local SetupUtils    = require 'base-game/SetupUtils'
local Background    = require 'base-game/Background'
local GhostActor    = require 'base-game/GhostActor'
local HumanoidActor = require 'base-game/HumanoidActor'
local Scaffold      = require 'example/Scaffold/init'
local Wall          = require 'example/Wall/init'
local Pipe          = require 'example/Pipe/init'


local overlayTexture = Texture:load('2d', 'example/Overlay.png', {'filter'})

local simpleShaderProgram = ShaderProgram:load('example/shaders/Simple.vert',
                                               'example/shaders/Simple.frag')

local overlayShaderProgram = ShaderProgram:load('example/shaders/Overlay.vert',
                                                'example/shaders/Overlay.frag')

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

local function start()
    local renderTarget = require 'core/graphics/DefaultRenderTarget':get()

    SetupUtils.setupRenderTarget(renderTarget)
    Background.setup(renderTarget)

    DefaultShaderProgramSet:setFamily('simple', simpleShaderProgram)
    DefaultShaderProgramSet:setFamily('overlay', overlayShaderProgram)

    local worldModelWorld = renderTarget:getCameraByName('world'):getModelWorld()

    local cubeShape = BoxCollisionShape(Vec(0.5, 0.5, 0.5))

    local function MakeCube( clazz, mass, position )
        local solid = Solid(mass, position, Quat(), cubeShape)

        local cube = clazz(worldModelWorld)
        cube.model:setAttachmentTarget(solid)
        cube.solid = solid

        return cube
    end

    local pipe1 = MakeCube(Pipe, 0, Vec(0.0, -1.0, 1.0))
    local pipe2 = MakeCube(Pipe, 0, Vec(0.0, -2.0, 0.0))
    local pipe3 = MakeCube(Pipe, 0, Vec(-1.0, -1.0, 0.0))

    AddOverlay(pipe1, worldModelWorld)
    AddOverlay(pipe2, worldModelWorld)
    AddOverlay(pipe3, worldModelWorld)

    local cube1 = MakeCube(Scaffold, 1, Vec(0.6, 2.0, 2.0))
    local cube2 = MakeCube(Wall, 4, Vec(0.2, 3.2, 2.0))

    cube2.model:getAttachmentTarget():setCollisionThreshold(0.7)
    cube2.solid:addEventTarget('collision', cube2, function( cube, impulse, ... )
        if impulse > 0.5 then
            print('BOOM!')
            cube.solid:applyImpulse(Vec(0, 3, 0))
        end
    end)

    --local actor = HumanoidActor(renderTarget)
    local actor = GhostActor(renderTarget)
    Control.pushControllable(actor)

    PhysicsWorld.setGravity(Vec(0,-0.2,0))
end

return { start=start }
