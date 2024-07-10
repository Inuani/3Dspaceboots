<!-- NavBar.svelte -->

<script>
    import { authStore } from "$lib/auth";

    export let tabs = ["update", 'modify', 'abandon', 'history'];
    export let activeTab = tabs[0]; // Default active tab
    const setActiveTab = (tab) => {
      activeTab = tab;
    };
  
    // Function to switch active tab and render corresponding form
    const switchTab = (tab) => {
      setActiveTab(tab);
      // You can add logic to handle form switching here
    };

  </script>
  
  <style>
    /* Neo-brutalism styling */
    .nav {
      display: flex;
      justify-content: space-around;
      background-color: #f0f0f0; /* Light grey background */
      padding: 20px 0;
      border: 2px solid black; /* Bold borders */
    }
  
    .nav-item {
      cursor: pointer;
      padding: 15px 30px;
      transition: background-color 0.3s ease, transform 0.3s ease;
      background-color: #ffffff; /* White background for nav items */
      border: 2px solid black; /* Bold border for nav items */
      font-family: 'Arial Black', sans-serif; /* Bold font */
      font-size: 1.2rem;
      text-transform: uppercase; /* Uppercase text */
      box-shadow: 5px 5px 0 black; /* Bold shadow for depth */
    }
  
    .nav-item:hover {
      background-color: #ffcc00; /* Vibrant yellow on hover */
      transform: translate(-2px, -2px); /* Slight lift effect on hover */
    }
  
    .active {
      background-color: #ff5733; /* Bright orange for active tab */
      color: white; /* White text for active tab */
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