local class = require 'middleclass'

local Json    = require 'core/Json'
local Scene   = require 'core/Scene'
local Vec     = require 'core/Vector'
local Mat4    = require 'core/Matrix4'
local Texture = require 'core/graphics/Texture'
local Mesh    = require 'core/graphics/Mesh'
local Model   = require 'core/graphics/Model'
local Shader  = require 'core/graphics/Shader'
local ShaderProgram = require 'core/graphics/ShaderProgram'


local HudHelmet = class('example/HudHelmet')

function HudHelmet:initialize()
    local shaderProgram = ShaderProgram:new(
        Shader:new('example/HudHelmet/shader.vert'),
        Shader:new('example/HudHelmet/shader.frag'))

    local scene = Json.decodeFromFile('example/HudHelmet/Scene.json')
    local meshBuffer = Scene.createMeshBuffer(scene.Helmet)
    local mesh = Mesh:new(meshBuffer)

    self.model = Model:new('hud', shaderProgram)
    self.model:setMesh(mesh)
    self.model:setTransformation(Mat4:new():scale(Vec:new(3,3,3)))
end

return HudHelmet
