local class = require 'middleclass'
local Model = require 'core/Model'
local Mesh  = require 'core/Mesh'
local Texture = require 'core/Texture'


local Planet = class('example/Planet')

function Planet:initialize( modelWorld )
    local mesh = Mesh:load('example/Planet/Scene.json', 'Icosphere')
    local controlTexture = Texture:load('2d', 'example/Planet/Control.png', 'filter')
    local rDetailTexture = Texture:load('2d', 'example/Planet/Earth.png', 'filter')
    local gDetailTexture = Texture:load('2d', 'example/Planet/Vegetation.png', 'filter')
    local bDetailTexture = Texture:load('2d', 'example/Planet/Ice.png', 'filter')
    self.model = modelWorld:createModel('background')
    self.model:setMesh(mesh)
    self.model:setProgramFamilyList('planet')
    self.model:setTexture(0, controlTexture)
    self.model:setTexture(1, rDetailTexture)
    self.model:setTexture(2, gDetailTexture)
    self.model:setTexture(3, bDetailTexture)
    self.model:setUniform('ControlSampler', 0, 'int')
    self.model:setUniform('RDetailSampler', 1, 'int')
    self.model:setUniform('GDetailSampler', 2, 'int')
    self.model:setUniform('BDetailSampler', 3, 'int')
end

return Planet
