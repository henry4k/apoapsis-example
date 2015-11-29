local class          = require 'middleclass'
local Mat4           = require 'core/Matrix4'
local Voxel          = require 'core/voxel/Voxel'
local SingleVoxelStructure = require 'core/voxel/SingleVoxelStructure'
local MeshBuffer     = require 'core/graphics/MeshBuffer'
local SimpleMaterial = require 'example/SimpleMaterial'


local wallMeshBuffer = MeshBuffer:load('example/Wall/Scene.json', 'Wall')


local WallStructure = class('example/WallStructure', SingleVoxelStructure)
WallStructure:register()

function WallStructure:initialize( ... )
    SingleVoxelStructure.initialize(self, ...)
end

function WallStructure:destroy()
    SingleVoxelStructure.destroy()
end

function WallStructure:create( voxelCreator )
    local voxel = Voxel()
    WallStructure.voxelAccessor:write(voxel, 'id', WallStructure.id)
    voxelCreator:writeVoxel(self.origin, voxel)
end

function WallStructure:read( voxelReader )
end

function WallStructure:write( voxelWriter )
end

function WallStructure:generateModels( chunkBuilder )
    local transformation = Mat4()
    chunkBuilder:addMeshBuffer(SimpleMaterial, wallMeshBuffer, transformation)
end


return WallStructure
