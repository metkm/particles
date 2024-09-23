<script setup lang="ts">
import { BufferGeometry, BufferAttribute, DataTexture, FloatType, RGBAFormat, Vector2 } from 'three'

import simVertex from '~/shader/simulation.vert?raw'
import simFrag from '~/shader/simulation.frag?raw'

const width = window.innerWidth
const height = window.innerHeight
const size = 80
const r = 400

const { onLoop } = useRenderLoop()

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
  resolution: { value: new Vector2(size, size) },
  uTexture: { value: dataTexture },
  uTextureSize: { value: size },
  uRadius: { value: r },
  uTime: { value: 0 },
}

// onMounted(() => {
//   geometry.value?.setAttribute('position', new BufferAttribute(offsets, 3))
// })

onLoop(({ elapsed }) => {
  uniforms.uTime.value = elapsed
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
