#version 460 core
#include <flutter/runtime_effect.glsl>
precision mediump float;

uniform vec2 uSize;
uniform float utime;
uniform vec3 uPlasmaColor;
uniform vec3 uBorderColor;
uniform vec3 uCoreColor;

// animate inner core
uniform float uDense;
uniform float uSpreed; 


out vec4 fragColor;

void main() {
 

    vec2 uv = (FlutterFragCoord().xy / uSize - 0.5);
    uv.x *= uSize.x / uSize.y;

    uv  = uv/2;
    float r = length(uv);
    float time = utime;

    // Fire-like distortion
    vec2 fireUV = uv;
    fireUV.y += sin(time * 2.0 + uv.x * 20.0) * 0.02;
    fireUV.x += sin(time * 1.5 + uv.y * 20.0) * 0.02;

    float fireR = length(fireUV);
    ///  can tweak smoothstep(dense, spread, fireR);
    float inner = 1.0 - smoothstep(uDense, uSpreed,  fireR);
    vec3 fireColor = mix(uPlasmaColor, uCoreColor, pow(1.0 - fireR / 0.15, 2.0));
    vec3 innerColor = fireColor * inner;

    // Outer ring
    float outer = smoothstep(0.1, 0.2, r) * (1.0 - smoothstep(0.2, 0.23, r));
    vec3 outerColor = uBorderColor * outer;

    // Alpha based on radius (soft edges)
    float alpha = clamp(inner + outer, 0.0, 1.0);

    // Final color with alpha
    vec3 col = innerColor + outerColor;
    fragColor = vec4(col, alpha);
}
