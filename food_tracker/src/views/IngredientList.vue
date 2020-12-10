<template>
  <transition appear name="fadeIn">
    <div class="row container-fluid my-2 my-lg-4 px-lg-5">
      <!--ingredients-->
      <div class="col-xl-7 pr-xl-4 p-0 mx-3 mx-xl-0" id="ingredients-table">
        <h2 class="ingredient-list-header">
          Składniki ({{ ingredients.length }})
        </h2>
        <table class="table">
          <thead>
            <tr>
              <th style="width:40%">Nazwa</th>
              <th style="width:25%">Jednostka</th>
              <th style="width:25%">Kcal na jednostkę</th>
              <th style="width:5%">Edytuj</th>
              <th style="width:5%">Usuń</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(ingredient, index) in ingredients" :key="index" :class="editedIngredientRowClass(index)">
              <td>
                <div v-if="editedIngredientIndex === index">
                  <input
                    type="text"
                    v-model="ingredient.ingredient_name"
                    class="form-control custom-input custom-input-small"
                    placeholder="Nazwa składnika"
                  />
                </div>
                <div v-else>{{ ingredient.ingredient_name }}</div>
              </td>
              <td>
                <div v-if="editedIngredientIndex === index">
                  <select
                    class="form-control custom-input custom-input-small custom-select"
                    v-model="ingredient.unit_id"
                  >
                    <option value="" selected hidden disabled>wybierz jednostkę...</option>
                    <option
                      v-for="(unit, index) in units"
                      :key="index"
                      :value="unit.unit_id"
                      >{{ unit.unit_name }}</option
                    >
                  </select>
                </div>
                <div v-else>{{ ingredient.unit_name }}</div>
              </td>
              <td>
                <div v-if="editedIngredientIndex === index">
                  <input
                    type="number"
                    v-model="ingredient.kcal_per_unit"
                    class="form-control custom-input custom-input-small"
                    placeholder="Ilość kalorii na jednostkę"
                  />
                </div>
                <div v-else>{{ ingredient.kcal_per_unit }}</div>
              </td>
              <td>
                <div v-if="editedIngredientIndex === index">
                  <div
                    class="button-small button-xxs mx-auto "
                    @click="acceptEditingIngredient"
                  >
                    <i class="fas fa-check"></i>
                  </div>
                </div>
                <div v-else>
                  <div
                    class="button-small button-xxs mx-auto"
                    @click="editIngredient(index)"
                  >
                    <i class="fas fa-pen"></i>
                  </div>
                </div>
              </td>
              <td>
                <div v-if="editedIngredientIndex === index">
                  <div
                    class="button-small button-xxs mx-auto"
                    @click="cancelEditingIngredient"
                  >
                    <i class="fas fa-times"></i>
                  </div>
                </div>
                <div v-else>
                  <div
                    class="button-small button-xxs mx-auto"
                    @click="
                      (deleteIngredientModal = !deleteIngredientModal),
                        (deletedIngredientIndex = index)
                    "
                  >
                    <i class="fas fa-trash-alt"></i>
                  </div>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
        <div class="row d-flex justify-content-end">
          <div
            class="button-small button-xxs button-add-ingredient"
            @click="addEmptyIngredient"
          >
            <i class="fas fa-plus"></i>
          </div>
        </div>
      </div>
      <!--units-->
      <div class="col-xl-5 pl-xl-4 p-0 mx-3 mx-xl-0" id="units-table">
        <h2 class="ingredient-list-header">Jednostki ({{ units.length }})</h2>
        <table class="table">
          <thead>
            <tr>
              <th style="width:40%">Nazwa</th>
              <th style="width:50%">Skrót</th>
              <th style="width:5%">Edytuj</th>
              <th style="width:5%">Usuń</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(unit, index) in units" :key="index" :class="editedUnitRowClass(index)">
              <td>
                <div v-if="editedUnitIndex === index">
                  <input
                    type="text"
                    v-model="unit.unit_name"
                    class="form-control custom-input custom-input-small"
                    placeholder="Nazwa jednostki"
                  />
                </div>
                <div v-else>{{ unit.unit_name }}</div>
              </td>
              <td>
                <div v-if="editedUnitIndex === index">
                  <input
                    type="text"
                    v-model="unit.shortcut"
                    class="form-control custom-input custom-input-small"
                    placeholder="Skrót jednostki"
                  />
                </div>
                <div v-else>{{ unit.shortcut }}</div>
              </td>
              <td>
                <div v-if="editedUnitIndex === index">
                  <div
                    class="button-small button-xxs mx-auto "
                    @click="acceptEditingUnit"
                  >
                    <i class="fas fa-check"></i>
                  </div>
                </div>
                <div v-else>
                  <div
                    class="button-small button-xxs mx-auto"
                    @click="editUnit(index)"
                  >
                    <i class="fas fa-pen"></i>
                  </div>
                </div>
              </td>
              <td>
                <div v-if="editedUnitIndex === index">
                  <div
                    class="button-small button-xxs mx-auto"
                    @click="cancelEditingUnit"
                  >
                    <i class="fas fa-times"></i>
                  </div>
                </div>
                <div v-else>
                  <div
                    class="button-small button-xxs mx-auto"
                    @click="
                      (deleteUnitModal = !deleteUnitModal),
                        (deletedUnitIndex = index)
                    "
                  >
                    <i class="fas fa-trash-alt"></i>
                  </div>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
        <div class="row d-flex justify-content-end">
          <div
            class="button-small button-xxs button-add-ingredient"
            @click="addEmptyUnit"
          >
            <i class="fas fa-plus"></i>
          </div>
        </div>
      </div>
      <!--delete ingredient modal-->
      <transition name="modal">
        <div v-if="deleteIngredientModal" class="overlay">
          <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title">
                  Usuń składnik
                </h5>
              </div>
              <div class="modal-body">
                Czy na pewno chcesz usunąć
                <b>
                  {{ ingredients[deletedIngredientIndex].ingredient_name }}</b
                >
                z listy składników ?
              </div>
              <div class="modal-footer">
                <div
                  class="button mr-3"
                  @click="deleteIngredient(deletedIngredientIndex)"
                >
                  <div class="button-icon">
                    <i class="fas fa-check"></i>
                  </div>
                  <span>akceptuj</span>
                </div>
                <div
                  class="button"
                  @click="deleteIngredientModal = !deleteIngredientModal"
                >
                  <div class="button-icon">
                    <i class="fas fa-times"></i>
                  </div>
                  <span>anuluj</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </transition>
      <!--delete unit modal-->
      <transition name="modal">
        <div v-if="deleteUnitModal" class="overlay">
          <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title">
                  Usuń jednostkę
                </h5>
              </div>
              <div class="modal-body">
                Czy na pewno chcesz usunąć
                <b> {{ units[deletedUnitIndex].unit_name }}</b>
                z listy jednostek ?
              </div>
              <div class="modal-footer">
                <div class="button mr-3" @click="deleteUnit(deletedUnitIndex)">
                  <div class="button-icon">
                    <i class="fas fa-check"></i>
                  </div>
                  <span>akceptuj</span>
                </div>
                <div class="button" @click="deleteUnitModal = !deleteUnitModal">
                  <div class="button-icon">
                    <i class="fas fa-times"></i>
                  </div>
                  <span>anuluj</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </transition>
    </div>
  </transition>
</template>
<script>
import axios from "axios";
export default {
  name: "IngredientList",
  data() {
    return {
      ingredients: [],
      units: [],
      editedIngredientIndex: "",
      editedUnitIndex: "",
      deleteIngredientModal: false,
      deleteUnitModal: false,
      deletedIngredientIndex: "",
      deletedUnitIndex: "",
    };
  },
  mounted() {
    this.getIngredients();
    this.getUnits();
  },
  methods: {
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

    getUnits() {
      axios
        .get("http://localhost/food_tracker/process.php?action=get_units")
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          } else {
            this.units = response.data.units;
          }
        });
    },

    updateIngredient(index) {
      var formData = this.toFormData(this.ingredients[index]);
      axios
        .post(
          "http://localhost/food_tracker/process.php?action=update_global_ingredient",
          formData
        )
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          } else {
            this.getIngredients();
            console.log(response.data);
          }
        });
    },

    addIngredient(index) {
      var formData = this.toFormData(this.ingredients[index]);
      axios
        .post(
          "http://localhost/food_tracker/process.php?action=add_global_ingredient",
          formData
        )
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          } else {
            this.getIngredients();
            console.log(response.data);
          }
        });
    },

    deleteIngredient(index) {
      var formData = this.toFormData(this.ingredients[index]);
      axios
        .post(
          "http://localhost/food_tracker/process.php?action=delete_global_ingredient",
          formData
        )
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          } else {
            this.getIngredients();
            console.log(response.data);
          }
        });
      this.deleteIngredientModal = !this.deleteIngredientModal;
    },

    updateUnit(index) {
      var formData = this.toFormData(this.units[index]);
      axios
        .post(
          "http://localhost/food_tracker/process.php?action=update_unit",
          formData
        )
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          } else {
            this.getUnits();
            console.log(response.data);
          }
        });
    },

    addUnit(index) {
      var formData = this.toFormData(this.units[index]);
      axios
        .post(
          "http://localhost/food_tracker/process.php?action=add_unit",
          formData
        )
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          } else {
            this.getUnits();
            console.log(response.data);
          }
        });
    },

    deleteUnit(index) {
      var formData = this.toFormData(this.units[index]);
      axios
        .post(
          "http://localhost/food_tracker/process.php?action=delete_unit",
          formData
        )
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          } else {
            this.getUnits();
            console.log(response.data);
          }
        });
      this.deleteUnitModal = !this.deleteUnitModal;
    },

    editIngredient(index) {
      this.editedIngredientIndex = index;
    },
    cancelEditingIngredient() {
      this.editedIngredientIndex = "";
      this.getIngredients();
    },
    acceptEditingIngredient() {
      if (this.ingredients[this.editedIngredientIndex].ingredient_id == "") {
        this.addIngredient(this.editedIngredientIndex);
        this.editedIngredientIndex = "";
      } else {
        this.updateIngredient(this.editedIngredientIndex);
        this.editedIngredientIndex = "";
      }
    },

    editUnit(index) {
      this.editedUnitIndex = index;
    },
    cancelEditingUnit() {
      this.editedUnitIndex = "";
      this.getUnits();
    },
    acceptEditingUnit() {
      if (this.units[this.editedUnitIndex].unit_id == "") {
        this.addUnit(this.editedUnitIndex);
        this.editedUnitIndex = "";
      } else {
        this.updateUnit(this.editedUnitIndex);
        this.editedUnitIndex = "";
      }
    },

    addEmptyIngredient() {
      this.ingredients.push({
        ingredient_name: "",
        ingredient_id: "",
        unit_name: "",
        kcal_per_unit: "",
        unit_id: "",
      });
      this.editedIngredientIndex = this.ingredients.length - 1;
    },
    addEmptyUnit() {
      this.units.push({
        unit_id: "",
        unit_name: "",
        shortcut: "",
      });
      this.editedUnitIndex = this.units.length - 1;
    },

    editedIngredientRowClass(index){
      if(this.editedIngredientIndex===index){
        return "edited-row";
      }
    },
    editedUnitRowClass(index){
      if(this.editedUnitIndex===index){
        return "edited-row";
      }
    },

    toFormData(obj) {
      var fd = new FormData();
      for (var i in obj) {
        fd.append(i, obj[i]);
      }
      return fd;
    },
  },
};
</script>
