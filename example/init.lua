local FS          = require 'core/FileSystem'
local Shader      = require 'core/graphics/Shader'
local Texture     = require 'core/graphics/Texture'
local AudioBuffer = require 'core/audio/AudioBuffer'
local ShaderProgram = require 'core/graphics/ShaderProgram'

for path in FS.directoryTree('example') do
    local extension = path:match('.*%.(.+)$')
    if extension == 'vert' or
       extension == 'frag' then
        Shader:load(path)
    elseif extension == 'png' then
        Texture:load('2d', path)
    elseif extension == 'ogg' then
        AudioBuffer:load(path)
    end
end

ShaderProgram:load('example/Skybox/shader.vert',
                   'example/Skybox/shader.frag')
