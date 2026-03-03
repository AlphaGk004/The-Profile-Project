<script setup>
import { ref } from "vue";
import api from "@/services/api"
import { useRouter } from "vue-router";
import Welcome from "../views/WelcomeView.vue";
import { PhGoogleLogo, PhFacebookLogo, PhGithubLogo, PhRocketLaunch, PhFingerprint, PhEye, PhEyeSlash } from "@phosphor-icons/vue";
const router = useRouter();
const dialog = ref(false);
const form = ref(null);
const mode = ref("login")
const name = ref("")
const email = ref("");
const password_hash = ref("");
const dob = ref("");
const marriageStatus = ref("");
const gender = ref("");
const phoneNo = ref("");
const github = ref("");
const linkedin = ref("");
const twitter = ref("");
const instagram = ref("");
const leetcode = ref("");
const hackerrank = ref("");
const discord = ref("");
const slack = ref("");

const profilePic = ref("");
const document = ref("");
const cert = ref("");
const showPassword = ref(false);

const allowedDomains = ["gmail.com", "outlook.com", "hotmail.com", "live.com"];

const emailRules = [
  (v) => !!v || "Email is required",

  (v) => /^(.*@(gmail\.com|outlook\.com|hotmail\.com|live\.com))$/.test(v),
];
const passwordRules = [
  (v) => !!v || "Password is required",
  (v) => v.length >= 8 || "Minimum 8 characters",
  (v) => /[A-Z]/.test(v) || "Must include uppercase",
  (v) => /[0-9]/.test(v) || "Must include number",
];

const handleSubmit = async () => {
  try {
    if (mode.value === "login") {
      const payload = {
        email: email.value,
        password_hash: password_hash.value
      }

      const response = await api.post("/login", payload)

      if (response.data.status === "success") {
        localStorage.setItem("token", response.data.token)
        router.push("/profile")
      } else {
        alert("Invalid credentials")
      }
    } else {
      const payload = {
        name: name.value,
        email: email.value,
        password_hash: password_hash.value,
        dob: dob.value || null,
        marriage_status: marriageStatus.value || "~no_data~",
        gender: gender.value || "~no_data~",
        phone_no: phoneNo.value || "~no_data~",
        github: github.value || "~no_data~",
        linkedin: linkedin.value || "~no_data~",
        twitter: twitter.value || "~no_data~",
        instagram: instagram.value || "~no_data~",
        leetcode: leetcode.value || "~no_data~",
        hackerrank: hackerrank.value || "~no_data~",
        discord: discord.value || "~no_data~",
        slack: slack.value || "~no_data~",
        profile_pic: profilePic.value || "~no_data~",
        document: document.value || "~no_data~",
        cert: cert.value || "~no_data~"
      }
      const res = api.post("/register", payload)
      console.log("Register Success", res.data)
      mode.value = "login"
    }
  } catch (err) {
    console.log(err)
    if (mode.value === "login") {
      localStorage.removeItem("token")
      router.push("/")
    }
  }
}
</script>

<template>
  <v-app-bar app density="compact" fixed>
    <v-app-bar-title>
      <PhGoogleLogo :size="32" />
    </v-app-bar-title>
    <template v-slot:append>
      <v-btn variant="outlined" :ripple="false" color="red" class="mr-3" @click="dialog = true">
        <PhRocketLaunch :size="20" /><span class="text-caption">Get Started</span>
      </v-btn>
    </template>
  </v-app-bar>
  <Welcome />

  <v-dialog v-model="dialog" width="400">
    <v-card class="pa-6" width="400">
      <v-card-title class="text-h6 text-center">
        <PhFingerprint :size="80" weight="thin" />
      </v-card-title>

      <v-form ref="form">
        <v-card-text>
          <v-text-field v-if="mode === 'register'" v-model="name" label="Full Name" variant="underlined"
            :rules="nameRules" />

          <v-text-field v-model="email" label="Email" variant="underlined" :rules="emailRules" />

          <v-text-field v-model="password_hash" :type="showPassword ? 'text' : 'password'" label="Password"
            variant="underlined" :rules="passwordRules">
            <template #append-inner>
              <v-btn v-if="password_hash" icon variant="text" @click="showPassword = !showPassword" class="mt-n5">
                <PhEye v-if="!showPassword" size="20" />
                <PhEyeSlash v-else size="20" />
              </v-btn>
            </template>
          </v-text-field>
        </v-card-text>

        <v-card-actions class="d-flex flex-column align-center">

          <div class="d-flex justify-center mb-3">
            <v-btn variant="text" @click="dialog = false">
              Cancel
            </v-btn>

            <v-btn color="primary" class="ml-3" @click="handleSubmit">
              {{ mode === "login" ? "Login" : "Create Account" }}
            </v-btn>
          </div>


          <v-btn variant="text" class="text-caption" @click="mode = mode === 'login' ? 'register' : 'login'">
            {{
              mode === "login"
                ? "Don't have an account? Register"
                : "Already have an account? Login"
            }}
          </v-btn>


          <div class="text-caption text-medium-emphasis my-2">
            or continue with
          </div>

          <div class="d-flex justify-center">
            <v-btn icon variant="outlined" class="mx-2">
              <PhGoogleLogo size="24" />
            </v-btn>

            <v-btn icon variant="outlined" class="mx-2">
              <PhGithubLogo size="24" />
            </v-btn>

            <v-btn icon variant="outlined" class="mx-2">
              <PhFacebookLogo size="24" />
            </v-btn>
          </div>

        </v-card-actions>
      </v-form>
    </v-card>
  </v-dialog>
</template>
