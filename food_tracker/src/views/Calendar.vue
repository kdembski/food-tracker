<template>
  <transition appear name="fadeIn">
    <div class="container-fluid row py-3 py-lg-4 px-0 px-lg-5">
      <div class="col-xl-9 p-0 pl-xl-3">
        <div class="row weeks-header mb-2">
          <div
            class="col-3 previous-week d-flex justify-content-end align-items-center"
          >
            <transition :name="weekSlideDirection">
              <div :key="previousWeek[0].day">
                {{ previousWeek[0].day }}.{{ previousWeek[0].month + 1 }} -
                {{ previousWeek[6].day }}.{{ previousWeek[6].month + 1 }}
              </div>
            </transition>
          </div>

          <div
            class="col-2 arrow-button d-flex justify-content-end align-items-center"
            @click="changeToPreviousWeek"
          >
            <i class="fas fa-chevron-left"></i>
          </div>

          <div
            class="col-2 current-week d-flex justify-content-center align-items-center"
          >
            <transition :name="weekSlideDirection">
              <div :key="currentWeek[0].day">
                {{ currentWeek[0].day }}.{{ currentWeek[0].month + 1 }} -
                {{ currentWeek[6].day }}.{{ currentWeek[6].month + 1 }}
              </div>
            </transition>
          </div>

          <div
            class="col-2 arrow-button d-flex justify-content-start align-items-center"
            @click="changeToNextWeek"
          >
            <i class="fas fa-chevron-right"></i>
          </div>

          <div
            class="col-3 next-week d-flex justify-content-start align-items-center"
          >
            <transition :name="weekSlideDirection">
              <div :key="nextWeek[0].day">
                {{ nextWeek[0].day }}.{{ nextWeek[0].month + 1 }} -
                {{ nextWeek[6].day }}.{{ nextWeek[6].month + 1 }}
              </div>
            </transition>
          </div>
        </div>
        <div id="calendar-table" class="">
          <div class="row calendar-header">
            <div class="col calendar-header-day">Pon</div>
            <div class="col calendar-header-day">Wto</div>
            <div class="col calendar-header-day">Śro</div>
            <div class="col calendar-header-day">Czw</div>
            <div class="col calendar-header-day">Pią</div>
            <div class="col calendar-header-day">Sob</div>
            <div class="col calendar-header-day">Nie</div>
          </div>
          <transition name="fade" mode="out-in">
            <div
              v-if="loadingCalendarFinished"
              class="row calendar-div"
              key="mainDiv"
            >
              <div
                class="col"
                v-for="(day, dayIndex) in weekDays"
                :key="dayIndex"
              >
                <draggable
                  :list="day.dishes"
                  @start="dragStartCalendar($event, dayIndex)"
                  @end="dragEndCalendar($event, dayIndex)"
                  drag-class="calendar-dragging-ticket"
                  ghost-class="calendar-ghost"
                  :group="day"
                  draggable=".active"
                >
                  <div
                    class="row cell"
                    v-for="(dish, index) in day.dishes"
                    :key="index"
                    @drop.prevent="drop($event, day, index)"
                    @dragover.prevent="dragOver"
                    @dragleave="dragLeave"
                    :class="getDishActiveClass(dish)"
                  >
                    <transition name="calendarPlaceholder" mode="out-in">
                      <div
                        v-if="
                          dish.image == 'breakfast' ||
                            dish.image == 'dinner' ||
                            dish.image == 'supper'
                        "
                      >
                        <img
                          v-if="dish.image == 'breakfast'"
                          src="../assets/breakfast.png"
                          alt=""
                          class="dish-image-calendar alt-image-calendar alt-image-calendar-opacity"
                        />
                        <img
                          v-else-if="dish.image == 'dinner'"
                          src="../assets/dinner.png"
                          alt=""
                          class="dish-image-calendar alt-image-calendar alt-image-calendar-opacity"
                        />
                        <img
                          v-else-if="dish.image == 'supper'"
                          src="../assets/supper.png"
                          alt=""
                          class="dish-image-calendar alt-image-calendar alt-image-calendar-opacity"
                        />
                      </div>
                    </transition>

                    <transition name="calendar">
                      <div
                        v-if="
                          !(
                            dish.image == 'breakfast' ||
                            dish.image == 'dinner' ||
                            dish.image == 'supper'
                          )
                        "
                        class="calendar-dish-div"
                        :key="dish.dish_id"
                      >
                        <router-link
                          :to="{
                            name: 'DishDetails',
                            params: { id: dish.dish_id, name: dish.dish_name },
                          }"
                          class="routerlink"
                        >
                          <div>
                            <img
                              v-if="
                                dish.image == '' ||
                                  dish.image ==
                                    'http://localhost:8080/img/logo.2c3c8bdd.png'
                              "
                              src="../assets/logo.png"
                              alt=""
                              class="dish-image-calendar alt-image-calendar"
                            />
                            <img
                              v-else
                              :src="dish.image"
                              class="dish-image-calendar"
                              @error="setAltImg(index)"
                              :id="index"
                            />
                          </div>
                          <div class="calendar-dish-name-div">
                            <p class="calendar-dish-name">
                              {{ dish.dish_name }}
                            </p>
                          </div>
                        </router-link>
                        <div
                          class="button-small button-xxs button-delete-calendar-day"
                          @click="
                            deleteDay(
                              day.day,
                              day.month,
                              day.year,
                              index,
                              dayIndex
                            ),
                              getShoppingList()
                          "
                        >
                          <i class="fas fa-times"></i>
                        </div>
                      </div>
                    </transition>
                  </div>
                </draggable>
              </div>
            </div>
            <div v-else class="row calendar-div-loading" key="loadingDiv">
              <div class="loader"></div>
            </div>
          </transition>
        </div>
        <div>
          <input
            type="text"
            class="form-control custom-input draggable-dish-search-input"
            placeholder="Wpisz nazwę przepisu"
            v-model="search"
          />
          <i class="fa fa-search draggable-dish-search-icon"></i>
        </div>
        <draggable
          :list="filteredDishes"
          @start="dragStart"
          @end="dragEnd"
          @change="onChange"
          drag-class="dragging-ticket"
          ghost-class="ghost"
          :animation="200"
          :sort="false"
          group="dishes"
        >
          <transition-group name="list" class="row dishes-container">
            <div
              v-for="(dish, index) in filteredDishes"
              :key="index"
              class="draggable-dish-border"
            >
              <router-link
                :to="{
                  name: 'DishDetails',
                  params: { id: dish.dish_id, name: dish.dish_name },
                }"
                class="routerlink"
              >
                <div class="draggable-dish-div">
                  <div class="draggable-image-div">
                    <img
                      v-if="
                        dish.image == '' ||
                          dish.image ==
                            'http://localhost:8080/img/logo.2c3c8bdd.png'
                      "
                      src="../assets/logo.png"
                      alt=""
                      class="dish-image-sm alt-image-sm"
                    />
                    <img
                      v-else
                      :src="dish.image"
                      class="dish-image-sm"
                      @error="setAltImg(index)"
                      :id="index"
                    />
                  </div>
                  <div class="draggable-dish-name-div">
                    <p class="draggable-dish-name">{{ dish.dish_name }}</p>
                  </div>
                </div>
              </router-link>
            </div>
          </transition-group>
        </draggable>
      </div>
      <div class="col-xl-3 p-0 px-2 pr-xl-3 pl-xl-5 mt-3 mt-xl-0">
        <h3 class="mb-3 mt-xl-2">Lista zakupów</h3>
        <transition name="fade" mode="out-in">
          <div v-if="loadingShoppingListFinished" key="mainDiv">
            <div
              v-for="(ingredient, index) in shoppingList"
              :key="index"
              class="row px-2 mb-3"
            >
              <div class="col-8 p-0">
                <span class="shopping-list-icon"></span>
                {{ ingredient.ingredient_name }}
              </div>
              <div class="col-4 p-0 d-flex justify-content-end">
                {{ ingredient.amount }} {{ ingredient.shortcut }}
              </div>
            </div>
          </div>
          <div v-else key="loadingDiv">
            <div class="row mt-5 d-flex justify-content-center">
              <div class="loader loader-small"></div>
            </div>
          </div>
        </transition>
      </div>
    </div>
  </transition>
</template>

<script>
import draggable from "vuedraggable";
import axios from "axios";

export default {
  components: {
    draggable,
  },
  data: function() {
    return {
      currentDate: "",
      dishes: [],
      weekDays: [
        {
          day: "",
          month: "",
          year: "",
          dishes: [
            { dish_id: "", dish_name: "", image: "breakfast" },
            { dish_id: "", dish_name: "", image: "dinner" },
            { dish_id: "", dish_name: "", image: "supper" },
          ],
        },
        {
          day: "",
          month: "",
          year: "",
          dishes: [
            { dish_id: "", dish_name: "", image: "breakfast" },
            { dish_id: "", dish_name: "", image: "dinner" },
            { dish_id: "", dish_name: "", image: "supper" },
          ],
        },
        {
          day: "",
          month: "",
          year: "",
          dishes: [
            { dish_id: "", dish_name: "", image: "breakfast" },
            { dish_id: "", dish_name: "", image: "dinner" },
            { dish_id: "", dish_name: "", image: "supper" },
          ],
        },
        {
          day: "",
          month: "",
          year: "",
          dishes: [
            { dish_id: "", dish_name: "", image: "breakfast" },
            { dish_id: "", dish_name: "", image: "dinner" },
            { dish_id: "", dish_name: "", image: "supper" },
          ],
        },
        {
          day: "",
          month: "",
          year: "",
          dishes: [
            { dish_id: "", dish_name: "", image: "breakfast" },
            { dish_id: "", dish_name: "", image: "dinner" },
            { dish_id: "", dish_name: "", image: "supper" },
          ],
        },
        {
          day: "",
          month: "",
          year: "",
          dishes: [
            { dish_id: "", dish_name: "", image: "breakfast" },
            { dish_id: "", dish_name: "", image: "dinner" },
            { dish_id: "", dish_name: "", image: "supper" },
          ],
        },
        {
          day: "",
          month: "",
          year: "",
          dishes: [
            { dish_id: "", dish_name: "", image: "breakfast" },
            { dish_id: "", dish_name: "", image: "dinner" },
            { dish_id: "", dish_name: "", image: "supper" },
          ],
        },
      ],
      draggedDish: { dish_id: "", dish_name: "", image: "" },
      replaceDayFormData: {
        day: "",
        month: "",
        year: "",
        index: "",
        dish_id: "",
      },
      getDayFormData: {
        day: "",
        month: "",
        year: "",
        index: "",
      },
      deleteDayFormData: {
        day: "",
        month: "",
        year: "",
        index: "",
      },
      getIngredientsFormData: {
        dish_id: "",
      },
      shoppingList: [],
      draggedDishDayIndex: "",
      draggedDishMealIndex: "",
      search: "",
      loadingCalendarFinished: false,
      loadingShoppingListFinished: false,
      changingDayData: false,
      weekSlideDirection: "weekSlideLeft",
    };
  },
  computed: {
    currentWeek: function() {
      var firstDay = new Date(this.currentDate);
      var dayNumber = firstDay.getDay();
      if (dayNumber == 0) {
        dayNumber = 7;
      }
      firstDay.setDate(firstDay.getDate());
      firstDay.setDate(firstDay.getDate() - dayNumber);
      var week = [];

      for (let i = 1; i <= 7; i++) {
        firstDay.setDate(firstDay.getDate() + 1);

        let day = firstDay.getDate();
        let month = firstDay.getMonth();
        let year = firstDay.getFullYear();
        week.push({ day, month, year });
      }
      return week;
    },

    previousWeek: function() {
      var firstDay = new Date(this.currentDate);
      var dayNumber = firstDay.getDay();
      if (dayNumber == 0) {
        dayNumber = 7;
      }
      firstDay.setDate(firstDay.getDate() - 7);
      firstDay.setDate(firstDay.getDate() - dayNumber);
      var week = [];

      for (let i = 1; i <= 7; i++) {
        firstDay.setDate(firstDay.getDate() + 1);

        let day = firstDay.getDate();
        let month = firstDay.getMonth();
        let year = firstDay.getFullYear();
        week.push({ day, month, year });
      }
      return week;
    },

    nextWeek: function() {
      var firstDay = new Date(this.currentDate);
      var dayNumber = firstDay.getDay();
      if (dayNumber == 0) {
        dayNumber = 7;
      }
      firstDay.setDate(firstDay.getDate() + 7);
      firstDay.setDate(firstDay.getDate() - dayNumber);
      var week = [];

      for (let i = 1; i <= 7; i++) {
        firstDay.setDate(firstDay.getDate() + 1);

        let day = firstDay.getDate();
        let month = firstDay.getMonth();
        let year = firstDay.getFullYear();
        week.push({ day, month, year });
      }
      return week;
    },

    filteredDishes: function() {
      return this.dishes.filter((dish) => {
        return dish.dish_name.toLowerCase().match(this.search.toLowerCase());
      });
    },
  },
  methods: {
    getCurrentDate() {
      this.currentDate = new Date();
    },

    changeToNextWeek() {
      this.weekSlideDirection = "weekSlideRight";
      this.loadingShoppingListFinished = false;
      this.currentDate.setDate(this.currentDate.getDate() + 7);
      this.currentDate = new Date(this.currentDate);
      this.setCurrentWeekToCalendar();
      this.getCurrentWeekFromDb();
    },

    changeToPreviousWeek() {
      this.weekSlideDirection = "weekSlideLeft";
      this.loadingShoppingListFinished = false;
      this.currentDate.setDate(this.currentDate.getDate() - 7);
      this.currentDate = new Date(this.currentDate);
      this.setCurrentWeekToCalendar();
      this.getCurrentWeekFromDb();
    },

    getAllDishes() {
      axios
        .get("http://localhost/food_tracker/process.php?action=get_all_dishes")
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          } else {
            this.dishes = response.data.dishes;
          }
        });
    },

    setAltImg(index) {
      this.dishes[index].image = "http://localhost:8080/img/logo.2c3c8bdd.png";
      var dish = document.getElementById(index);
      dish.classList.add("alt-image-sm");
    },

    drop(e, dropDay, index) {
      e.currentTarget.style.background = "";
      var day = this.weekDays.find((day) => day.day === dropDay.day);
      if (this.draggedDishDayIndex !== "" && this.draggedDishMealIndex !== "") {
        this.weekDays[this.draggedDishDayIndex].dishes[
          this.draggedDishMealIndex
        ] = day.dishes[index];
        if (day.dishes[index].dish_id == "") {
          this.deleteDay(
            this.weekDays[this.draggedDishDayIndex].day,
            this.weekDays[this.draggedDishDayIndex].month,
            this.weekDays[this.draggedDishDayIndex].year,
            this.draggedDishMealIndex,
            this.draggedDishDayIndex
          );
        } else {
          this.replaceDay(
            this.weekDays[this.draggedDishDayIndex].day,
            this.weekDays[this.draggedDishDayIndex].month,
            this.weekDays[this.draggedDishDayIndex].year,
            this.draggedDishMealIndex,
            this.weekDays[this.draggedDishDayIndex].dishes[
              this.draggedDishMealIndex
            ].dish_id
          );
        }
        this.draggedDishDayIndex = "";
        this.draggedDishMealIndex = "";
      }
      if (this.draggedDish.dish_id != 0) {
        day.dishes[index] = this.draggedDish;
        this.$forceUpdate();
        this.replaceDay(
          day.day,
          day.month,
          day.year,
          index,
          this.draggedDish.dish_id
        );
        this.draggedDish = { dish_id: "", dish_name: "", image: "" };
      }
      this.getShoppingList();
    },
    dragStart(e) {
      this.draggedDish.dish_id = this.filteredDishes[e.oldIndex].dish_id;
      this.draggedDish.dish_name = this.filteredDishes[e.oldIndex].dish_name;
      this.draggedDish.image = this.filteredDishes[e.oldIndex].image;
      this.$forceUpdate();
    },
    dragStartCalendar(e, dayIndex) {
      this.draggedDish.dish_id = this.weekDays[dayIndex].dishes[
        e.oldIndex
      ].dish_id;
      this.draggedDish.dish_name = this.weekDays[dayIndex].dishes[
        e.oldIndex
      ].dish_name;
      this.draggedDish.image = this.weekDays[dayIndex].dishes[e.oldIndex].image;
      if (this.draggedDish.dish_id !== "") {
        this.draggedDishDayIndex = dayIndex;
        this.draggedDishMealIndex = e.oldIndex;
      }
      this.$forceUpdate();
    },
    dragEnd() {
      this.draggedDish = { dish_id: "", dish_name: "", image: "" };
    },
    dragEndCalendar() {
      this.draggedDish = { dish_id: "", dish_name: "", image: "" };
      this.draggedDishDayIndex = "";
      this.draggedDishMealIndex = "";
    },
    dragOver(e) {
      e.currentTarget.style.background = "rgba(0, 0, 0, 0.1)";
    },
    dragLeave(e) {
      e.currentTarget.style.background = "";
    },
    onChange(e) {
      console.log(e);
      this.$forceUpdate();
    },
    getDishActiveClass(dish) {
      if (dish.dish_id !== "") {
        return "active";
      }
    },
    setCurrentWeekToCalendar() {
      for (var i = 0; i < 7; i++) {
        this.weekDays[i].day = this.currentWeek[i].day;
        this.weekDays[i].month = this.currentWeek[i].month;
        this.weekDays[i].year = this.currentWeek[i].year;
      }
    },

    replaceDay(day, month, year, index, dish_id) {
      this.replaceDayFormData.day = day;
      this.replaceDayFormData.month = month;
      this.replaceDayFormData.year = year;
      this.replaceDayFormData.index = index;
      this.replaceDayFormData.dish_id = dish_id;

      var formData = this.toFormData(this.replaceDayFormData);
      axios
        .post(
          "http://localhost/food_tracker/process.php?action=replace_day",
          formData
        )
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          }
        });
    },

    async getDay(formData) {
      try {
        let response = await axios.post(
          "http://localhost/food_tracker/process.php?action=get_day",
          formData
        );
        return response.data.day;
      } catch (err) {
        console.log(err);
      }
    },

    deleteDay(day, month, year, index, dayIndex) {
      this.deleteDayFormData.day = day;
      this.deleteDayFormData.month = month;
      this.deleteDayFormData.year = year;
      this.deleteDayFormData.index = index;
      if (index == 0) {
        this.weekDays[dayIndex].dishes[index] = {
          dish_id: "",
          dish_name: "",
          image: "breakfast",
        };
      } else if (index == 1) {
        this.weekDays[dayIndex].dishes[index] = {
          dish_id: "",
          dish_name: "",
          image: "dinner",
        };
      } else if (index == 2) {
        this.weekDays[dayIndex].dishes[index] = {
          dish_id: "",
          dish_name: "",
          image: "supper",
        };
      }
      this.$forceUpdate();
      var formData = this.toFormData(this.deleteDayFormData);
      axios
        .post(
          "http://localhost/food_tracker/process.php?action=delete_day",
          formData
        )
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          }
        });
    },

    async getDishIngredients(formData) {
      formData = this.toFormData(formData);
      try {
        let response = await axios.post(
          "http://localhost/food_tracker/process.php?action=get_dish_ingredients",
          formData
        );
        return response.data.dish_ingredients;
      } catch (err) {
        console.log(err);
      }
    },
    async getShoppingList() {
      this.loadingShoppingListFinished = false;
      this.shoppingList = [];

      for (var i = 0; i < 7; i++) {
        for (var j = 0; j < 3; j++) {
          this.getIngredientsFormData.dish_id = this.weekDays[i].dishes[
            j
          ].dish_id;
          var ingredients = await this.getDishIngredients(
            this.getIngredientsFormData
          );
          ingredients.forEach((ingredient) => {
            var duplicate = this.shoppingList.some((shoppingIngredient) => {
              return (
                shoppingIngredient.ingredient_id === ingredient.ingredient_id
              );
            });
            if (duplicate) {
              this.shoppingList.forEach((shoppingIngredient) => {
                if (
                  shoppingIngredient.ingredient_id === ingredient.ingredient_id
                ) {
                  var shoppingIngredientAmount = parseInt(
                    shoppingIngredient.amount,
                    10
                  );
                  var ingredientAmount = parseInt(ingredient.amount, 10);
                  shoppingIngredient.amount = (
                    shoppingIngredientAmount + ingredientAmount
                  ).toString();
                }
              });
            } else {
              this.shoppingList.push(ingredient);
            }
          });
        }
      }
      this.loadingShoppingListFinished = true;
    },

    async getCurrentWeekFromDb() {
      this.loadingShoppingListFinished = false;
      this.loadingCalendarFinished = false;
      for (var i = 0; i < 7; i++) {
        this.getDayFormData.day = this.currentWeek[i].day;
        this.getDayFormData.month = this.currentWeek[i].month;
        this.getDayFormData.year = this.currentWeek[i].year;
        for (var j = 0; j < 3; j++) {
          this.getDayFormData.index = j;
          var formData = this.toFormData(this.getDayFormData);
          var dish = await this.getDay(formData);

          if (dish.length != 0) {
            this.weekDays[i].dishes[j] = dish[0];
          } else {
            if (j == 0) {
              this.weekDays[i].dishes[j] = {
                dish_id: "",
                dish_name: "",
                image: "breakfast",
              };
            } else if (j == 1) {
              this.weekDays[i].dishes[j] = {
                dish_id: "",
                dish_name: "",
                image: "dinner",
              };
            } else if (j == 2) {
              this.weekDays[i].dishes[j] = {
                dish_id: "",
                dish_name: "",
                image: "supper",
              };
            }
          }
        }
      }
      this.$forceUpdate();
      this.getShoppingList();
      this.loadingCalendarFinished = true;
    },

    toFormData(obj) {
      var fd = new FormData();
      for (var i in obj) {
        fd.append(i, obj[i]);
      }
      return fd;
    },
  },
  created() {
    this.getCurrentDate();
    this.getAllDishes();
    this.setCurrentWeekToCalendar();
    this.getCurrentWeekFromDb();
  },
};
</script>
