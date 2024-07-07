<script lang="ts">
  import { page } from '$app/stores';
  import { onMount } from 'svelte';
  // import { ic } from '../lib/stores/ic';
  import { authStore, isUserAuthStore } from '$lib/auth';
  import type { AuthStoreData } from '$lib/auth'; 
  import { backendActor } from '$lib/actor';
  import { browser } from '$app/environment';

    const init = async () => {
    await Promise.all([
        syncAuthStore(),
    ]);
    };

    const syncAuthStore = async () => {
    if (!browser) {
        return;
    }
    try {
        await authStore.sync();
    } catch (err: unknown) {
        console.error(err);
    }
    };


    onMount(async () => {
      await init();
      checkValidScan();
    });

  const handleLogin = () => authStore.signIn();
  const handleLogout = () => authStore.signOut();

  let valid_scan = false;

  const checkValidScan = async () => {
    try {
      console.log($page.url.href);
      valid_scan = await $backendActor.url_scan_tag($page.url.href);
    } catch (err) {
      console.error(err);
    }
  };

</script>

<!-- <main>
  {#if valid_scan}
    <slot />
  {:else}
    <p>Scan error</p>
  {/if}
</main> -->

{#if $isUserAuthStore}
    <button on:click={handleLogout}>logout</button>
{:else}
    <button on:click={handleLogin}>login</button>
{/if}

<!-- <div class="scene">
	<slot />
</div>

<svelte:head>
	<title>Threlte</title>
</svelte:head> -->

<style>
	.scene {
		position: absolute;
		inset: 0;
		background: radial-gradient(hsl(220 14% 20%), hsl(220 20% 10%));
	}
</style>

