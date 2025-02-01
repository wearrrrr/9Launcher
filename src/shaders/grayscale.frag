#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
};
layout(binding = 1) uniform sampler2D source;
void main() {
    vec4 p = texture(source, qt_TexCoord0);
    float g = dot(p.xyz, vec3(0.344, 0.5, 0.156));
    fragColor = vec4(g, g, g, p.a) * qt_Opacity;
}