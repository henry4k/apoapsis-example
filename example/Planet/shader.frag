#version 120

uniform sampler2D ControlSampler;
uniform sampler2D RDetailSampler;
uniform sampler2D GDetailSampler;
uniform sampler2D BDetailSampler;

varying vec2 TexCoord;

const vec2 ControlMapSize = vec2(1000, 500);
const float ControlMapAspect = ControlMapSize.x / ControlMapSize.y;

const vec2 LayerScale = vec2(ControlMapAspect, 1.0) * 16.0;
const int LayerCount = 4;
const float LayerHeightScale = 0.1;
const float WaterHeight = LayerHeightScale + 0.01;

void main()
{
    // Es gibt 4 Layer.  Jeder Layer an einem Pixel einen Hoehenwert.
    // Die Hoehe wird durch die Control-Map und durch den Alpha-Kanal,
    // der Layer definiert.  (controlmap * layer)

    // Es werden erst die Hoehen aller 4 Layer ermittelt.
    // Dann wird der hoechste Layer ermittelt.
    // Der Hoechste Layer wird dann angezeigt.

    vec4 control_ = texture2D(ControlSampler, TexCoord);
    float control[LayerCount];
    control[0] = control_.r;
    control[1] = control_.g;
    control[2] = control_.b;
    control[3] = WaterHeight;

    vec4 layerColor[LayerCount];
    layerColor[0] = texture2D(RDetailSampler, TexCoord*LayerScale);
    layerColor[1] = texture2D(GDetailSampler, TexCoord*LayerScale);
    layerColor[2] = texture2D(BDetailSampler, TexCoord*LayerScale);
    layerColor[3] = vec4(0, 0, 1, 0.5);

    int heighestLayer = 3;
    float heighestLayerHeight = 0.0;
    for(int i = 0; i < LayerCount; i++)
    {
        float height = control[i] + (layerColor[i].a-0.5)*2.0*LayerHeightScale;
        if(height > heighestLayerHeight)
        {
            heighestLayer = i;
            heighestLayerHeight = height;
        }
    }

    gl_FragColor = vec4(layerColor[heighestLayer].rgb, 1.0);
}
