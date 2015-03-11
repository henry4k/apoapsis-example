#version 120

uniform sampler2D DiffuseSampler;

varying vec2 TexCoord;

void main()
{
    vec4 diffuseColor = texture2D(DiffuseSampler, TexCoord);
    gl_FragColor = vec4(diffuseColor.rgba);
}
