<script lang="ts">
    import { backendActor } from "$lib/actor";
    import { abandoning_events, temporary_shared_events } from "$lib/event";


    import RadioButton from "./RadioButton.svelte";

    export let owner = false;
    let new_event_name = "";

    async function share_object() {

        if (event_name == "") {
            return
        }

        try {
            let ownerhsip = await $backendActor.update_asset("",event_name, "", message);
            console.log("ownership set", ownerhsip)
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

</script>


<style>
    /* Basic styling */
    .container {
        max-width: 600px;
        margin: 0 auto;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: #f9f9f9;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    input[type="text"],
    textarea {
        width: 100%;
        padding: 10px;
        margin: 10px 0;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 14px;
        resize: vertical;
    }

    button {
        background-color: #4caf50;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
    }

    button:hover {
        background-color: #45a049;
    }

    .message {
        margin-top: 10px;
        font-size: 14px;
        color: #888;
    }
</style>

<div class="container">
    {#if !owner}
        {#await backendActor.get_timer()}
            <p>loading timer...</p>
        {:then time}
            {#if time > nanosecond_per_day}
                <p>Stranger can send message</p>
            {:else}
                <p>Stranger cannot send message: {nanoseconds_to_time(nanosecond_per_day - time)} before next update.</p>
            {/if}
        {/await}
    {/if}

    <input bind:value={event_name} placeholder="Event name..." type="text">
    <textarea bind:value={message} placeholder="Message..."  ></textarea>
    <button on:click={share_object}>Share Object</button>

    <!-- Example RadioButton usage (if uncommented in your actual code) -->
    <!-- <RadioButton legend="How do you Update the object?" values={temporary_shared_events()} bind:value={new_event_name} /> -->
</div>