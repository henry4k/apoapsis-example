local class   = require 'middleclass'
local Model   = require 'core/graphics/Model'
local Mesh    = require 'core/graphics/Mesh'
local Texture = require 'core/graphics/Texture'


local cubeMesh = Mesh:load('example/ReferenceCube/Scene.json', 'Cube')
local cubeDiffuseTexture = Texture:load('2d', 'example/ReferenceCube/Diffuse.png')


local ReferenceCube = class('example/ReferenceCube')

function ReferenceCube:initialize( modelWorld )
    self.model = modelWorld:createModel()
    self.model:setMesh(cubeMesh)
    self.model:setProgramFamilyList('default')
    self.model:setTexture(0, cubeDiffuseTexture)
    self.model:setUniform('DiffuseSampler', 0, 'int')
end

return ReferenceCube
