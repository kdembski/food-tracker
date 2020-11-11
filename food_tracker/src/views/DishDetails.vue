<template>
  <div class="container-lg mt-3 mt-lg-5">
    <!---->
    <div class="row" v-for="dish in dish" :key="dish.dish_id">
      <!--image-->
      <div class="col-lg-7 mb-3 mb-lg-5 order-2 d-flex justify-content-end">
        <img
          v-if="dish.image != ''"
          v-bind:src="dish.image"
          alt=""
          id="dish-image"
        />
        <img v-else src="../assets/logo.png" alt="" id="alt-image" />
      </div>

      <!--dish not edited-->
      <div v-if="!isDishEdited" class="col-lg-5 mb-3 mb-lg-5 order-1">
        <!--name-->
        <div class="row mb-3">
          <p id="dish-name">{{ dish.dish_name }}</p>
        </div>
        <!--prep time-->
        <div class="row mb-1" id="preptime">
          <span class="fas fa-clock clock-icon"></span>
          <div class="col align-self-center">
            <p>{{ dish.preparation_time }} min.</p>
          </div>
        </div>
        <!--rating-->
        <div class="row mb-3" id="stars">
          <div v-for="index in 5" :key="index">
            <label
              class="star-icon checked"
              v-if="dish.rating >= index"
            ></label>
            <label v-else class="star-icon"></label>
          </div>
        </div>
        <!--buttons-->
        <div class="row">
          <div class="button mr-3" @click="editDish">
            <i class="fas fa-pen"></i>
          </div>
          <div class="button">
            <i class="fas fa-trash-alt"></i>
          </div>
        </div>
      </div>

      <!--dish edited-->
      <div v-else class="col-lg-5 mb-3 mb-lg-5 order-1">
        <!--name-->
        <div class="row">
          <h6>Nazwa przepisu:</h6>
        </div>
        <div class="row edited">
          <input
            type="text"
            v-model="dish.dish_name"
            class="form-control custom-input"
          />
        </div>
        <!--prep time-->
        <div class="row mt-2">
          <h6>Czas przygotowania (min):</h6>
        </div>
        <div class="row mb-2 edited">
          <input
            type="text"
            v-model="dish.preparation_time"
            class="form-control custom-input"
          />
        </div>
        <!--image-->
        <div class="row mt-2">
          <h6>Zdjęcie (link):</h6>
        </div>
        <div class="row mb-2 edited">
          <input
            type="text"
            v-model="dish.image"
            class="form-control custom-input"
          />
        </div>
        <!--rating-->
        <div class="row mb-3" id="edit-stars">
          <input
            class="star-icon order-10"
            id="star-5"
            type="radio"
            name="star"
            value="5"
            v-model="starValue"
          />
          <label class="star-icon order-9" for="star-5"></label>

          <input
            class="star-icon order-8"
            id="star-4"
            type="radio"
            name="star"
            value="4"
            v-model="starValue"
          />
          <label class="star-icon order-7" for="star-4"></label>

          <input
            class="star-icon order-6"
            id="star-3"
            type="radio"
            name="star"
            value="3"
            v-model="starValue"
          />
          <label class="star-icon order-5" for="star-3"></label>

          <input
            class="star-icon order-4"
            id="star-2"
            type="radio"
            name="star"
            value="2"
            v-model="starValue"
          />
          <label class="star-icon order-3" for="star-2"></label>

          <input
            class="star-icon order-2"
            id="star-1"
            type="radio"
            name="star"
            value="1"
            v-model="starValue"
          />
          <label class="star-icon order-1" for="star-1"></label>
        </div>
        <!--buttons-->
        <div class="row">
          <div class="button mr-3" @click="editDishAccept">
            <i class="fas fa-check"></i>
          </div>
          <div class="button" @click="editDishCancel">
            <i class="fas fa-times"></i>
          </div>
        </div>
      </div>
    </div>
    <!--end of first row-->

    <div class="row">
      <!--ingredients not edited-->
      <div v-if="!isIngredientsEdited" class="col-lg-5">
        <h2 class="mb-3">Składniki:</h2>
        <div
          class="row mb-3 ingredient-div"
          v-for="ingredient in dishIngredients"
          :key="ingredient.amount"
        >
          <div class="col-9 d-flex justify-content-start">
            <p>{{ ingredient.ingredient_name }}</p>
          </div>
          <div class="col-3 d-flex justify-content-start">
            <p>{{ ingredient.amount }} {{ ingredient.shortcut }}</p>
          </div>
        </div>
        <!--button-->
        <div class="row">
          <div class="button mr-3" @click="editIngredients">
            <i class="fas fa-pen"></i>
          </div>
        </div>
      </div>

      <!--ingredients edited-->
      <div v-else class="col-lg-5">
        <h2 class="mb-3">Składniki:</h2>
        <div
          class="row mb-3 ingredient-div"
          v-for="ingredient in dishIngredients"
          :key="ingredient.amount"
        >
          <div class="col-9 d-flex justify-content-start">
            <p>{{ ingredient.ingredient_name }}</p>
          </div>
          <div class="col-3 d-flex justify-content-start">
            <p>{{ ingredient.amount }} {{ ingredient.shortcut }}</p>
          </div>
        </div>
        <!--buttons-->
        <div class="row">
          <div class="button mr-3" @click="editIngredientsAccept">
            <i class="fas fa-check"></i>
          </div>
          <div class="button" @click="editIngredientsCancel">
            <i class="fas fa-times"></i>
          </div>
        </div>
      </div>

      <!--steps not edited-->
      <div v-if="!isStepsEdited" class="col-lg-7 mb-4">
        <h2 class="mb-3">Przepis krok po kroku:</h2>
        <div v-for="step in dishSteps" :key="step.step_number">
          <div class="row d-flex justify-content-start">
            <h5>Krok {{ step.step_number }}</h5>
          </div>
          <div class="row d-flex justify-content-start">
            <p>{{ step.instructions }}</p>
          </div>
        </div>
        <!--button-->
        <div class="row">
          <div class="button mr-3" @click="editSteps">
            <i class="fas fa-pen"></i>
          </div>
        </div>
      </div>

      <!--steps edited-->
      <div v-else class="col-lg-7 mb-4">
        <h2 class="mb-3">Przepis krok po kroku:</h2>
        <div v-for="step in dishSteps" :key="step.step_number">
          <div class="row d-flex justify-content-start">
            <h5>Krok {{ step.step_number }}</h5>
          </div>
          <div class="row d-flex justify-content-start">
            <p>{{ step.instructions }}</p>
          </div>
          <!--buttons-->
          <div class="row">
            <div class="button-small mr-3 mb-3" @click="showStepEditModal">
              <i class="fas fa-pen"></i>
            </div>
            <div class="button-small" @click="deleteStep">
              <i class="fas fa-trash-alt"></i>
            </div>
          </div>
        </div>
        <!--buttons-->
        <div class="row">
          <div class="button mr-3" @click="editStepsAccept">
            <i class="fas fa-check"></i>
          </div>
          <div class="button" @click="editStepsCancel">
            <i class="fas fa-times"></i>
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
      dish: {
        dish_id: "",
        dish_name: "",
        image: "",
        preparation_time: "",
        rating: "",
      },
      dishSteps: {
        step_id: "",
        instructions: "",
        step_number: "",
      },
      dishIngredients: {
        amount: "",
        ingredient_name: "",
        kcal_per_unit: "",
        shortcut: "",
        unit_name: "",
      },
      params: { id: this.$route.params.id },
      isDishEdited: false,
      isIngredientsEdited: false,
      isStepsEdited: false,
      starValue: "",
    };
  },
  mounted() {
    this.getCurrentDish();
  },
  methods: {
    //get current dish from database
    getCurrentDish() {
      var formData = this.toFormData(this.params);
      axios
        .post(
          "http://localhost/food_tracker/process.php?action=dish_details",
          formData
        )
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          } else {
            this.dish = response.data.dish;
            this.dishSteps = response.data.dish_steps;
            this.dishIngredients = response.data.dish_ingredients;
          }
        });
    },

    //update current dish in database
    updateCurrentDish() {
      this.dish[0].rating = this.starValue;
      var formData = this.toFormData(this.dish[0]);
      axios
        .post(
          "http://localhost/food_tracker/process.php?action=update_dish",
          formData
        )
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          } else {
            this.getCurrentDish();
            console.log(response.data);
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

    //dish editing functions
    editDish() {
      this.isDishEdited = true;
      this.starValue = this.dish[0].rating;
    },
    editDishAccept() {
      this.isDishEdited = false;
      this.updateCurrentDish();
    },
    editDishCancel() {
      this.isDishEdited = false;
      this.getCurrentDish();
    },

    //ingredients editing functions
    editIngredients() {
      this.isIngredientsEdited = true;
    },
    editIngredientsAccept() {
      this.isIngredientsEdited = false;
    },
    editIngredientsCancel() {
      this.isIngredientsEdited = false;
    },

    //steps editing functions
    editSteps() {
      this.isStepsEdited = true;
    },
    editStepsAccept() {
      this.isStepsEdited = false;
    },
    editStepsCancel() {
      this.isStepsEdited = false;
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
#dish-image {
  height: 400px;
  width: 100%;
  border: 1px solid #dddddd;
  object-fit: cover;
}
#dish-name {
  font-size: 35px;
  font-weight: 600;
  margin: 0;
}
#stars label {
  font-size: 45px;
  margin: 0;
  margin-right: 10px;
}
#preptime span {
  font-size: 40px;
}
#preptime p {
  margin: 0;
  font-size: 26px;
  font-weight: 600;
}
.button {
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 35px;
  width: 50px;
  height: 50px;
  padding: 10px;
  background-color: #dddddd;
  cursor: pointer;
}
.button:hover {
  background-color: #fff9c6;
}
.button:active {
  transform: scale(0.8);
}
.button-small {
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 15px;
  width: 30px;
  height: 30px;
  padding: 10px;
  background-color: #dddddd;
  cursor: pointer;
}
.button-small:hover {
  background-color: #fff9c6;
}
.button-small:active {
  transform: scale(0.8);
}
#alt-image {
  height: 400px;
  width: 100%;
  border: 1px solid #dddddd;
  background-color: whitesmoke;
  padding: 5% 20%;
}
.ingredient-div p {
  font-weight: 400;
  font-size: 18px;
  margin: 0;
}
.ingredient-div {
  border-bottom: 1px solid #dddddd;
}
input.star-icon {
  display: none;
}

input.star-icon:checked ~ label.star-icon:before {
  content: "\2605";
  color: #ffcc00;
  transition: all 0.3s;
}
#edit-stars label {
  font-size: 45px;
  margin: 0;
  padding-right: 10px;
  transition: all 0.3s;
}
#edit-stars label.star-icon:hover {
  transform: scale(1.3);
  color: #ffcc00;
}
#edit-stars label.star-icon:hover ~ label.star-icon:before {
  transform: scale(1.3);
  color: #ffcc00;
}
.edited .custom-input {
  border: 1px solid #dddddd;
  border-radius: 0;
}
.edited .custom-input:focus {
  border: 1px solid #dddddd;
  border-radius: 0;
  box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075),
    0 0 6px rgba(255, 204, 0, 0.6);
}

@media (max-width: 992px) {
  #dish-image {
    height: auto;
  }
  #alt-image {
    height: auto;
  }
}
</style>
