#version 120

varying vec4 Color;

attribute vec3 VertexPosition;
attribute vec3 VertexNormal;

uniform mat4 Projection;
uniform mat4 ViewInverseTranspose;

const vec3 LightDirection = vec3(0.0, 0.0, 1.0);

void main()
{
    const vec3 scale = vec3(1.0, 1.0, -1.0);
    gl_Position = Projection * vec4(VertexPosition*scale, 1.0);

    vec3 normal = vec3(normalize(ViewInverseTranspose * vec4(-VertexNormal, 1.0)));
    float nDotL = dot(normal, LightDirection);
    float lightVisibillity = max(0.0, nDotL); // Compute lambert term
    Color = vec4(1.0, 1.0, 1.0, 1.0) * lightVisibillity;
}
