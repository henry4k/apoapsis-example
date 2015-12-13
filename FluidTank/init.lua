local class = require 'middleclass'
local Model = require 'core/graphics/Model'
local Mesh  = require 'core/graphics/Mesh'
local Texture = require 'core/graphics/Texture'


local fluidTankMesh = Mesh:load('example/FluidTank/Scene.json', 'Cylinder')
local fluidTankDiffuseTexture = Texture:load{fileName='example/FluidTank/Diffuse.png'}


local FluidTank = class('example/FluidTank')

function FluidTank:initialize( shaderProgram )
    self.model = Model(shaderProgram)
    self.model:setMesh(fluidTankMesh)
    self.model:setTexture(0, fluidTankDiffuseTexture)
    self.model:setUniform('DiffuseSampler', 0)
end

return FluidTank
