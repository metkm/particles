<script setup lang="ts">
import type { BufferGeometry } from 'three'
import { BufferAttribute, DataTexture, FloatType, RGBAFormat, Vector2 } from 'three'
import simVertex from '~/shader/simulation.vert?raw'
import simFrag from '~/shader/simulation.frag?raw'

const width = window.innerWidth
const height = window.innerHeight
const size = 5

const geometry = shallowRef<BufferGeometry>()
const offsets = new Float32Array(size * size * 3)

for (let i = 0; i < size; i++) {
  for (let j = 0; j < size; j++) {
    const index = i * size * 3 + j * 3
    const theta = Math.random() * Math.PI * 2

    offsets[index + 0] = 100 * Math.cos(theta)
    offsets[index + 1] = 100 * Math.sin(theta)

    // offsets[index + 0] = (Math.random() - 0.5) * width
    // offsets[index + 1] = (Math.random() - 0.5) * height
    offsets[index + 2] = 1.0
  }
}

const dataTexture = new DataTexture(offsets, size, size, RGBAFormat, FloatType)
dataTexture.needsUpdate = true

const uniforms = {
  resolution: { value: new Vector2(size, size) },
  uTexture: { value: dataTexture },
  uTextureSize: { value: size },
}

onMounted(() => {
  geometry.value?.setAttribute('position', new BufferAttribute(offsets, 3))
})
</script>

<template>
  <TresPoints>
    <TresBufferGeometry ref="geometry" />
    <TresShaderMaterial
      :fragment-shader="simFrag"
      :vertex-shader="simVertex"
      :uniforms="uniforms"
    />
  </TresPoints>
</template>
