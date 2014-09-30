local class = require 'middleclass'

local Json    = require 'core/Json'
local Texture = require 'core/Texture'
local Mesh    = require 'core/Mesh'
local Scene   = require 'core/Scene'
local Model   = require 'core/Model'
local Vec     = require 'core/Vector'
local Mat4    = require 'core/Matrix4'
local Shader  = require 'core/Shader'
local ShaderProgram = require 'core/ShaderProgram'


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
