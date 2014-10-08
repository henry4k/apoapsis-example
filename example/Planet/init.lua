local class = require 'middleclass'
local Model = require 'core/Model'
local Mesh  = require 'core/Mesh'
local Texture = require 'core/Texture'


local Planet = class('example/Planet')

function Planet:initialize( modelWorld )
    local mesh = Mesh:load('example/Planet/Scene.json', 'Icosphere')
    local diffuseTexture = Texture:load('2d', 'example/Planet/EarthDiffuse.png', 'filter')
    local normalTexture  = Texture:load('2d', 'example/Planet/EarthNormal.png', 'filter')
    local cloudDiffuseTexture = Texture:load('2d', 'example/Planet/EarthCloudDiffuse.png',  'filter')
    local cloudNormalTexture  = Texture:load('2d', 'example/Planet/EarthCloudNormal.png',  'filter')

    self.model = modelWorld:createModel('background')
    self.model:setMesh(mesh)
    self.model:setProgramFamilyList('planet')
    self.model:setTexture(0, diffuseTexture)
    self.model:setTexture(1, normalTexture)
    self.model:setTexture(2, cloudDiffuseTexture)
    self.model:setUniform('DiffuseSampler', 0, 'int')
    self.model:setUniform('NormalSampler',  1, 'int')
    self.model:setUniform('CloudSampler',   2, 'int')

    self.cloudModel = modelWorld:createModel('background')
    self.cloudModel:setMesh(mesh)
    self.cloudModel:setProgramFamilyList('planet-clouds')
    self.cloudModel:setTexture(0, cloudDiffuseTexture)
    self.cloudModel:setTexture(1, cloudNormalTexture)
    self.cloudModel:setUniform('DiffuseSampler', 0, 'int')
    self.cloudModel:setUniform('NormalSampler',  1, 'int')
end

function Planet:setTransformation( transformation )
    self.model:setTransformation(transformation)
    self.cloudModel:setTransformation(transformation:scale(1.01))
end

return Planet
