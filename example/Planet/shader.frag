#version 120

uniform sampler2D ControlSampler;
uniform sampler2D RDetailSampler;
uniform sampler2D GDetailSampler;
uniform sampler2D BDetailSampler;

varying vec2 TexCoord;

const float DetailScale = 16.0;

void main()
{
    vec4 control = texture2D(ControlSampler, TexCoord);
    vec4 rDetail = texture2D(RDetailSampler, TexCoord*DetailScale);
    vec4 gDetail = texture2D(GDetailSampler, TexCoord*DetailScale);
    vec4 bDetail = texture2D(BDetailSampler, TexCoord*DetailScale);

    float height = control.a;
    float rContribution = control.r;
    float gContribution = control.g;
    float bContribution = control.b;

    gl_FragColor = vec4(0,0,0,0);
    gl_FragColor = mix(gl_FragColor, rDetail, 1.0); //rContribution);
    //gl_FragColor = mix(gl_FragColor, gDetail, gContribution);
    //gl_FragColor = mix(gl_FragColor, bDetail, bContribution);
    gl_FragColor.a = 1.0;
}
