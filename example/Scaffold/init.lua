local class   = require 'middleclass'
local Model   = require 'core/graphics/Model'
local Mesh    = require 'core/graphics/Mesh'
local Texture = require 'core/graphics/Texture'


local cubeMesh = Mesh:load('example/Scaffold/Scene.json', 'Scaffold')
local cubeDiffuseTexture = Texture:load('2d', 'example/Scaffold/Diffuse.png')


local Scaffold = class('example/Scaffold')

function Scaffold:initialize( modelWorld )
    self.model = modelWorld:createModel()
    self.model:setMesh(cubeMesh)
    self.model:setProgramFamilyList('simple')
    self.model:setTexture(0, cubeDiffuseTexture)
    self.model:setUniform('DiffuseSampler', 0, 'int')
end

return Scaffold
