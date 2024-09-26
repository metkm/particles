uniform float uTime;
uniform float uRadius;
uniform vec2 uResolution;
uniform vec2 uMouse;
varying vec2 vUv;

#define PI 3.1415926538

float atan2(float v1, float v2) {
  if (v2 == 0.0) {
    if (v1 == 0.0) return 0.0;
    if (v1 > 0.0) return 1.5707963267948966;
    if (v1 < 0.0) return -1.5707963267948966;
  }
  return atan(v1, v2);
}

void main() {
  vUv = uv;

  float pRadian = atan(position.y, position.x);
  float radianDiff = 170.0 - distance(uMouse, position.xy / uResolution.xy) * 30.0;

  float off = cos(pRadian * 20.0 + uTime) * radianDiff;
  float rad = uRadius + off;

  vec3 tPos = vec3(
    -rad * cos(pRadian),
    -rad * sin(pRadian),
    /////
    // position.x / (2.0 + cos(position.x + uTime)),
    // position.y / (2.0 + sin(position.x + uTime)),
    /////
    // position.x + (cos(position.x + uTime) + sin(position.y + uTime)) * 20.0,
    // position.y + (sin(position.y + uTime) + cos(position.x + uTime)) * 20.0,
    //
    position.z
  );

  vec4 mvPosition = modelViewMatrix * vec4(tPos.x, tPos.y, 1.0, 1.0);

  gl_PointSize = 1.0 * (20.0 / -mvPosition.z);
  gl_Position = projectionMatrix * mvPosition;
}
