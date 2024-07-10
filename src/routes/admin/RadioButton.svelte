<script lang="ts">

    export let legend : string ;
    export let values : string[] ;
    export let value : string ;

</script>

<fieldset>
    <legend>{legend}</legend>
    {#each values as event_name}
        <div>
            <input type="radio" id="{event_name}" name="drone" value="{event_name}" bind:group={value} checked />
            <label for="{event_name}">{event_name}</label>
        </div>
        
    {/each}
</fieldset>