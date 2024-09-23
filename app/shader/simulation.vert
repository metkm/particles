uniform float uTime;
uniform float uRadius;
varying vec2 vUv;

void main() {
  vUv = uv;

  float radian = atan(position.y, position.x);
  float degree = radian * (180.0 / 3.141592653589793);

  float off = cos(radian * 20.0 + uTime) * 4.0;

  vec3 tPos = vec3(
    (uRadius + off) * cos(radian),
    (uRadius + off) * sin(radian),
    /////`
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
