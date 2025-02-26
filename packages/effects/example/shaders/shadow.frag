#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;       Widget size
uniform vec2 uMousePoint; Mouse position
uniform float umaxDistance;Maximum shadow distance
uniform vec3 uShadowColor;Shadow color

out vec4 fragColor;

// playing with ai -_- 
void main() {
   Get pixel position in normalized UV space
    vec2 uv = FlutterFragCoord().xy / uSize;

   Center of the widget
    vec2 focalUV = vec2(0.5, 0.5);
    vec2 mouseUV = uMousePoint / uSize;

   Direction & distance from center to mouse
    vec2 direction = focalUV - mouseUV;
    float distance = length(direction) * uSize.x;

   Normalize direction
    vec2 shadowOffset = normalize(direction) * clamp(distance / umaxDistance, 0.0, 1.0) * umaxDistance;

   Shadow intensity based on distance
    float shadowIntensity = 1.0 - smoothstep(0.0, umaxDistance, distance);

   Apply a soft falloff to make it more visible
    shadowIntensity = pow(shadowIntensity, 2.0);

   Final shadow color
    vec3 shadow = uShadowColor * shadowIntensity;

   Blend with original widget (Assuming widget is white)
    vec3 baseColor = vec3(1.0);White background (replace with actual texture if needed)
    vec3 finalColor = mix(baseColor, shadow, shadowIntensity);

   Output blended shadow
    fragColor = vec4(finalColor, 1.0);
}
