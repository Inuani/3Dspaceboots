<script lang="ts">
    import { backendActor } from "$lib/actor";
    import { modification_events } from "$lib/event";


    import RadioButton from "./RadioButton.svelte";


    let new_event_name = "";

    async function modify_object() {

        if (new_event_name == "") {
            return
        }

        try {
            let ownerhsip = await $backendActor.modify_asset(new_event_name, message);
            console.log("ownership set", ownerhsip)
        } catch (err) {
            console.error(err);
        }

    }

    let message: string;

</script>


<RadioButton legend="How did you modify the object ?" values={modification_events()} bind:value={new_event_name} />
<textarea bind:value={message} placeholder="message..." />
<button on:click={modify_object} >
    Modify object
</button>