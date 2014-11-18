local class   = require 'middleclass'
local Model   = require 'core/graphics/Model'
local MeshBuffer = require 'core/graphics/MeshBuffer'
local Mesh    = require 'core/graphics/Mesh'
local Texture = require 'core/graphics/Texture'


local pipeMeshBuffer = MeshBuffer:load('example/Pipe/Scene.json', 'Pipe')
local scaffoldMeshBuffer = MeshBuffer:load('example/Scaffold/Scene.json', 'Scaffold')

local combinedMeshBuffer = MeshBuffer()
combinedMeshBuffer:appendMeshBuffer(scaffoldMeshBuffer)
combinedMeshBuffer:appendMeshBuffer(pipeMeshBuffer)

local combinedMesh = Mesh(combinedMeshBuffer)

local diffuseTexture = Texture:load('2d', 'example/Diffuse.png')


local Pipe = class('example/Pipe')

function Pipe:initialize( modelWorld )
    self.model = modelWorld:createModel()
    self.model:setMesh(combinedMesh)
    self.model:setProgramFamilyList('simple')
    self.model:setTexture(0, diffuseTexture)
    self.model:setUniform('DiffuseSampler', 0, 'int')
end

return Pipe
