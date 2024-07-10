<script lang="ts">
    import { backendActor } from "$lib/actor";
    import { abandoning_events, temporary_shared_events } from "$lib/event";
    import Scene from "../scene.svelte";

	import { Canvas } from '@threlte/core'

    import RadioButton from "./RadioButton.svelte";

    export let updated = false;
    export let owner = 0;
    let new_event_name = "";

    async function share_object() {

        if (event_name == "") {
            return
        }

        try {
            let ownerhsip = await $backendActor.update_asset(url,event_name, "", message);
            updated = true;
        } catch (err) {
            console.error(err);
        }

    }

    let message: string;
    let event_name: string;

    function nanoseconds_to_time(nanoseconds: bigint) {
        nanoseconds = nanoseconds / 1000000000n;
        let seconds = nanoseconds % 60n;
        nanoseconds = nanoseconds / 60n;
        let minutes = nanoseconds % 60n;
        nanoseconds = nanoseconds / 60n;
        let hours = nanoseconds % 24n;
        return `${hours} hours, ${minutes} minutes, ${seconds} seconds`;
    }

    var nanosecond_per_day =  1000000000n * 60n * 60n * 24n
    var url = "";
</script>


<style>

    p {
        margin: auto;
    }
    /* Neo-brutalism styling */
    .container {
        /* max-width: 60%; */
        height: 26vw;
        margin: 0 auto;
        padding: 2vw;
        border: 2px solid var(--border); /* Bold borders */
        background-color: #f0f0f0; /* Light grey background */
        box-shadow: 10px 10px 0 var(--border); /* Bold shadow for depth */
        font-family: 'Arial var(--border)', sans-serif; /* Bold font */
        font-size: 1rem;
        text-transform: uppercase; /* Uppercase text */
        border-radius: 5px;

        width: 100%;
    }

    input[type="text"],
    textarea {
        width: 100%;
        padding: 1vw;
        margin: 1vw 0;
        border: 2px solid var(--border); /* Bold borders */
        box-sizing: border-box;
        font-size: 1rem;
        background-color: var(--background); /* White background for inputs */
        box-shadow: 5px 5px 0 var(--border); /* Bold shadow for inputs */
        resize: vertical;
        border-radius: 5px;
    }

    button {
        transition: all 0.3s ease;
        background-color: var(--main-color); /* Bright orange background */
        color: white; /* White text */
        padding: 15px 30px;
        border: 2px solid var(--border); /* Bold border */
        cursor: pointer;
        font-size: 1rem;
        box-shadow: 5px 5px 0 var(--border); /* Bold shadow */
        text-transform: uppercase; /* Uppercase text */
        border-radius: 5px;
    }

    button:hover {
      background-color: var(--main-color-hover); /* Vibrant yellow on hover */
      transform: translate(5px, 5px); /* Slight lift effect on hover */
      box-shadow: 0px 0px 0; /* Bold shadow for depth */
    }

</style>

<div class="container">
    {#if owner != 1}
        {#await $backendActor.get_timer()}
            <p>loading timer...</p>
        {:then time}
            {#if time > nanosecond_per_day}
                <input bind:value={event_name} placeholder="Event name..." type="text">
                <textarea bind:value={message} placeholder="Message..."  ></textarea>
                <input bind:value={url} placeholder="New scan..." type="text">
                <button on:click={share_object}>Post object update</button>
            {:else}
                <p>{nanoseconds_to_time(nanosecond_per_day - time)} before next update.</p>
            {/if}
        {/await}
    {:else}
        <input bind:value={event_name} placeholder="Event name..." type="text">
        <textarea bind:value={message} placeholder="Message..."  ></textarea>
        <button on:click={share_object}>Post object update</button>
    {/if}

    <!-- Example RadioButton usage (if uncommented in your actual code) -->
    <!-- <RadioButton legend="How do you Update the object?" values={temporary_shared_events()} bind:value={new_event_name} /> -->
</div>