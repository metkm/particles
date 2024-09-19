varying vec2 vUv;

void main() {
  vUv = uv;
  vec4 mvPosition = modelViewMatrix * vec4( position, 1.0 );

  gl_PointSize = 1.0 * ( 20.0 / -mvPosition.z );
  gl_Position = projectionMatrix * mvPosition;
}
