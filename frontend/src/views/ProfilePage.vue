<template>
  <v-app>
    <v-container fluid class="pa-0">
      <v-row no-gutters>

        
        <v-col cols="12" md="4" class="pa-6 elevation-4">

          <v-card elevation="3" class="pa-6 text-center">

            <v-avatar size="160" class="mx-auto elevation-6">
              <v-img :src="profileImage" cover />
            </v-avatar>

            <v-btn block variant="outlined" class="mt-3" @click="openFileChooser">
              Change Photo
            </v-btn>

            <input type="file" ref="fileInput" accept="image/*" hidden @change="handleImageUpload" />

            <v-textarea
              v-model="bio"
              label="Bio"
              rows="3"
              class="mt-4"
              variant="outlined"
            >
              <template #prepend-inner>
                <PhNotePencil :size="18" />
              </template>
            </v-textarea>

            <v-btn block color="primary" size="small" class="mt-2" @click="generateBio">
              🤖 Generate Smart Bio
            </v-btn>

            <v-divider class="my-5" />

            <h3 class="text-subtitle-1 font-weight-bold mb-3">Social Links</h3>

            <v-text-field v-model="github" label="GitHub" density="compact" variant="outlined">
              <template #prepend-inner><PhGithubLogo :size="18" /></template>
            </v-text-field>

            <v-text-field v-model="linkedin" label="LinkedIn" density="compact" variant="outlined">
              <template #prepend-inner><PhLinkedinLogo :size="18" /></template>
            </v-text-field>

            <v-text-field v-model="twitter" label="Twitter" density="compact" variant="outlined">
              <template #prepend-inner><PhTwitterLogo :size="18" /></template>
            </v-text-field>

            <v-text-field v-model="instagram" label="Instagram" density="compact" variant="outlined">
              <template #prepend-inner><PhInstagramLogo :size="18" /></template>
            </v-text-field>

            <v-text-field v-model="leetcode" label="LeetCode" density="compact" variant="outlined"/>
            <v-text-field v-model="hackerrank" label="HackerRank" density="compact" variant="outlined"/>
            <v-text-field v-model="discord" label="Discord" density="compact" variant="outlined"/>
            <v-text-field v-model="slack" label="Slack" density="compact" variant="outlined"/>

            <!-- Top Skills Showcase -->
            <v-divider class="my-5" />
            <v-card v-if="topSkills.length > 0" elevation="2" class="pa-4">
              <h3 class="text-subtitle-1 font-weight-bold mb-3">
                <PhTrophy :size="20" class="mr-1" /> Top Skills
              </h3>
              <div v-for="(skill, index) in topSkills" :key="skill.name" class="mb-3">
                <div class="d-flex justify-space-between align-center mb-1">
                  <span class="text-body-2">
                    {{ index + 1 }}. {{ skill.name }} {{ skill.proficiencyData.icon }}
                  </span>
                  <v-chip size="x-small" :color="getEndorsementColor(skill.endorsements)">
                    {{ skill.endorsements }} 👍
                  </v-chip>
                </div>
                <v-progress-linear
                  :model-value="(skill.proficiency / 5) * 100"
                  :color="skill.proficiencyData.color"
                  height="6"
                  rounded
                />
              </div>
            </v-card>

          </v-card>
        </v-col>

        
        <v-col cols="12" md="8" class="pa-8">

          <div class="d-flex justify-space-between align-center">
            <h2 class="font-weight-bold">Profile Overview</h2>

            <v-switch v-model="isDark" inset @change="toggleTheme">
              <template #prepend>
                <PhSun :size="20" />
              </template>
              <template #append>
                <PhMoon :size="20" />
              </template>
            </v-switch>
          </div>

          <v-divider class="my-4" />

         
          <v-card elevation="2" class="pa-6 mb-6">
            <v-row>
              <v-col cols="12" md="6">
                <v-text-field label="First Name" v-model="firstname" readonly />
              </v-col>

              <v-col cols="12" md="6">
                <v-text-field label="Last Name" v-model="lastname" readonly />
              </v-col>

              <v-col cols="12" md="6">
                <v-text-field label="Date of Birth" v-model="dob" readonly />
              </v-col>

              <v-col cols="12" md="6">
                <v-text-field label="Email" v-model="email" />
              </v-col>

              <v-col cols="12" md="6">
                <v-text-field label="Phone No" v-model="phone_no" />
              </v-col>

              <v-col cols="12" md="6">
                <v-select label="Marriage Status" :items="['Single','Married']" v-model="marriageStatus" />
              </v-col>

              <v-col cols="12" md="6">
                <v-select label="Gender" :items="['Male','Female','Other']" v-model="gender" />
              </v-col>

              <v-col cols="12">
                <v-combobox v-model="skills" multiple chips label="Skills" />
              </v-col>
            </v-row>
          </v-card>

          
          <v-row>
            <v-col cols="12" md="6">
              <v-card elevation="2" class="pa-4">
                <h4 class="mb-3">Certificates</h4>
                <v-file-input
                  v-model="certificates"
                  label="Upload Certificates"
                  multiple
                  show-size
                  variant="outlined"
                />
              </v-card>
            </v-col>

            <v-col cols="12" md="6">
              <v-card elevation="2" class="pa-4">
                <h4 class="mb-3">Documents</h4>
                <v-file-input
                  v-model="documents"
                  label="Upload Documents"
                  multiple
                  show-size
                  variant="outlined"
                />
              </v-card>
            </v-col>
          </v-row>

         
          <v-card elevation="2" class="pa-6 mt-6">
            <div class="d-flex justify-space-between align-center mb-4">
              <h3>
                <PhRocketLaunch :size="32" color="green" class="mr-2" />
                Skill Endorsements & Proficiency
              </h3>
              <v-chip color="success" variant="elevated">
                <PhTrendUp :size="16" class="mr-1" />
                {{ totalEndorsements }} Total Endorsements
              </v-chip>
            </div>

            <v-alert v-if="skills.length === 0" type="info" variant="tonal" class="mb-4">
              Add skills above to start building your skill portfolio!
            </v-alert>

            <div v-for="skill in skills" :key="skill" class="mb-4">
              <v-card elevation="1" class="pa-4">
                <div class="d-flex justify-space-between align-center mb-3">
                  <div class="d-flex align-center">
                    <span class="text-h6 mr-2">{{ skill }}</span>
                    <span class="text-h5">{{ getProficiencyData(skill).icon }}</span>
                  </div>
                  
                  <div class="d-flex gap-2">
                    <v-btn
                      size="small"
                      color="primary"
                      variant="tonal"
                      @click="endorseSkill(skill)"
                    >
                      <PhStar :size="16" class="mr-1" />
                      Endorse
                      <v-badge
                        :content="endorsements[skill] || 0"
                        :color="getEndorsementColor(endorsements[skill] || 0)"
                        inline
                        class="ml-2"
                      />
                    </v-btn>
                    
                    <v-btn
                      size="small"
                      variant="outlined"
                      @click="openProficiencyDialog(skill)"
                    >
                      Set Level
                    </v-btn>
                  </div>
                </div>

                <div class="mb-2">
                  <div class="d-flex justify-space-between align-center mb-1">
                    <span class="text-caption text-medium-emphasis">
                      Proficiency: {{ getProficiencyData(skill).label }}
                    </span>
                    <span class="text-caption text-medium-emphasis">
                      {{ getProficiencyLevel(skill) }}/5
                    </span>
                  </div>
                  <v-progress-linear
                    :model-value="(getProficiencyLevel(skill) / 5) * 100"
                    :color="getProficiencyData(skill).color"
                    height="10"
                    rounded
                    striped
                  >
                    <template v-slot:default>
                      <strong class="text-caption">{{ Math.round((getProficiencyLevel(skill) / 5) * 100) }}%</strong>
                    </template>
                  </v-progress-linear>
                </div>

                <div class="d-flex justify-space-between align-center mt-2">
                  <v-chip
                    size="small"
                    :color="getProficiencyData(skill).color"
                    variant="flat"
                  >
                    {{ getProficiencyData(skill).label }}
                  </v-chip>
                  
                  <div class="text-caption text-medium-emphasis">
                    <PhUserCheck :size="14" class="mr-1" />
                    {{ endorsements[skill] || 0 }} people endorsed this
                  </div>
                </div>
              </v-card>
            </div>
          </v-card>
          <v-card-action>
           <div class="text-center text-caption mt-5 text-black ga-2">
             <v-btn elevation="8" variant="outlined" class="bg-white" v-tooltip:bottom="'Submit'" @click="btntohome"><PhCheck :size="32" color="black"/></v-btn>
             <v-btn elevation="8" variant="outlined" class="bg-white ml-3" v-tooltip:bottom="'Update'" @click="updateProfile"><PhArrowsClockwise :size="32" color="black"/></v-btn>
           </div>
          </v-card-action>
        </v-col>
      </v-row>
    </v-container>
  </v-app>

  
  <v-dialog v-model="dialog" width="400">
    <v-card class="pa-6">
      <v-card-title class="text-center">
        <PhUserCheck :size="60" />
      </v-card-title>

      <v-form ref="form">
        <v-card-text>
          <v-text-field v-model="firstname" label="First Name" :rules="firstNameRules" />
          <v-text-field v-model="lastname" label="Last Name" :rules="lastNameRules" />
          <v-text-field v-model="dob" type="date" label="Date of Birth" :rules="dobRules" />
        </v-card-text>

        <v-card-actions class="justify-center">
          <v-btn color="success" variant="outlined" @click="saveProfile">
            <PhCheck class="mr-1" :size="18" />
            Validate
          </v-btn>
        </v-card-actions>
      </v-form>
    </v-card>
  </v-dialog>

  
  <v-dialog v-model="proficiencyDialog" width="500">
    <v-card class="pa-6">
      <v-card-title class="text-center mb-4">
        <h3>Set Proficiency Level</h3>
        <div class="text-h6 text-primary mt-2">{{ selectedSkillForProficiency }}</div>
      </v-card-title>

      <v-card-text>
        <v-list>
          <v-list-item
            v-for="level in proficiencyLevels"
            :key="level.value"
            @click="saveProficiency(level.value)"
            class="mb-2"
            rounded="lg"
            :style="`border: 2px solid ${level.color}20; background: ${level.color}10`"
          >
            <template v-slot:prepend>
              <span class="text-h5 mr-3">{{ level.icon }}</span>
            </template>
            
            <v-list-item-title class="font-weight-bold">
              {{ level.label }}
            </v-list-item-title>
            
            <v-list-item-subtitle>
              Level {{ level.value }}/5
            </v-list-item-subtitle>

            <template v-slot:append>
              <v-progress-circular
                :model-value="(level.value / 5) * 100"
                :color="level.color"
                size="40"
                width="4"
              >
                <span class="text-caption">{{ level.value }}</span>
              </v-progress-circular>
            </template>
          </v-list-item>
        </v-list>
      </v-card-text>

      <v-card-actions class="justify-center">
        <v-btn variant="text" @click="proficiencyDialog = false">
          Cancel
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>

  <v-snackbar v-model="snackbar" :timeout="timeout" location="top">
    {{ text }}
  </v-snackbar>
</template>

<style scoped>
.gap-2 {
  gap: 8px;
}
</style>

<script setup>
import { ref, computed, onMounted } from "vue";
import { useTheme } from "vuetify";
import { useRouter } from "vuetify/lib/composables/router";
import api from "@/services/api"
import {
  PhCheck,
  PhUserCheck,
  PhGithubLogo,
  PhLinkedinLogo,
  PhTwitterLogo,
  PhInstagramLogo,
  PhNotePencil,
  PhSun,
  PhMoon,
  PhRocketLaunch,
  PhStar,
  PhTrophy,
  PhTrendUp,
  PhArrowsClockwise
} from "@phosphor-icons/vue";
import axios from "axios"
const users = ref([])
const loading = ref(false)
const error = ref(null)
const dialog = ref(true);
const form = ref(null);
const firstname = ref("");
const lastname = ref("");
const dob = ref("");
const email = ref("");
const marriageStatus = ref("");
const gender = ref("");
const bio = ref("");
const phone_no =ref("")

const github = ref("");
const linkedin = ref("");
const twitter = ref("");
const instagram = ref("");
const leetcode = ref("");
const hackerrank = ref("");
const discord = ref("");
const slack = ref("");
const profile_pic = ref("");
const skills = ref([]);
const certificates = ref([]);
const documents = ref([]);


const endorsements = ref({});
const skillProficiency = ref({});

const firstNameRules = [
  v => !!v || "First name is required",
  v => v.length >= 3 || "Minimum 3 characters",
  v => /^[A-Za-z]+$/.test(v) || "Only letters allowed"
];

const lastNameRules = [
  v => !!v || "Last name is required",
  v => /^[A-Za-z]+$/.test(v) || "Only letters allowed"
];

const dobRules = [
  v => !!v || "Date of Birth is required",
  v => {
    const today = new Date();
    const birthDate = new Date(v);
    const age = today.getFullYear() - birthDate.getFullYear();
    return age >= 18 || "You must be at least 18 years old";
  }
];

const snackbar = ref(false);
const text = ref("");
const timeout = ref(3000);

const saveProfile = async () => {
  const { valid } = await form.value.validate();
  if (valid) {
    text.value = "Validation Successfully ✅";
    snackbar.value = true;
    dialog.value = false;
  }
};


const profileImage = ref(
  "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"
);
const fileInput = ref(null);

const openFileChooser = () => fileInput.value.click();

const handleImageUpload = event => {
  const file = event.target.files[0];
  if (!file) return;
  const reader = new FileReader();
  reader.onload = () => (profileImage.value = reader.result);
  reader.readAsDataURL(file);
};


const theme = useTheme();
const isDark = ref(localStorage.getItem("theme") === "dark");

if (isDark.value) theme.global.name.value = "dark";

const toggleTheme = () => {
  isDark.value = !isDark.value;
  theme.global.name.value = isDark.value ? "dark" : "light";
  localStorage.setItem("theme", isDark.value ? "dark" : "light");
};

const generateBio = () => {
  bio.value = `Hi, I'm ${firstname.value} ${lastname.value}, passionate about technology and skilled in ${skills.value.join(", ")}.`;
};


const proficiencyLevels = [
  { value: 1, label: "Beginner", color: "#90CAF9", icon: "🌱" },
  { value: 2, label: "Intermediate", color: "#66BB6A", icon: "🌿" },
  { value: 3, label: "Advanced", color: "#FFA726", icon: "🔥" },
  { value: 4, label: "Expert", color: "#AB47BC", icon: "⚡" },
  { value: 5, label: "Master", color: "#EF5350", icon: "👑" }
];

const endorseSkill = skill => {
  endorsements.value[skill] = (endorsements.value[skill] || 0) + 1;
  
  
  text.value = `+1 Endorsement for ${skill}! 🎉`;
  snackbar.value = true;
};

const setProficiency = (skill, level) => {
  skillProficiency.value[skill] = level;
  
  const levelData = proficiencyLevels.find(l => l.value === level);
  text.value = `${skill} proficiency set to ${levelData.label} ${levelData.icon}`;
  snackbar.value = true;
};

const getProficiencyLevel = (skill) => {
  return skillProficiency.value[skill] || 1;
};

const getProficiencyData = (skill) => {
  const level = getProficiencyLevel(skill);
  return proficiencyLevels.find(l => l.value === level) || proficiencyLevels[0];
};

const getEndorsementColor = (count) => {
  if (count >= 20) return "red";
  if (count >= 10) return "orange";
  if (count >= 5) return "blue";
  return "grey";
};


const topSkills = computed(() => {
  return skills.value
    .map(skill => ({
      name: skill,
      endorsements: endorsements.value[skill] || 0,
      proficiency: getProficiencyLevel(skill),
      proficiencyData: getProficiencyData(skill)
    }))
    .sort((a, b) => {
      if (b.endorsements !== a.endorsements) {
        return b.endorsements - a.endorsements;
      }
      return b.proficiency - a.proficiency;
    })
    .slice(0, 5);
});

const totalEndorsements = computed(() => {
  return Object.values(endorsements.value).reduce((sum, count) => sum + count, 0);
});

onMounted(async () => {
  try {
    const response = await api.get("/details")

    const users = response.data.data || []

    if (users.length > 0) {
      const user = users[0]

      firstname.value      = user.name || ""
      email.value          = user.email || ""
      dob.value            = user.dob || ""
      marriageStatus.value = user.marriage_status || ""
      gender.value         = user.gender || ""
      bio.value            = user.bio || ""
      phone_no             = user.phone_no || ""
      github.value     = user.github || ""
      linkedin.value   = user.linkedin || ""
      twitter.value    = user.twitter || ""
      instagram.value  = user.instagram || ""
      leetcode.value   = user.leetcode || ""
      hackerrank.value = user.hackerrank || ""
      discord.value    = user.discord || ""
      slack.value      = user.slack || ""

      skills.value = user.skills || []

    }

  } catch (error) {
    console.error("Error loading profile:", error)
  }
})

const proficiencyDialog = ref(false);
const selectedSkillForProficiency = ref("");

const openProficiencyDialog = (skill) => {
  selectedSkillForProficiency.value = skill;
  proficiencyDialog.value = true;
};

const saveProficiency = (level) => {
  setProficiency(selectedSkillForProficiency.value, level);
  proficiencyDialog.value = false;
};
const router = useRouter();
const btntohome = async () => {
    router.push("/home");
}
const updateProfile = async () => {
  try {
    const payload = {
  email: email.value,
  dob: dob.value || null,
  marriage_status: marriageStatus.value || null,
  gender: gender.value || null,
  phone_no: phone_no.value || null,
  github: github.value || null,
  linkedin: linkedin.value || null,
  twitter: twitter.value || null,
  instagram: instagram.value || null,
  leetcode: leetcode.value || null,
  hackerrank: hackerrank.value || null,
  discord: discord.value || null,
  slack: slack.value || null,
  profile_pic: profile_pic.value || null,
  skills: skills.value || [],
  document: documents.value || [],
  cert: certificates.value || []
}

    console.log("Updating with:", payload)

    await api.put("/update", payload)

    text.value = "Profile Updated Successfully ✅"
    snackbar.value = true

  } catch (error) {
    console.error("Update failed:", error)
    text.value = "Update Failed ❌"
    snackbar.value = true
  }
}
</script>

