

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
  

  
      let last_event;

      onMount(async () => {
        await init();
        await checkValidScan();
      });
  
    const handleLogin = () => authStore.signIn();
  
    let valid_scan = false;
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
        owner = await $backendActor.owning_state();
    }


  </script>

{#if $isUserAuthStore}
    

    {#await get_last_event()}
        <p>loading...</p>
    {:then _}

        
        {#if owner != 1}

            {#if owner == 0}
                <NavBar bind:activeTab={active_tab} tabs= {["own", "update", "history"]}/>

                {#if active_tab == "own"}
                    Shoes are ownable
                    <Owning />
                {/if}
            {:else}
                <NavBar bind:activeTab={active_tab} tabs= {["update", "history"]}/>
            {/if}

            {#if active_tab == "update"}
                <Update owner={owner} />
            {/if}

            {#if active_tab == "history"}
                <History />
            {/if}

        {:else}

        <NavBar bind:activeTab={active_tab}>
        <button on:click={ () => authStore.signOut() }>logout</button>
        </NavBar>

        {#key active_tab}
            
        <div in:fade|global>
            {#if active_tab == "modify"}
                <Modify />
            {:else if active_tab == "update"}
                <Update owner={owner} />
            {:else if active_tab == "abandon"}
                <Abandon />
            {:else}
                <History />
            {/if}
        </div>
        {/key}
            <!-- <Modify />
            <Share />
            <Abandon />
            <Destroy /> -->

        {/if}
    <!-- {:catch error}
        <p>errorm: {error.message}</p> -->
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


{:else}
    <button on:click={handleLogin}>login</button>
{/if}







  <style>

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