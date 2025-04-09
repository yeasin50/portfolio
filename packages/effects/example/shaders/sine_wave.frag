#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize; 
uniform vec2 uFocalPoint; 
uniform float uTime; 

out vec4 fragColor;

void main() {
    vec2 uv = FlutterFragCoord().xy / uSize;  

    vec2 centeredUV = uv - (uFocalPoint / uSize);
    float distance = length(centeredUV);

    float frequency = 20.0;  // Number of ripples
    float speed = 2.0;       // Speed of ripple expansion
    float amplitude = 0.015; // Strength of distortion

    float wave = sin(distance * frequency - uTime * speed) * amplitude;

    float fade = smoothstep(0.5, 0.0, distance - uTime * 0.2); // Fades out at edges
    uv += centeredUV * wave * fade;

    float intensity = fade * (0.5 + 0.5 * sin(distance * frequency - uTime * speed));
    
    fragColor = vec4(vec3(intensity), 1.0);
}
