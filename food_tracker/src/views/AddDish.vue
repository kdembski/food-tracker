<template>
  <div class="container-lg py-2 px-xl-4 py-lg-4 main-container">
    <div class="main-add-div px-0 px-lg-4">
      <div class="col">
        <!--error alert-->
        <div
          v-if="addingDishErrorAlert"
          class="alert custom-alert alert-danger"
          role="alert"
          @click="hideDishAlert"
        >
          Nie udało sie dodać przepisu!
        </div>
        <!--success alert-->
        <div
          v-if="addingDishSuccessAlert"
          class="alert custom-alert alert-success"
          role="alert"
          @click="hideDishAlert"
        >
          Udało sie dodać przepis!
        </div>
      </div>

      <div class="row">
        <!--new dish inputs-->
        <div class="col-md-6">
          <div class="row mb-3">
            <h2>Wpisz dane przepisu</h2>
          </div>
          <div class="row">
            <h6>Nazwa przepisu:</h6>
          </div>
          <div class="row">
            <input
              type="text"
              v-model="newDish.dish_name"
              class="form-control custom-input"
            />
          </div>
          <div
            v-show="newDish.dish_name == '' && addingDishError"
            class="alert custom-alert-small alert-danger"
            role="alert"
          >
            Nazwa przepisu nie może być pusta
          </div>
          <!--prep time-->
          <div class="row mt-2">
            <h6>Czas przygotowania (min):</h6>
          </div>
          <div class="row">
            <input
              type="number"
              v-model="newDish.preparation_time"
              class="form-control custom-input"
            />
          </div>
          <div
            v-show="
              (newDish.preparation_time < 1 ||
                newDish.preparation_time > 999 ||
                newDish.preparation_time == '') &&
                addingDishError
            "
            class="alert custom-alert-small alert-danger"
            role="alert"
          >
            Czas przygotowania musi być z przedziału od 1 do 999
          </div>
          <!--portions-->
          <div class="row mt-2">
            <h6>Liczba porcji:</h6>
          </div>
          <div class="row">
            <input
              type="number"
              v-model="newDish.portions"
              class="form-control custom-input"
            />
          </div>
          <div
            v-show="
              (newDish.portions < 1 ||
                newDish.portions > 99 ||
                newDish.portions == '') &&
                addingDishError
            "
            class="alert custom-alert-small alert-danger"
            role="alert"
          >
            Liczba porcji musi być z przedziału od 1 do 99
          </div>
          <!--image-->
          <div class="row mt-2">
            <h6>Zdjęcie (link):</h6>
          </div>
          <div class="row mb-2">
            <input
              type="url"
              v-model="newDish.image"
              class="form-control custom-input"
            />
          </div>
          <!--rating-->
          <div class="row mt-2">
            <h6 style="margin-bottom:-10px">Ocena:</h6>
          </div>
          <div class="edit-stars">
            <div class="row mb-1">
              <input
                class="star-icon order-10"
                id="star-5"
                type="radio"
                name="star"
                value="5"
                v-model="starValue"
              />
              <label class="star-icon star-5 order-9" for="star-5"></label>

              <input
                class="star-icon order-8"
                id="star-4"
                type="radio"
                name="star"
                value="4"
                v-model="starValue"
              />
              <label class="star-icon star-4 order-7" for="star-4"></label>

              <input
                class="star-icon order-6"
                id="star-3"
                type="radio"
                name="star"
                value="3"
                v-model="starValue"
              />
              <label class="star-icon star-3 order-5" for="star-3"></label>

              <input
                class="star-icon order-4"
                id="star-2"
                type="radio"
                name="star"
                value="2"
                v-model="starValue"
              />
              <label class="star-icon star-2 order-3" for="star-2"></label>

              <input
                class="star-icon order-2"
                id="star-1"
                type="radio"
                name="star"
                value="1"
                v-model="starValue"
              />
              <label class="star-icon star-1 order-1" for="star-1"></label>
            </div>
          </div>
        </div>
        <!--ingredients-->
        <div class="col-md-6">
          <div class="row mb-3 mt-md-0 mt-4">
            <h2>Podaj składniki</h2>
          </div>
          <transition-group name="list">
            <div
              v-for="(newIngredient, index) in newDishIngredients"
              :key="index"
              class="dish-ingredients-list"
            >
              <div class="row mb-2 ml-1 d-flex align-items-center">
                <h6
                  v-if="newIngredient.ingredient_name != ''"
                  class="m-0"
                  style="font-weight: 600"
                >
                  {{ newIngredient.ingredient_name }}
                </h6>
                <p v-else class="font-italic m-0">
                  nie wybrano...
                </p>
                <div
                  class="button-transparent ml-3"
                  @click="showChooseIngredientModal(index)"
                >
                  <i class="fas fa-list"></i>
                </div>
              </div>
              <div class="row mb-1">
                <div class="col p-0 d-flex align-items-center">
                  <input
                    type="number"
                    class="form-control custom-input"
                    v-model="newIngredient.amount"
                    :placeholder="
                      'Podaj ilość składnika w jednostce:  ' +
                        newIngredient.unit_name
                    "
                  />
                </div>
              </div>
              <div class="row mb-3">
                <div
                  v-show="
                    (newIngredient.amount < 1 ||
                      newIngredient.amount > 9999 ||
                      newIngredient.amount == '') &&
                      addingDishError
                  "
                  class="alert custom-alert-small alert-danger m-0"
                  role="alert"
                >
                  Ilość składnika musi być z przedziału od 1 do 9999
                </div>
              </div>
            </div>
          </transition-group>

          <!--buttons-->
          <div class="row mb-3 pt-1">
            <div class="button mr-3" @click="addEmptyIngredient">
              <div class="button-icon">
                <i class="fas fa-plus"></i>
              </div>
              <span>dodaj</span>
            </div>
            <div class="button" @click="deleteLastIngredient">
              <div class="button-icon">
                <i class="fas fa-trash-alt"></i>
              </div>
              <span>usuń</span>
            </div>
          </div>
        </div>
      </div>

      <!--steps-->
      <div class="px-3">
        <div class="row mb-3 mt-4">
          <h2>Przepis krok po kroku</h2>
        </div>
        <transition-group name="list">
          <div
            v-for="(newStep, index) in newDishSteps"
            :key="index"
            class="dish-steps-list"
          >
            <div class="row mt-3">
              <h5 v-bind:stepNumber="(newStep.step_number = index + 1)">
                Krok {{ index + 1 }}
              </h5>
            </div>
            <div class="row">
              <textarea
                rows="1"
                cols="60"
                class="form-control custom-input"
                name="instructions"
                v-model="newStep.instructions"
                placeholder="Podaj instrukcje..."
              ></textarea>
            </div>
            <div class="row mb-3">
              <div
                v-show="newStep.instructions == '' && addingDishError"
                class="alert custom-alert-small alert-danger m-0"
                role="alert"
              >
                Musisz podać instrukcje
              </div>
            </div>
          </div>
        </transition-group>
      </div>
      <!--buttons-->
      <div class="row pt-1 pb-3 px-3">
        <div class="button mr-3" @click="addEmptyStep">
          <div class="button-icon">
            <i class="fas fa-plus"></i>
          </div>
          <span>dodaj</span>
        </div>
        <div class="button" @click="deleteLastStep">
          <div class="button-icon">
            <i class="fas fa-trash-alt"></i>
          </div>
          <span>usuń</span>
        </div>
      </div>
    </div>
    <!-- buttons-->
    <div class="row px-3">
      <div class="button mt-4" @click="addAllDishElements">
        <div class="button-icon">
          <i class="fas fa-check"></i>
        </div>
        <span>akceptuj</span>
      </div>
    </div>

    <!--choose new ingredient modal-->
    <div v-if="chooseIngredientModal" class="overlay">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">
              Wybierz nowy składnik
            </h5>
            <div class="button-small" @click="hideChooseIngredientModal">
              <i class="fas fa-times"></i>
            </div>
          </div>
          <div class="modal-body">
            <div
              v-show="ingredientNotSelected"
              class="alert custom-alert alert-danger"
              role="alert"
              @click="hideIngredientAlert"
            >
              Nie wybrano żadnego składnika!
            </div>
            <div class="row border-bottom">
              <div class="col-8"><h6>Składnik:</h6></div>
              <div class="col-4"><h6>Jednostka:</h6></div>
            </div>
            <div
              class="row"
              v-for="(ingredient, index) in ingredients"
              :key="index"
            >
              <label class="choose-ingredient">
                <input
                  type="radio"
                  name="ingredient"
                  :value="ingredient.ingredient_id"
                  v-model="chosenIngredientId"
                  class="choose-ingredient-input"
                />
                <div class="py-2">
                  <div class="row">
                    <div class="col-8 ml-1">
                      {{ ingredient.ingredient_name }}
                    </div>
                    <div class="col-3 ml-1">{{ ingredient.unit_name }}</div>
                  </div>
                </div>
              </label>
            </div>
          </div>
          <div class="modal-footer">
            <div class="button" @click="confirmChoosingIngredient">
              <div class="button-icon">
                <i class="fas fa-check"></i>
              </div>
              <span>akceptuj</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "AddDish",
  data() {
    return {
      newDish: {
        dish_name: "",
        image: "",
        preparation_time: "",
        rating: "",
        portions: "",
      },
      newDishSteps: [
        {
          step_id: "",
          step_number: "",
          instructions: "",
        },
      ],
      newDishIngredients: [
        {
          ingredient_name: "",
          ingredient_id: "",
          amount: "",
          unit_name: "",
          dish_id: "",
        },
      ],
      ingredients: {
        ingredient_id: "",
        ingredient_name: "",
        kcal_per_unit: "",
        unit_name: "",
      },
      starValue: "1",
      addedId: "",

      chooseIngredientModal: false,
      editedIngredientIndex: "",
      chosenIngredientId: "",
      ingredientNotSelected: false,
      addingDishError: false,
      addingDishErrorAlert: false,
      addingDishSuccessAlert: false,
    };
  },
  mounted() {
    this.getIngredients();
  },
  methods: {
    //add new dish
    async addNewDish() {
      this.newDish.rating = this.starValue;
      var formData = this.toFormData(this.newDish);
      try {
        let response = await axios.post(
          "http://localhost/food_tracker/process.php?action=add_dish",
          formData
        );
        return response.data.added_id;
      } catch (err) {
        console.log(err);
      }
    },
    //add ingredient
    async addIngredient(formData) {
      try {
        let response = await axios.post(
          "http://localhost/food_tracker/process.php?action=add_ingredient",
          formData
        );
        return response.data.message;
      } catch (err) {
        console.log(err);
      }
    },
    // get all ingredinets
    getIngredients() {
      axios
        .get("http://localhost/food_tracker/process.php?action=get_ingredients")
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          } else {
            this.ingredients = response.data.ingredients;
          }
        });
    },

    async addStep(formData) {
      try {
        let response = await axios.post(
          "http://localhost/food_tracker/process.php?action=add_step",
          formData
        );
        return response.data.message;
      } catch (err) {
        console.log(err);
      }
    },

    toFormData(obj) {
      var fd = new FormData();
      for (var i in obj) {
        fd.append(i, obj[i]);
      }
      return fd;
    },

    hideIngredientAlert() {
      this.ingredientNotSelected = false;
    },
    hideDishAlert() {
      this.addingDishErrorAlert = false;
      this.addingDishSuccessAlert = false;
    },

    async addAllDishElements() {
      if (
        this.newDish.dish_name == "" ||
        this.newDish.preparation_time < 1 ||
        this.newDish.preparation_time > 999 ||
        this.newDish.preparation_time == "" ||
        this.newDish.portions < 1 ||
        this.newDish.portions > 99 ||
        this.newDish.portions == ""
      ) {
        this.addingDishError = true;
        this.addingDishErrorAlert = true;
      } else {
        this.addingDishError = false;
        this.addingDishErrorAlert = false;
      }

      for (var k = 0; k < this.newDishIngredients.length; k++) {
        if (
          this.newDishIngredients[k].ingredient_name != "" ||
          this.newDishIngredients[k].amount < 1 ||
          this.newDishIngredients[k].amount > 9999 ||
          this.newDishIngredients[k].amount == ""
        ) {
          this.addingDishError = true;
          this.addingDishErrorAlert = true;
        } else {
          this.addingDishError = false;
          this.addingDishErrorAlert = false;
        }
      }
      for (var l = 0; l < this.newDishSteps.length; l++) {
        if (this.newDishSteps[l].instructions == "") {
          this.addingDishError = true;
          this.addingDishErrorAlert = true;
        } else {
          this.addingDishError = false;
          this.addingDishErrorAlert = false;
        }
      }

      if (!this.addingDishError) {
        let addedId = await this.addNewDish();
        var formData;
        for (var i = 0; i < this.newDishIngredients.length; i++) {
          this.newDishIngredients[i].dish_id = addedId;
          formData = this.toFormData(this.newDishIngredients[i]);
          this.addIngredient(formData);
        }
        for (var j = 0; j < this.newDishSteps.length; j++) {
          this.newDishSteps[j].dish_id = addedId;
          formData = this.toFormData(this.newDishSteps[j]);
          this.addStep(formData);
        }
        this.addingDishError = false;
        this.addingDishErrorAlert = false;
        this.newDishIngredients = [];
        this.newDishSteps = [];
        this.newDish = {
          dish_name: "",
          image: "",
          preparation_time: "",
          rating: "",
          portions: "",
        };
        this.addingDishSuccessAlert = true;
      }
    },

    addEmptyIngredient() {
      this.newDishIngredients.push({
        ingredient_name: "",
        ingredient_id: "",
        amount: "",
        unit_name: "",
        dish_id: "",
      });
      this.showChooseIngredientModal(this.newDishIngredients.length - 1);
    },
    deleteLastIngredient() {
      this.$delete(this.newDishIngredients, this.newDishIngredients.length - 1);
    },

    addEmptyStep() {
      this.newDishSteps.push({
        step_id: "",
        step_number: "",
        instructions: "",
      });
    },
    deleteLastStep() {
      this.$delete(this.newDishSteps, this.newDishSteps.length - 1);
    },

    showChooseIngredientModal(index) {
      this.chooseIngredientModal = true;
      this.editedIngredientIndex = index;
    },
    hideChooseIngredientModal() {
      this.chooseIngredientModal = false;
      this.chosenIngredientId = "";
      this.deleteLastIngredient();
    },
    confirmChoosingIngredient() {
      if (this.chosenIngredientId == "") {
        this.ingredientNotSelected = true;
      } else {
        var ingredient = this.ingredients.find(
          (ingredient) => ingredient.ingredient_id === this.chosenIngredientId
        );
        this.newDishIngredients[this.editedIngredientIndex].ingredient_id =
          ingredient.ingredient_id;
        this.newDishIngredients[this.editedIngredientIndex].ingredient_name =
          ingredient.ingredient_name;
        this.newDishIngredients[this.editedIngredientIndex].unit_name =
          ingredient.unit_name;
        this.chooseIngredientModal = false;
        this.ingredientNotSelected = false;
        this.chosenIngredientId = "";
      }
    },
  },
};
</script>
