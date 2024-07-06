<script lang="ts">
	import { T, useFrame } from '@threlte/core'
	import { OrbitControls, useGltf } from '@threlte/extras'

	let y = 2
	let rotation = 0

  // Spooky floating ghost 👻
	function levitate() {
		const time = Date.now() / 1000
		const speed = 1
		const offset = 3
		y = Math.sin(time * speed) + offset
		requestAnimationFrame(levitate)
	}

  // Rotates model on `Y` axis
	useFrame((_, delta) => {
		rotation += delta * 0.4
	})

	levitate()
</script>

<!-- Bloom postprocessing effect -->

<!-- Orthographic camera -->
<T.OrthographicCamera position={[10, 10, 10]} zoom={40} makeDefault>
	<!-- Controls -->
	<OrbitControls enableDamping />
</T.OrthographicCamera>

<!-- Ambient light for ambience -->
<T.AmbientLight color="#ffffff" intensity={10} />

<!-- Main light -->
<!-- <T.PointLight intensity={2} position={[4, 2, 4]} color="#76aac8" /> -->

<!-- Ghost -->
{#await useGltf('/shoe.glb') then ghost}
	<T is={ghost.scene} position={[0, 0, 0]} scale={4} />
{/await}

<!-- Garden -->
<!-- {#await useGltf('/assets/garden.glb') then garden}
	<T is={garden.scene} rotation.y={rotation} />
{/await} -->
