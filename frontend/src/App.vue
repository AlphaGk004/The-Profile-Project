<script setup>
import Navbar from './components/Navbar.vue';
import Welcome from './views/WelcomeView.vue';
import profile from './views/ProfilePage.vue';
</script>

<template>
  <v-app>
    <v-main class="bg-grey-lighten-4">
      <v-container fluid class="fill-height">
        <router-view />
      </v-container>
    </v-main>

  </v-app>
</template>