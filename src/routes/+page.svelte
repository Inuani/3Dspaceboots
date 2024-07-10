<script lang="ts">

  
	import { Canvas } from '@threlte/core'
	import Scene from './scene.svelte'


    import { page } from '$app/stores';
    import { onMount } from 'svelte';
    import { authStore } from '$lib/auth';
    import { backendActor } from '$lib/actor';
    import { browser } from '$app/environment';
    import History from './History.svelte';
  
      const init = async () => {
        await Promise.all([
            syncAuthStore(),
        ]);
      };
  
      const syncAuthStore = async () => {
      if (!browser) {
          return;
      }
      try {
          await authStore.sync();
      } catch (err: unknown) {
          console.error(err);
      }
      };
  
  
      onMount(async () => {
        await init();
        checkValidScan();
      });
  
    let valid_scan = false;
  
    const checkValidScan = async () => {
      try {
        console.log($page.url.href);
        valid_scan = await $backendActor.url_scan_tag($page.url.href);
      } catch (err) {
        console.error(err);
      }
    };
   

</script>
<main class="scene">
    <h1>New shoe</h1>
    <!-- {#if valid_scan} -->
        <Canvas>
            <Scene valid={valid_scan}/>
        </Canvas>
        <History />
    <!-- {:else}
      <p>Scan error</p>
    {/if} -->
</main>

<style>
	.scene {

		position: absolute;
		inset: 10%;
        color: aliceblue;
        font-family: 'Roboto', sans-serif;
        text-align: center;
		background: radial-gradient(hsl(0, 72%, 67%), hsl(0, 66%, 33%));
        
	}
</style>