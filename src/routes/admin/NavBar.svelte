<!-- NavBar.svelte -->

<script>
    import { authStore } from "$lib/auth";

    export let tabs = ["update", 'abandon', 'history', "more"];
    export let activeTab = tabs[0]; // Default active tab
    const setActiveTab = (tab) => {
      activeTab = tab;
    };
  
    // Function to switch active tab and render corresponding form
    const switchTab = (tab) => {
      setActiveTab(tab);
      // You can add logic to handle form switching here
    };


    activeTab = tabs[0]

  </script>
  
  <style>
    /* Neo-brutalism styling */
    .nav {
      display: flex;
      justify-content: space-around;
      background-color: var(--background2); /* Light grey background */
      padding: 20px 0;
      border: 2px solid var(--border); /* Bold borders */
      box-shadow: 5px 5px 0 var(--border); /* Bold shadow for depth */
      border-radius: 5px;
      margin: 5vw;
      margin-top: 1vw;
      
    }
  
    .nav-item {
      cursor: pointer;
      padding: 15px 30px;
      transition: all 0.3s ease;
      background-color: var(--background); /* White background for nav items */
      border: 2px solid var(--border); /* Bold border for nav items */
      font-family: 'Arial var(--border)', sans-serif; /* Bold font */
      font-size: 1.2rem;
      text-transform: uppercase; /* Uppercase text */
      box-shadow: 5px 5px 0 var(--border); /* Bold shadow for depth */
      border-radius: 5px;
    }
  
    .nav-item:hover {
      background-color: var(--main-color-hover); /* Vibrant yellow on hover */
      transform: translate(5px, 5px); /* Slight lift effect on hover */
      box-shadow: 0px 0px 0; /* Bold shadow for depth */

      
    }
  
    .active {
      background-color: var(--main-color); /* Bright orange for active tab */
      color: white; /* White text for active tab */
    }

    @media (orientation: portrait) {
        .nav{
        position: absolute;
        bottom: 0px;
        width: 90%;
        }
    }
  
  </style>
  
  <div class="nav">

    <!-- <div class="nav-item {activeTab === 'modify' ? 'active' : ''}" on:click={() => switchTab('modify')}>
        Modify
      </div> -->
    {#each tabs as tab}
        <div class="nav-item {activeTab === tab ? 'active' : ''}" on:click={() => switchTab(tab)}>
            {tab}
        </div>
    {/each}
    <!-- <slot></slot> -->
  </div>