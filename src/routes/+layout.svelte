<script>
  import { page } from '$app/stores';
  import { onMount } from 'svelte';
  import { ic } from '../lib/stores/ic';

  let valid_scan = false;

  const checkValidScan = async () => {
    try {
      console.log($page.url.href);
      valid_scan = await $ic.actor.url_scan_tag($page.url.href);
    } catch (err) {
      console.error(err);
    }
  };

  onMount(() => {
    checkValidScan();
  });
</script>

<!-- <main>
  {#if valid_scan}
    <slot />
  {:else}
    <p>Scan error</p>
  {/if}
</main> -->

<div class="scene">
	<slot />
</div>

<svelte:head>
	<title>Threlte</title>
</svelte:head>

<style>
	.scene {
		position: absolute;
		inset: 0;
		background: radial-gradient(hsl(220 14% 20%), hsl(220 20% 10%));
	}
</style>

