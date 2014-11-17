local class   = require 'middleclass'
local Model   = require 'core/graphics/Model'
local Mesh    = require 'core/graphics/Mesh'
local Texture = require 'core/graphics/Texture'


local pipeMesh = Mesh:load('example/Pipe/Scene.json', 'Pipe')
local diffuseTexture = Texture:load('2d', 'example/Diffuse.png')


local Pipe = class('example/Pipe')

function Pipe:initialize( modelWorld )
    self.model = modelWorld:createModel()
    self.model:setMesh(pipeMesh)
    self.model:setProgramFamilyList('simple')
    self.model:setTexture(0, diffuseTexture)
    self.model:setUniform('DiffuseSampler', 0, 'int')
end

return Pipe
