local class   = require 'middleclass'
local Model   = require 'core/graphics/Model'
local Mesh    = require 'core/graphics/Mesh'
local Texture = require 'core/graphics/Texture'


local scaffoldMesh = Mesh:load('example/Scaffold/Scene.json', 'Scaffold')
local diffuseTexture = Texture:load('2d', 'example/Diffuse.png')


local Scaffold = class('example/Scaffold')

function Scaffold:initialize( modelWorld )
    self.model = modelWorld:createModel()
    self.model:setMesh(scaffoldMesh)
    self.model:setProgramFamily('simple')
    self.model:setTexture(0, diffuseTexture)
    self.model:setUniform('DiffuseSampler', 0, 'int')
end

return Scaffold
