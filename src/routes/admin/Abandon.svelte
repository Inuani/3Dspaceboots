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
            console.log("ownership set", ownerhsip)
            button.disabled = false;
        } catch (err) {
            console.error(err);
        }

    }

    let button;
    let message: string;

</script>


<RadioButton legend="How do you abandon the object ?" values={abandoning_events()} bind:value={new_event_name} />
<textarea bind:value={message} placeholder="message..." />
<button bind:this={button} on:click={abandon_object} >
    Abandon object
</button>