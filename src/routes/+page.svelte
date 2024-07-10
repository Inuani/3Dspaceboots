<script lang="ts">

  
	import { Canvas } from '@threlte/core'
	import Scene from './scene.svelte'


    import { page } from '$app/stores';
    import { onMount } from 'svelte';
    import { authStore } from '$lib/auth';
    import { backendActor } from '$lib/actor';
    import { browser } from '$app/environment';
    import History from './History.svelte';
    import { goto } from '$app/navigation';


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
  
    let valid_scan: boolean | null = null;
  
    const checkValidScan = async () => {
      try {
        console.log($page.url.href);
        valid_scan = await $backendActor.url_scan_tag($page.url.href);
      } catch (err) {
        console.error(err);
      }
    };
   
    checkValidScan()
</script>

<style>

    .main {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        margin: 0 auto;
        /* padding: 2vw; */
        gap: 2vw;
        font-family: 'Arial black', sans-serif; /* Bold font */
    }

    .history {
        /* height: 300vw; */
        width: 76vw;
        display: flex;
        flex-direction: column;
        justify-content: center;
        
    }

    button {
        background-color: var(--main-color); /* Bright orange background */
        color: white; /* White text */
        padding: 1vw 2vw;
        width: 80vw;
        border: 2px solid var(--border); /* Bold border */
        cursor: pointer;
        font-size: 1rem;
        box-shadow: 5px 5px 0 var(--border); /* Bold shadow */
        text-transform: uppercase; /* Uppercase text */
        border-radius: 5px;
        transition: all 0.3s ease;
    }

    button:hover {
        background-color: var(--main-color-hover); /* Darker red on hover */
        translate: 5px, 5px; /* Slight lift effect on hover */
        box-shadow: 0px 0px 0; /* Bold shadow for depth */
    }
</style>

<body>
    
<div class="main">

    {#if valid_scan === true}
        <p style="color:greenyellow;">Valid Scan</p>
    {:else if valid_scan === false}
        <p style="color:red;" >Invalid Scan</p>
    {:else}
        <p>loading...</p>
    {/if}


    <Scene bind:valid={valid_scan}/>



    <button on:click={() => goto("/admin")}>

        more

    </button>

    <div class="history">
        <History />
    </div>

</div>

</body>