<script lang="ts">

    export let legend : string ;
    export let values : string[] ;
    export let value : string ;

</script>

<style>
    /* Neo-brutalism styling */
    fieldset {
        border: 2px solid var(--border); /* Bold borders */
        padding: 20px;
        background-color: var(--background2); /* Light grey background */
        box-shadow: 10px 10px 0 var(--border); /* Bold shadow for depth */
        font-family: 'Arial var(--border)', sans-serif; /* Bold font */
        font-size: 1rem;
        text-transform: uppercase; /* Uppercase text */
        margin-bottom: 20px; /* Space between form elements */
        border-radius: 5px;
    }

    legend {
        padding: 0 10px;
        font-weight: bold;
        color: var(--main-color); /* Bright orange for legend */
    }

    div {
        margin-bottom: 10px;
        border-radius: 5px;
    }

    input[type="radio"] {
        margin-right: 10px;
    }

    label {
        cursor: pointer;
    }

    input[type="radio"]:checked + label {
        color: var(--main-color-hover); /* Darker red for selected label */
        font-weight: bold; /* Bold text for selected label */
    }
</style>

<fieldset>
    <legend>{legend}</legend>
    {#each values as event_name}
        <div>
            <input type="radio" id="{event_name}" name="drone" value="{event_name}" bind:group={value} checked />
            <label for="{event_name}">{event_name}</label>
        </div>
    {/each}
</fieldset>