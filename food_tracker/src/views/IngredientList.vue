<template>
  <div class="row container-fluid px-sm-5">
    <div class="col-4 my-4" id="ingredients-table">
      <table class="table">
        <thead>
          <tr>
            <th>Nazwa</th>
            <th>Jednostka</th>
            <th>Kcal na jednostkę</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(ingredient, index) in ingredients" :key="index">
            <td :v-bind="ingredient.ingredient_name">
              {{ ingredient.ingredient_name }}
            </td>
            <td :v-bind="ingredient.unit_name">{{ ingredient.unit_name }}</td>
            <td :v-bind="ingredient.kcal_per_unit">
              {{ ingredient.kcal_per_unit }}
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div class="col-4 my-4" id="units-table">
      <table class="table">
        <thead>
          <tr>
            <th>Nazwa</th>
            <th>Skrót</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(unit, index) in units" :key="index">
            <td :v-bind="unit.unit_name">{{ unit.unit_name }}</td>
            <td :v-bind="unit.shortcut">{{ unit.shortcut }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>
<script>
import axios from "axios";
export default {
  name: "IngredientList",
  data() {
    return {
      ingredients: {
        ingredient_id: "",
        ingredient_name: "",
        kcal_per_unit: "",
        unit_name: "",
      },
      units: {
        unit_id: "",
        unit_name: "",
        shortcut: "",
      },
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
  },
};
</script>
