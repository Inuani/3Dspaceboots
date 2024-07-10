<script lang="ts">
    import { backendActor } from "$lib/actor";
    import { abandoning_events } from "$lib/event";


    import RadioButton from "./RadioButton.svelte";


    let new_event_name = "";

    async function abandon_object() {

        if (new_event_name == "") {
            return
        }

        button.disabled = true;

        try {
            let ownerhsip = await $backendActor.abandon_ownership(new_event_name, message);
            button.disabled = false;
            location.reload();
        } catch (err) {
            console.error(err);
        }

    }

    let button;
    let message: string;

</script>

<style>
    /* Neo-brutalism styling */
    .container {
        /* max-width: 50vw; */
        height: 20vw;
        margin: 0 auto;
        padding: 5vw;
        border: 2px solid var(--border); /* Bold borders */
        background-color: #f0f0f0; /* Light grey background */
        box-shadow: 10px 10px 0 var(--border); /* Bold shadow for depth */
        font-family: 'Arial var(--border)', sans-serif; /* Bold font */
        font-size: 1rem;
        text-transform: uppercase; /* Uppercase text */
    }

    textarea {
        width: 100%;
        padding: 15px;
        margin: 20px 0;
        border: 2px solid var(--border); /* Bold borders */
        box-sizing: border-box;
        font-size: 1rem;
        background-color: var(--background); /* White background for textarea */
        box-shadow: 5px 5px 0 var(--border); /* Bold shadow for textarea */
        border-radius: 5px;
    }

    button {
        background-color: var(--main-color); /* Bright orange background */
        color: white; /* White text */
        padding: 15px 30px;
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

    .message {
        margin-top: 20px;
        font-size: 1rem;
        color: #333333; /* Dark grey for message */
    }

    .main {
        width: 100%;
        margin: 1%;
    }
</style>


<div class="main">

    <RadioButton legend="How do you abandon the object ?" values={abandoning_events()} bind:value={new_event_name} />
    <textarea bind:value={message} placeholder="message..." />
    <button bind:this={button} on:click={abandon_object} >
        Abandon object
    </button>
</div>