<script lang="ts">
	import { T, useFrame, Canvas } from '@threlte/core'
	import { OrbitControls, useGltf } from '@threlte/extras'
    import { onMount } from 'svelte';
    export let valid = false;

    let y = 0;
	let rotation = 0

//   // Spooky floating ghost 👻
	function levitate() {
		const time = Date.now() / 1000
		const speed = 1
		const offset = 3
		y = Math.sin(time * speed) + offset
		requestAnimationFrame(levitate)
	}

  // Rotates model on `Y` axis
	levitate()

    onMount(async () => {
        
        useFrame((_, delta) => {
            rotation += delta * 0.4
        })
    });

</script>

    <div>

        <Canvas>
            <T.OrthographicCamera position={[20, 20, 20]} zoom={40} makeDefault>
                <OrbitControls autoRotate enableDamping rotateSpeed={valid ? 1 : 0} />
            </T.OrthographicCamera>
        <T.AmbientLight color="#ffffff" intensity={valid ? 3 : 0.5} />
            
            
            {#await useGltf('/shoe/lowpoly.gltf') then ghost}
                <T is={ghost.scene} position={[0, 0, 0]} scale={0.6} rotation={[0, Math.PI * rotation, Math.PI * 0]} />
            {/await}
        </Canvas>
    </div>

<style>
    div {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 30vw;
        width: 30vw;
		background: radial-gradient(var(--main-color-hover), var(--main-color) );
        border: 2px solid var(--border);
        border-radius: 5px;
        box-shadow: 5px 5px 0 var(--border);

    }

    @media (orientation: portrait) {
        div {
            height: 80vmin;
            width: 80vmin;
        }
    }

</style>


