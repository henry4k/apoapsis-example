local Texture = require 'core/graphics/Texture'
local GraphicalMaterial = require 'core/graphics/GraphicalMaterial'


local diffuseTexture = Texture:load('2d', 'example/Diffuse.png')


local SimpleMaterial = GraphicalMaterial()

SimpleMaterial:setOverlayLevel(0)
SimpleMaterial:setProgramFamily('simple')
SimpleMaterial:setTexture(0, diffuseTexture)
SimpleMaterial:setUniform('DiffuseSampler', 0, 'int')


return SimpleMaterial
