local class   = require 'middleclass'
local Model   = require 'core/graphics/Model'
local Mesh    = require 'core/graphics/Mesh'
local Texture = require 'core/graphics/Texture'


local ReferenceCube = class('example/ReferenceCube')

function ReferenceCube:initialize( modelWorld )
    local mesh = Mesh:load('example/ReferenceCube/Scene.json', 'Cube')
    local diffuseTexture = Texture:load('2d', 'example/ReferenceCube/Diffuse.png')
    self.model = modelWorld:createModel()
    self.model:setMesh(mesh)
    self.model:setProgramFamilyList('default')
    self.model:setTexture(0, diffuseTexture)
    self.model:setUniform('DiffuseSampler', 0, 'int')
end

return ReferenceCube
