<script setup lang="ts">
import { BufferGeometry, BufferAttribute, DataTexture, FloatType, RGBAFormat, Vector2 } from 'three'

import simVertex from '~/shader/simulation.vert?raw'
import simFrag from '~/shader/simulation.frag?raw'

const width = window.innerWidth
const height = window.innerHeight
const size = 30
const r = 200

const { onLoop } = useRenderLoop()
const { x, y } = useMouse()

const geometry = new BufferGeometry()
const offsets = new Float32Array(size * size * 3)

for (let i = 0; i < size; i++) {
  for (let j = 0; j < size; j++) {
    const index = i * size * 3 + j * 3
    const theta = Math.random() * Math.PI * 2.0

    offsets[index + 0] = r * Math.cos(theta)
    offsets[index + 1] = r * Math.sin(theta)
    offsets[index + 2] = 0.0
  }
}

geometry.setAttribute('position', new BufferAttribute(offsets, 3))

const dataTexture = new DataTexture(offsets, size, size, RGBAFormat, FloatType)
dataTexture.needsUpdate = true

const uniforms = {
  uResolution: { value: new Vector2(size, size) },
  uMouse: { value: new Vector2(x.value, y.value) },
  uTexture: { value: dataTexture },
  uTextureSize: { value: size },
  uRadius: { value: r },
  uTime: { value: 0 },
}

onLoop(({ elapsed }) => {
  uniforms.uTime.value = elapsed
})

watch([x, y], () => {
  const normalizedX = x.value / width
  const normalizedY = 1 - (y.value / height)

  uniforms.uMouse.value.set(
    (normalizedX - 0.5),
    (normalizedY - 0.5),
  )
})
</script>

<template>
  <TresPoints :geometry="geometry">
    <TresShaderMaterial
      :fragment-shader="simFrag"
      :vertex-shader="simVertex"
      :uniforms="uniforms"
    />
  </TresPoints>
</template>
