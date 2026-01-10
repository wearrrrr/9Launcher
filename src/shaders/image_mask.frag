#version 440

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
    float u = qt_TexCoord0.x;
    float v = qt_TexCoord0.y;
    float r_u = radius / size.x;
    float r_v = radius / size.y;
    bool inside = false;
    if (u >= r_u && u <= 1.0 - r_u && v >= r_v && v <= 1.0 - r_v) {
        inside = true;
    } else if (u < r_u && v < r_v) {
        float dx = u - r_u;
        float dy = v - r_v;
        if (dx * dx + dy * dy <= r_u * r_u) inside = true;
    } else if (u < r_u && v > 1.0 - r_v) {
        float dx = u - r_u;
        float dy = v - (1.0 - r_v);
        if (dx * dx + dy * dy <= r_u * r_u) inside = true;
    } else if (u > 1.0 - r_u && v < r_v) {
        float dx = u - (1.0 - r_u);
        float dy = v - r_v;
        if (dx * dx + dy * dy <= r_u * r_u) inside = true;
    } else if (u > 1.0 - r_u && v > 1.0 - r_v) {
        float dx = u - (1.0 - r_u);
        float dy = v - (1.0 - r_v);
        if (dx * dx + dy * dy <= r_u * r_u) inside = true;
    } else if ((u < r_u && v >= r_v && v <= 1.0 - r_v) ||
               (u > 1.0 - r_u && v >= r_v && v <= 1.0 - r_v) ||
               (v < r_v && u >= r_u && u <= 1.0 - r_u) ||
               (v > 1.0 - r_v && u >= r_u && u <= 1.0 - r_u)) {
        inside = true;
    }
    if (!inside) {
        fragColor = vec4(0.0);
    } else {
        vec4 p = texture(source, qt_TexCoord0);
        vec3 color;
        if (grayscale) {
            float g = dot(p.xyz, vec3(0.344, 0.5, 0.156));
            color = vec3(g);
        } else {
            color = p.xyz;
        }
        fragColor = vec4(color, p.a) * qt_Opacity;
    }
}