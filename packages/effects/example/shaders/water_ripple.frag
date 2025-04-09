#version 460 core
precision mediump float;

uniform vec2 uSize;
uniform vec2 uOffset;
uniform float utime;

out vec4 fragColor;

void main() {
    // Normalize coordinates to [-1, 1] and correct aspect ratio
    vec2 uv = (gl_FragCoord.xy / uSize) * 2.0 - 1.0;
    uv.x *= uSize.x / uSize.y; // Maintain aspect ratio

    // Simulate perspective by modifying Y-axis (depth effect)
    float perspective = 1.5 / (1.5 - uv.y); // Fake depth scaling
    vec2 distortedUV = uv * perspective;   // Apply depth scaling

    // Compute radial distance with depth factor
    float r = length(distortedUV) * 5.0; // Scaled for stronger effect

    // Add multiple wave layers
    float wave1 = sin(r - utime * 3.0) / (r + 1.0);
    float wave2 = sin(r * 1.5 - utime * 4.0) / (r + 1.0);
    float wave3 = sin(r * 0.8 - utime * 2.0) / (r + 1.0);
    float combinedWave = (wave1 + wave2 + wave3) / 3.0;

    // Distort UV coordinates based on wave height
    vec2 rippleUV = uv + combinedWave * 0.1;

    // Simulate light reflection
    vec3 lightDir = normalize(vec3(1.0, 1.0, -1.0)); // Light direction
    vec3 normal = vec3(0.0, combinedWave, 1.0); // Fake normal based on wave
    float reflection = max(dot(normal, lightDir), 0.0);
    vec3 reflectionColor = vec3(reflection * 0.5); // Adjust reflection intensity

    // Depth-based color variation
    vec3 shallowColor = vec3(0.0, 0.6, 1.0); // Light blue for shallow water
    vec3 deepColor = vec3(0.0, 0.2, 0.5); // Dark blue for deep water
    vec3 depthColor = mix(shallowColor, deepColor, perspective);

    // Combine base color with highlights and reflection
    vec3 color = depthColor + reflectionColor + combinedWave * 0.1;

    // Apply depth fading (distant waves are faded)
    color *= mix(0.5, 1.0, perspective);

    fragColor = vec4(color, 1.0);
}