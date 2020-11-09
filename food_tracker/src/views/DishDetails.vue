<template>
  <div class="container-fluid px-5">
    <div class="row" v-for="dish in dish" :key="dish.dish_id">
      <div class="col-3">
        <img v-bind:src="dish.image" alt="" class="dishImage" />
      </div>
      <div class="col-3">
        {{ dish.dish_name }}
      </div>
      <div class="col-3">
        {{ dish.rating }}
      </div>
      <div class="col-3"></div>
    </div>
    <div class="row">
      <div class="col-4">
        <div
          class="row"
          v-for="ingredient in dishIngredients"
          :key="ingredient.amount"
        >
          <div class="col-9 d-flex justify-content-start">
            {{ ingredient.ingredient_name }}
          </div>
          <div class="col-3 d-flex justify-content-start">
            {{ ingredient.amount }}
            {{ ingredient.shortcut }}
          </div>
        </div>
      </div>
      <div class="col-8">
        <div v-for="step in dishSteps" :key="step.step_number">
        <div class="row d-flex justify-content-start">
          {{step.step_number}}.{{step.instructions}}
        </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import axios from "axios";

export default {
  data() {
    return {
      dish: {},
      dishSteps: {},
      dishIngredients: {},
      params: { id: this.$route.params.id },
    };
  },
  mounted() {
    this.getCurrentDish();
  },
  methods: {
    getCurrentDish() {
      var formData = this.toFormData(this.params);
      axios
        .post(
          "http://localhost/food_tracker/process.php?action=details",
          formData
        )
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          } else {
            this.dish = response.data.dish;
            this.dishSteps = response.data.dish_steps;
            this.dishIngredients = response.data.dish_ingredients;
            console.log(this.dish);
          }
        });
    },
    toFormData(obj) {
      var fd = new FormData();
      for (var i in obj) {
        fd.append(i, obj[i]);
      }
      return fd;
    },
  },
  computed: {
    sortedSteps: function() {
      function compare(a, b) {
        if (a.step_number < b.step_number) return -1;
        if (a.step_number > b.step_number) return 1;
        return 0;
      }

      return this.dishSteps.slice().sort(compare);
    },
  },
};
</script>

<style>
.dishImage {
  height: 300px;
  width: 400px;
}
</style>
