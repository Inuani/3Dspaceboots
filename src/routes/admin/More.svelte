<script>

    import { authStore } from "$lib/auth";

</script>

<style>

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
        translate: 5px 5px;
        box-shadow: 0px 0px 0;
    }
.login {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    height: 30vw;

}

</style>


<div class="login">
    <!-- <p>You need to be logged in to get ownership of the object.</p>     -->
    <button on:click={ () => authStore.signOut()} >
        logout
    </button>
</div>