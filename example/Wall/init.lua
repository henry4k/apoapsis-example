local class   = require 'middleclass'
local Model   = require 'core/graphics/Model'
local Mesh    = require 'core/graphics/Mesh'
local Texture = require 'core/graphics/Texture'


local wallMesh = Mesh:load('example/Wall/Scene.json', 'Wall')
local diffuseTexture = Texture:load('2d', 'example/Diffuse.png')


local Wall = class('example/Wall')

function Wall:initialize( modelWorld )
    self.model = modelWorld:createModel()
    self.model:setMesh(wallMesh)
    self.model:setProgramFamilyList('simple')
    self.model:setTexture(0, diffuseTexture)
    self.model:setUniform('DiffuseSampler', 0, 'int')
end

return Wall
