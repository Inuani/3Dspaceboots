<script lang="ts">


    import { page } from '$app/stores';
    import { onMount } from 'svelte';
    import { authStore, isUserAuthStore } from '$lib/auth';
    import type { AuthStoreData } from '$lib/auth'; 
    import { backendActor } from '$lib/actor';
    import { browser } from '$app/environment';
    import { abandoning_events, owning_events } from '$lib/event';

    let history: [any] = [];
    async function get_history() {
        history = await $backendActor.get_history();
        history.reverse()
        
    }

    function nanosecondsToDate(nanoseconds) {
        // Convert nanoseconds to milliseconds
        const milliseconds = Number(nanoseconds / BigInt(1_000_000));
        return new Date(milliseconds).toLocaleString();
    }

  </script>
  

  <style>
    
    .main  
    {

        /* max-height: 26vw; */
        padding: 2vw;
        border: 2px solid var(--border); /* Bold borders */
        background-color: var(--background2); /* Light grey background */
        box-shadow: 10px 10px 0 var(--border); /* Bold shadow for depth */
        border-radius: 5px;
        width: 100%;
    }

    /* Neo-brutalism styling */
    .timeline {
        overflow-y: auto;
        /* max-height: 26vw; */
        height: 100%;
        border-radius: 5px;
        width: 100%;
        padding: 2pw;
    }
  
    .event {
        margin-bottom: 20px;
        padding: 1vw;
        border-left: 5px solid var(--main-color); /* Bright orange for event border */
        background-color: var(--background); /* White background for events */
        border: 2px solid var(--border); /* Bold border for events */
        box-shadow: 5px 5px 0 var(--border); /* Bold shadow for events */
        font-family: 'Arial black', sans-serif; /* Bold font */
        font-size: 1rem;
        text-transform: uppercase; /* Uppercase text */
        border-radius: 5px;
    }
  
    .event-type {
      font-weight: bold;
      margin-bottom: 10px;
      color: var(--main-color); /* Bright orange for event type */
        border-radius: 5px;
    }
  
   
    .message {
        border: 2px solid var(--border); /* Bold border for message */
        border-radius: 5px;
        padding: 1vw;

    }

    @media (orientation: portrait) {
        .main {
            all: unset;
            height: 100vw;
        }
        .timeline {
            overflow: visible;
        }
    }
  </style>

<div class="main">
    
<div class="timeline">
{#await get_history()}
    <p>loading history...</p>
{:then _} 
        {#each history as event}
            <div class="event">
                <div class="event-type">{event.event_type}</div>
                <div style="color:var(--main-color-hover)" >{event.event_name}</div>
                <!-- <div class="event-details"> -->

                {#if event.owner_name.length > 0}
                    <p>writer: {event.owner_name[0] || 'Unknown'}</p>
                {/if}
                {#if event.message}
                
                    <fieldset class="message"> 
                        
                    <legend>content</legend>
                        {event.message}
                    </fieldset>
                {/if}
                <p>{nanosecondsToDate(event.time)}</p>
                </div>
            <!-- </div> -->
        {/each}

{/await}


</div>
</div>