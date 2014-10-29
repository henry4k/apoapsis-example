local class = require 'middleclass'
local Mesh  = require 'core/graphics/Mesh'
local Texture = require 'core/graphics/Texture'


local skyboxMesh = Mesh:load('example/Skybox/Scene.json', 'Skybox')
local skyboxDiffuseTexture = Texture:load('cube', 'example/Skybox/%s.png')


local Skybox = class('example/Skybox')

function Skybox:initialize( modelWorld )
    self.model = modelWorld:createModel('background')
    self.model:setMesh(skyboxMesh)
    self.model:setProgramFamilyList('skybox')
    self.model:setTexture(0, skyboxDiffuseTexture)
    self.model:setUniform('DiffuseSampler', 0, 'int')
end

return Skybox
