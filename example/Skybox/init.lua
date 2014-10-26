local class = require 'middleclass'
local Vec   = require 'core/Vector'
local Mat4  = require 'core/Matrix4'
local Model = require 'core/graphics/Model'
local Mesh  = require 'core/graphics/Mesh'
local Texture = require 'core/graphics/Texture'


local Skybox = class('example/Skybox')

function Skybox:initialize( modelWorld )
    local mesh = Mesh:load('example/Skybox/Scene.json', 'Skybox')
    local diffuseTexture = Texture:load('cube', 'example/Skybox/%s.png')
    self.model = modelWorld:createModel('background')
    self.model:setMesh(mesh)
    self.model:setProgramFamilyList('skybox')
    self.model:setTexture(0, diffuseTexture)
    self.model:setUniform('DiffuseSampler', 0, 'int')
end

return Skybox
