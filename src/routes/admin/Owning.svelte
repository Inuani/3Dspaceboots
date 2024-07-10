<script lang="ts">
    import { backendActor } from "$lib/actor";
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


<RadioButton legend="How did you got the object ?" values={owning_events()} bind:value={new_event_name} />
<p> To own the shoes, paste a valid NFC scan of the shoes</p>
<input bind:value={url} placeholder="URL..." type="text">
<p>enter your name: </p>
<input bind:value={name} placeholder="Name..." type="text">
<input type="text" bind:value={message} placeholder="message..." >
<button on:click={own_object} >
    own object
</button>