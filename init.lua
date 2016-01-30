local Vec           = require 'core/Vector'
local Control       = require 'core/Control'
local GlobalControls = require 'core/GlobalControls'
local SetupUtils    = require 'base-game/SetupUtils'
local Background    = require 'base-game/Background'
local GhostActor    = require 'base-game/world/GhostActor'
local ScaffoldStructure = require 'base-game/voxel/ScaffoldStructure/init'


local function start()
    local renderTarget = require 'core/graphics/DefaultRenderTarget'

    SetupUtils.setupRenderTarget(renderTarget)
    Background.setup(renderTarget)

    local actor = GhostActor(renderTarget)
    Control.pushControllable(actor)

    local voxelVolume = SetupUtils.setupVoxelVolume(Vec(32, 32, 32))

    local worldModelWorld = renderTarget:getCameraByName('world'):getModelWorld()
    local chunkManager = SetupUtils.setupChunkManager(voxelVolume, worldModelWorld)
    chunkManager:addActivator(actor.chunkActivator)

    ScaffoldStructure:setupMeshChunkGenerator(chunkManager.meshChunkGenerator)
    voxelVolume:createStructure(ScaffoldStructure, Vec(0,0,0), 1)

    chunkManager:update()

    local function placeStructure( structureClass, ... )
        local position = actor.solid:getPosition()
        local voxelPosition = Vec(math.floor(position[1]),
                                  math.floor(position[2]),
                                  math.floor(position[3]))
        voxelVolume:createStructure(structureClass, voxelPosition, ...)
        chunkManager:update()
    end

    GlobalControls:mapControl('place-tile', function( self, absolute, delta )
        if delta > 0 then
            placeStructure(ScaffoldStructure, 0)
        end
    end)

    GlobalControls:mapControl('place-tile2', function( self, absolute, delta )
        if delta > 0 then
            placeStructure(ScaffoldStructure, 1)
        end
    end)
end


return { start=start }
