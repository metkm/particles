precision highp float;

uniform sampler2D uTexture;
uniform float uTextureSize;
uniform vec2 uResolution;

varying vec2 vUv;

void main() {
  // vec2 uv = gl_FragCoord.xy / resolution;
  // uv.x *= resolution.x / resolution.y;

  vec4 pix = texture2D(uTexture, vUv);

  gl_FragColor = vec4(vec3(1.0), 1.0);
}
