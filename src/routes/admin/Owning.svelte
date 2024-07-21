<script lang="ts">
    import { backendActor } from "$lib/actor";
    import { authStore, isUserAuthStore } from "$lib/auth";
    import { owning_events } from "$lib/event";


    import RadioButton from "./RadioButton.svelte";

    let new_event_name = "";

    async function own_object() {

        if (new_event_name == "") {
            return
        }

        try {
            let ownerhsip = await $backendActor.request_ownership(name, url, new_event_name, message);
            console.log("ownership set", ownerhsip)
            document.location.reload();
        } catch (err) {
            console.error(err);
        }

    }

    let url: string = "";
    let name: string = "";
    let message: string = "";

</script>


<style>

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
        border-radius: 5px;
        resize: vertical;
    }

    button {
        background-color: var(--main-color); /* Bright orange background */
        color: white; /* White text */
        padding: 1vw 2vw;
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

        box-shadow: 0px 0px 0 var(--border); /* Bold shadow */

        translate: 5px 5px;

    }

    .main {
        height: 30vw;
    }

 

</style>



<div class="main">

    
    
        <RadioButton legend="How did you got the object ?" values={owning_events()} bind:value={new_event_name} />
        <input bind:value={url} placeholder="URL..." type="text">
        <input bind:value={name} placeholder="Name..." type="text">
        <textarea type="text" bind:value={message} placeholder="message..."  />
        <button on:click={own_object} >
            own object
        </button>

</div>