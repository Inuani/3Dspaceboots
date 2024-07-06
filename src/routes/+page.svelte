<script lang="ts">
    import { ic } from '../lib/stores/ic';
    const about = "call sayHelloTo function";
    let input = '', greeting = '';
  
	import { Canvas } from '@threlte/core'
	import Scene from './scene.svelte'
  
    const clickMe = async () => {
      try {
        // Call the IC
        greeting = await $ic.actor.sayHelloTo(input);
  
      } catch (err: unknown) {
        console.error(err);
      }
    };
   
   </script>
  
     <div>
      <span class="highlight">{about}</span>
    </div>
   
     <form>
       <label for="name">Say hello to: </label>
       <input id="name" alt="Name" type="text" bind:value={input}/>
       <button type="button" on:click={clickMe}>Click Me!</button>
     </form>
   
   <div class="result">
    {greeting}
   </div>
   <style></style>

   
<Canvas>
	<Scene />
</Canvas>