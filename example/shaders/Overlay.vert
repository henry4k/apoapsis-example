#version 120

uniform float Time;
uniform mat4 ModelViewProjection;

attribute vec3 VertexPosition;

varying vec2 TexCoord;

void main()
{
    gl_Position = ModelViewProjection * vec4(VertexPosition, 1.0);
    TexCoord = VertexPosition.xy + vec2(sin(Time), cos(Time));
}
