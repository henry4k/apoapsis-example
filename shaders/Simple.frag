#version 120

uniform sampler2D DiffuseSampler;

varying vec2 TexCoord;

void main()
{
    vec4 diffuseColor = texture2D(DiffuseSampler, TexCoord);
    if(diffuseColor.a == 1.0)
        gl_FragColor = vec4(diffuseColor.rgb, 1.0);
    else
        discard;
}
