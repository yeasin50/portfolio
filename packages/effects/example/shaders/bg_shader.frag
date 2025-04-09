#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize; 
uniform vec2 uFocalPoint; 

uniform float uRadius; 

uniform vec4 uFocalColor;
uniform vec4 uEdgeColor; 

out vec4 fragColor;


void main() {
    vec2 uv = FlutterFragCoord().xy / uSize;
    vec2 center = uFocalPoint;

    // Correct aspect ratio to make it circular
    uv.x *= uSize.x / uSize.y;
    center.x *= uSize.x / uSize.y;

    float dist = distance(uv, center);

    float factor = smoothstep(0.0, uRadius, dist);

    factor = pow(factor, 4.4);

    vec4 color = mix(uFocalColor, uEdgeColor, factor);

    fragColor = color;
}