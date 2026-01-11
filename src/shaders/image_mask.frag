#version 440

// this shader adds an arbitrary border radius, and/or allows it to be greyscaled.

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float radius;
    vec2 size;
    bool grayscale;
};

layout(binding = 1) uniform sampler2D source;

void main() {
    vec2 uv = qt_TexCoord0;

    vec2 r = radius / size;

    vec2 p = uv - 0.5;
    vec2 scale = vec2(1.0 / r.x, 1.0 / r.y);
    vec2 d = abs(p) - (vec2(0.5) - r);

    vec2 dScaled = vec2(
        d.x * scale.x,
        d.y * scale.y
    );

    float dist = length(max(dScaled, 0.0)) + min(max(dScaled.x, dScaled.y), 0.0);

    float pixel = 0.5 / min(size.x, size.y);
    float inside = step(dist, 1.0 + pixel);

    vec4 tex = texture(source, uv);

    float g = dot(tex.rgb, vec3(0.344, 0.5, 0.156));
    vec3 color = mix(tex.rgb, vec3(g), float(grayscale));

    fragColor = vec4(color, tex.a) * qt_Opacity * inside;
}
