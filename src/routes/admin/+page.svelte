

<script lang="ts">
    import { page } from '$app/stores';
    import { onMount } from 'svelte';
    // import { ic } from '../lib/stores/ic';
    import { authStore, isUserAuthStore } from '$lib/auth';
    import type { AuthStoreData } from '$lib/auth'; 
    import { backendActor } from '$lib/actor';
    import { browser } from '$app/environment';
    import History from '../History.svelte';
    import { abandoning_events, destruction_events, modification_events, owning_events, temporary_shared_events } from '$lib/event';
    import RadioButton from './RadioButton.svelte';
    import Owning from './Owning.svelte';
    import Modify from './Modify.svelte';
    import Update from './Update.svelte';
    import Abandon from './Abandon.svelte';
    import NavBar from './NavBar.svelte';
    import { fade } from 'svelte/transition';
    import Scene from '../scene.svelte';
    import More from './More.svelte';
    import Login from './Login.svelte';



    // export type EventType = { 'Lost' : null } |
//   { 'NewOwner' : null } |
//   { 'Stolen' : null } |
//   { 'Found' : null } |
//   { 'Created' : null } |
//   { 'OwnerShipAbandoned' : null };

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
  

    const checkValidScan = async () => {
      try {
        console.log($page.url.href);
        valid_scan = await $backendActor.url_scan_tag($page.url.href);
      } catch (err) {
        console.error(err);
      }
    };

    let last_event_type: string = "";
    let active_tab : string;
    let owner = 0;
  
    async function get_last_event(){
        // last_event = await $backendActor.get_last_event();
        // console.log(last_event)
        await init();
        owner = await $backendActor.owning_state();
        console.log(owner);
        console.log(active_tab)
    }

    let updated = false;

    $: updated && (active_tab = "history");

    let _height: number, _width : number;


  </script>

    <svelte:window bind:innerWidth={_width}  bind:innerHeight={_height} />

    {#await get_last_event()}
        <p>loading...</p>
    {:then _}

            {#key $isUserAuthStore}
                
                {#if !$isUserAuthStore}
                    <NavBar bind:activeTab={active_tab} tabs= {["own", "update", "history"]}/>
                {:else if owner == 0}
                    <NavBar bind:activeTab={active_tab} tabs= {["own", "update", "history", "more"]}/>
                {:else if owner == 2}
                    <NavBar bind:activeTab={active_tab} tabs= {["update", "history", "more"]}/>
                {:else}
                    <NavBar bind:activeTab={active_tab}></NavBar>
                {/if}

            {/key}
            
        <div >
            <div class="content">

                <div class = "left">

                    <Scene valid={owner == 1}/>
                </div>

                {#key active_tab}
                    <div in:fade|global class="right">

                        {#if active_tab == "update"}
                            <Update bind:updated={updated} owner={owner} />
                        {:else if active_tab == "abandon"}
                            <Abandon />
                        {:else if active_tab == "own"}
                            {#if $isUserAuthStore}
                                <Owning />
                            {:else}
                                <Login />
                            {/if}
                        {:else if active_tab == "history"}
                            <History />
                        {:else if active_tab == "more"}
                            <More />
                        {:else}
                            <h1>404</h1>
                        {/if}
                    </div>
                {/key}
            </div>
        </div>


    {/await}


    
        
<!--     
    {#if last_event == 0}
        <h3> The shoes are not own </h3>
        <p> To own the shoes, paste a valid NFC scan of the shoes</p>
        
        <input bind:value={url} placeholder="URL..." type="text">
        <p>enter your name: </p>
        <input bind:value={name} placeholder="Name..." type="text">
        <button on:click={get_last_eventship} >
            get last_eventship
        </button>
    {:else}
        <p> The shoes are own by {last_event[0].name} </p>
    {/if} -->


    <!-- <button on:click={handleLogin}>login</button> -->








  <style>

.content {
    display: flex;
    justify-content: center;
    gap: 2vw;
    align-items: center;
    /* height: 100vw;
    width: 100vw; */
    /* background-color: #f0f0f0; */
    font-family: 'Roboto', sans-serif;
    font-size: 1.5rem;
    color: #333;
    height: 30vw;
}
.right {
    display: flex;
    justify-content: center;
    width: 50%;
    height: 30vw;
}

@media (orientation: portrait) {
    .content {
        flex-direction: column;
        gap: 5vw;
    }

    .right {
        width: 80vw;
        height: 50vw;
    }
    .left {
        width: 10vmin;
        height: 10vmin;
    }
}


    * {
        font-family: 'Roboto', sans-serif;
    }

    p,
    label {
    font:
        1rem 'Fira Sans',
        sans-serif;
    }

    input {
    margin: 0.4rem;
    }

  </style>