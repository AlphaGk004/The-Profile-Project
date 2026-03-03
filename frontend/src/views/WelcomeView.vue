<script setup>
import { ref, onMounted } from 'vue'
import { PhHandWaving } from "@phosphor-icons/vue"
import { createTimeline, stagger, splitText } from 'animejs'

const textRef = ref(null)

onMounted(() => {
  const { words, chars } = splitText(textRef.value, {
    words: { wrap: 'clip' },
    chars: true,
  })

  createTimeline({
    loop: true,
    defaults: { ease: 'inOut(3)', duration: 1000 }
  })
    .add(words, {
      y: el => +el.dataset.line % 2 ? '100%' : '-100%',
    }, stagger(125))
    .add(chars, {
      y: el => +el.dataset.line % 2 ? '100%' : '-100%',
    }, stagger(10, { from: 'random' }))
    .init()
})
</script>

<template>
  <v-container fluid class="fill-height d-flex align-center justify-center">
    <v-card class="pa-6 mx-auto text-center" max-width="600">
      
      <v-card-title class="justify-center">
        <PhHandWaving  :size="100"  weight="light" />
      </v-card-title>
      <v-card-text>
        <div class="large centered grid square-grid">
          <p ref="textRef" class="text-xl" >
            Howdy, Folks!<br />
            அனைவருக்கும் வரவேற்கிறோம்
          </p>
        </div>
      </v-card-text>

    </v-card>
  </v-container>
</template>

<style scoped>
.text-xl {
  font-size: 1.5rem;
  letter-spacing: 0.06em;
  line-height: 1.35;
}
</style>