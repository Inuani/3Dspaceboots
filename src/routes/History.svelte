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
        return new Date(milliseconds);
    }

  </script>
  

  <style>
    /* Neo-brutalism styling */
    .timeline {
      overflow-y: auto;
      max-height: 400px; /* Adjust as needed */
      padding: 20px;
      border: 2px solid black; /* Bold borders */
      background-color: #f0f0f0; /* Light grey background */
      box-shadow: 10px 10px 0 black; /* Bold shadow for depth */
    }
  
    .event {
      margin-bottom: 20px;
      padding: 20px;
      border-left: 5px solid #ff5733; /* Bright orange for event border */
      background-color: #ffffff; /* White background for events */
      border: 2px solid black; /* Bold border for events */
      box-shadow: 5px 5px 0 black; /* Bold shadow for events */
      font-family: 'Arial Black', sans-serif; /* Bold font */
      font-size: 1rem;
      text-transform: uppercase; /* Uppercase text */
    }
  
    .event-type {
      font-weight: bold;
      margin-bottom: 10px;
      color: #ff5733; /* Bright orange for event type */
    }
  
    .event-details {
      margin-left: 20px;
      color: #333333; /* Dark grey for event details */
    }
  
    .event-details p {
      margin: 5px 0; /* Consistent spacing for paragraphs */
    }
  </style>


{#await get_history()}
    mmmm...
{:then _} 
    <div class="timeline">
        {#each history as event}
        <div class="event">
            <div class="event-type">Type: {event.event_type}</div>
            <div>Name: {event.event_name}</div>
            <div class="event-details">

            {#if event.owner_name.length > 0}
            
                <p>Owner: {event.owner_name[0] || 'Unknown'}</p>
            {/if}

            {#if event.message}
            
                <p>Message: {event.message}</p>
            {/if}
            <p>Scan Count at the event: {event.scan_count}</p>
            <p>Time: {nanosecondsToDate(event.time)}</p>
            </div>
        </div>
        {/each}
    </div>
    <!-- <p>
        {#each history as event}
            {event_type = Object.keys(event.event_type)}
        {/each}
    </p> -->
{/await}

