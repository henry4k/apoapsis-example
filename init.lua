local Vec        = require 'core/Vector'
local Control    = require 'core/Control'
local GlobalControls = require 'core/GlobalControls'
local SetupUtils = require 'base-game/SetupUtils'
local Background = require 'base-game/Background'
local GhostActor = require 'base-game/world/GhostActor'
local Scaffold   = require 'base-game/voxel/Scaffold/init'


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

    do
        local voxel = voxelVolume:createVoxelAt(Vec(0,0,0), Scaffold)
        voxelVolume:setVoxelAt(Vec(0,0,0), voxel)
        chunkManager:update()
    end

    local function getVoxelPosition()
        local position = actor.solid:getPosition()
        return Vec(math.floor(position[1]),
                   math.floor(position[2]),
                   math.floor(position[3]))
    end

    GlobalControls:mapControl('place-tile', function( self, absolute, delta )
        if delta > 0 then
            local position = getVoxelPosition()
            local voxel = voxelVolume:createVoxelAt(position, Scaffold)
            voxelVolume:setVoxelAt(position, voxel)
            chunkManager:update()
        end
    end)

    GlobalControls:mapControl('place-tile2', function( self, absolute, delta )
        if delta > 0 then
            local position = getVoxelPosition()
            local voxel = voxelVolume:getVoxelAt(position)
            if voxel and voxel:isInstanceOf(Scaffold) then
                voxel:setPlating(1)
                voxelVolume:setVoxelAt(position, voxel)
            end
            chunkManager:update()
        end
    end)
end


return { start=start }
