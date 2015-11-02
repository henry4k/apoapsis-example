local class = require 'middleclass'
local Vec     = require 'core/Vector'
local Mat4    = require 'core/Matrix4'
local Mesh    = require 'core/graphics/Mesh'
local Model   = require 'core/graphics/Model'
local Shader  = require 'core/graphics/Shader'
local ShaderProgram = require 'core/graphics/ShaderProgram'


local hudHelmetShaderProgram =
    ShaderProgram:load('example/HudHelmet/shader.vert',
                       'example/HudHelmet/shader.frag')
local hudHelmetMesh = Mesh:load('example/HudHelmet/Scene.json', 'Helmet')


local HudHelmet = class('example/HudHelmet')

function HudHelmet:initialize()
    self.model = Model:new('hud', hudHelmetShaderProgram)
    self.model:setMesh(hudHelmetMesh)
    self.model:setTransformation(Mat4:new():scale(Vec:new(3,3,3)))
end

return HudHelmet
