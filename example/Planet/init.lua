local class = require 'core/middleclass'
local Model = require 'core/Model'
local Mesh  = require 'core/Mesh'
local Texture = require 'core/Texture'


local Planet = class('example/Planet')

function Planet:initialize( modelWorld )
    local mesh = Mesh:load('example/Planet/Scene.json', 'Icosphere')
    local diffuseTexture = Texture:load('2d', 'example/Planet/Diffuse.png')
    self.model = modelWorld:createModel('background')
    self.model:setMesh(mesh)
    self.model:setProgramFamilyList('default')
    self.model:setTexture(0, diffuseTexture)
    self.model:setUniform('DiffuseSampler', 0)
end

return Planet
