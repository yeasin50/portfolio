#version 460 core

#include <flutter/runtime_effect.glsl>
precision mediump float;

uniform vec2 uSize;
uniform float utime;
uniform  vec3 uPlasmaColor;
uniform vec3 uBorderColor; 

out vec4 fragColor;
void main() {
    
    vec2 uv = FlutterFragCoord().xy / uSize;
    uv.x *= (uSize.x / uSize.y);

    float r = length(uv);
    float time = utime;

    // Fire-like distortion
    vec2 fireUV = uv;
    fireUV.y += sin(time * 2.0 + uv.x * 20.0) * 0.02;
    fireUV.x += sin(time * 1.5 + uv.y * 20.0) * 0.02;

    float fireR = length(fireUV);
    float inner = 1.0 - smoothstep(0.0, 0.15, fireR);

    // Fire color gradient
    vec3 fireColor = mix(uPlasmaColor, vec3(1.0, 1.0, 0.8), pow(1.0 - fireR / 0.15, 2.0));
    vec3 innerColor = fireColor * inner;

    // Outer ring
    float ringStart = 0.1;
    float ringPeak  = 0.20;
    float ringEnd   = 0.23;

    float outer = smoothstep(ringStart, ringPeak, r) * (1.0 - smoothstep(ringPeak, ringEnd, r));
    vec3 outerColor =  uBorderColor * outer;

    // Background
    vec3 background = vec3(0.01, 0.0, 0.05) * (1.0 - smoothstep(0.3, 0.8, r));

    // Final color
    vec3 col = innerColor + outerColor + background;
    fragColor = vec4(col, 1.0);
}
