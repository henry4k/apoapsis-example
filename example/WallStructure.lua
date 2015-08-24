local class          = require 'middleclass'
local Mat4           = require 'core/Matrix4'
local SingleVoxelStructure = require 'core/world/SingleVoxelStructure'
local MeshBuffer     = require 'core/graphics/MeshBuffer'
local SimpleMaterial = require 'example/SimpleMaterial'


local wallMeshBuffer = MeshBuffer:load('example/Wall/Scene.json', 'Wall')


local WallStructure = class('example/WallStructure', SingleVoxelStructure)
WallStructure:register()

function WallStructure:initialize( ... )
    SingleVoxelStructure.initialize(self, ...)
end

function WallStructure:generateModels( chunkBuilder )
    print('GREAT SUCCESS!')
    local transformation = Mat4()
    chunkBuilder:addMeshBuffer(SimpleMaterial, WallMeshBuffer, transformation)
end


return WallStructure
