<template>
  <div class="container-fluid row py-3 py-lg-4 main-container">
    <div class="col-xl-9 p-0 px-xl-3">
      <!--weeks header-->
      <div class="row">
        <div
          class="col-3 previous-week d-flex justify-content-end align-items-center"
        >
          Poprzedni
        </div>

        <div
          class="col-2 arrow-button d-flex justify-content-end align-items-center"
        ></div>

        <div
          class="col-2 current-week d-flex justify-content-center align-items-center"
        >
          <p class="m-0 text-center">Aktualny</p>
        </div>

        <div
          class="col-2 arrow-button d-flex justify-content-start align-items-center"
        ></div>

        <div
          class="col-3 next-week d-flex justify-content-start align-items-center"
        >
          Następny
        </div>
      </div>
      <div class="row mb-3">
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
      <!--calendar table-->
      <div id="calendar-table">
        <div class="row calendar-header">
          <div class="col">
            <div class="row calendar-header-day">Pon</div>
            <div class="row calendar-header-day-details">
              {{ currentWeek[0].day }}.{{ currentWeek[0].month + 1 }}
            </div>
          </div>
          <div class="col">
            <div class="row calendar-header-day">Wto</div>
            <div class="row calendar-header-day-details">
              {{ currentWeek[1].day }}.{{ currentWeek[1].month + 1 }}
            </div>
          </div>
          <div class="col">
            <div class="row calendar-header-day">Śro</div>
            <div class="row calendar-header-day-details">
              {{ currentWeek[2].day }}.{{ currentWeek[2].month + 1 }}
            </div>
          </div>
          <div class="col">
            <div class="row calendar-header-day">Czw</div>
            <div class="row calendar-header-day-details">
              {{ currentWeek[3].day }}.{{ currentWeek[3].month + 1 }}
            </div>
          </div>
          <div class="col">
            <div class="row calendar-header-day">Pią</div>
            <div class="row calendar-header-day-details">
              {{ currentWeek[4].day }}.{{ currentWeek[4].month + 1 }}
            </div>
          </div>
          <div class="col">
            <div class="row calendar-header-day">Sob</div>
            <div class="row calendar-header-day-details">
              {{ currentWeek[5].day }}.{{ currentWeek[5].month + 1 }}
            </div>
          </div>
          <div class="col">
            <div class="row calendar-header-day">Nie</div>
            <div class="row calendar-header-day-details">
              {{ currentWeek[6].day }}.{{ currentWeek[6].month + 1 }}
            </div>
          </div>
        </div>
        <transition name="fadeLong" mode="out-in">
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
                @start="dragStartCalendar($event, dayIndex, day)"
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
                  @dragover="dragOver"
                  @dragleave="dragLeave"
                  :class="getDishActiveClass(dish)"
                >
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

                    <div class="row calendar-dish-div-menu p-0">
                      <div class="calendar-portions-minus">
                        <div
                          class="button-small button-calendar"
                          @click="
                            decreasePortions(
                              day.day,
                              day.month,
                              day.year,
                              index,
                              dayIndex,
                              dish.portions
                            )
                          "
                        >
                          <i class="fas fa-minus"></i>
                        </div>
                      </div>

                      <div class="calendar-portions-icon">
                        <i class="fas fa-user-friends"></i>
                      </div>
                      <div class="calendar-portions-number">
                        <p class="m-0">
                          {{ dish.portions }}
                        </p>
                      </div>

                      <div class="calendar-portions-plus">
                        <div
                          class="button-small button-calendar"
                          @click="
                            increasePortions(
                              day.day,
                              day.month,
                              day.year,
                              index,
                              dayIndex,
                              dish.portions
                            )
                          "
                        >
                          <i class="fas fa-plus"></i>
                        </div>
                      </div>

                      <div class="calendar-details-button-div">
                        <router-link
                          :to="{
                            name: 'DishDetails',
                            params: { id: dish.dish_id, name: dish.dish_name },
                          }"
                          class="routerlink"
                        >
                          <div class="button-small button-calendar">
                            <i class="fas fa-ellipsis-h"></i>
                          </div>
                        </router-link>
                      </div>

                      <div class="calendar-delete-button-div">
                        <div
                          class="button-small button-calendar"
                          @click="
                            deleteDay(
                              day.day,
                              day.month,
                              day.year,
                              index,
                              dayIndex
                            ),
                              getAllDishesIngredients()
                          "
                        >
                          <i class="fas fa-times"></i>
                        </div>
                      </div>
                    </div>
                    <div class="row calendar-details-div">
                      <!-- rating -->
                      <div class="col-4 calendar-details-rating">
                        <label class="star-icon star-icon-calendar"></label>
                        <p>{{ dish.rating }}/5</p>
                      </div>
                      <!-- preptime-->
                      <div class="col-4 calendar-details-preptime">
                        <span class="fas fa-clock"></span>
                        <p>{{ dish.preparation_time }}</p>
                      </div>
                      <!--kcal-->
                      <div class="col-4 calendar-details-kcal">
                        <span class="fas fa-fire-alt"></span>
                        <p>{{ dish.kcalSum }}</p>
                      </div>
                    </div>
                  </div>
                </div>
              </draggable>
              <div class="daily-kcal-sum-div">
                <div class="row">
                  suma
                  <div class="daily-kcal-sum-icon">
                    <i class="fas fa-fire-alt"></i>
                  </div>
                </div>
                <div class="row">{{ day.dailyKcalSum }} kcal</div>
              </div>
            </div>
          </div>
          <div v-else class="row calendar-div-loading" key="loadingDiv">
            <div class="loader"></div>
          </div>
        </transition>
      </div>
    </div>
    <div class="col-xl-3 p-0 px-xl-3">
      <!--header-->
      <div class="row position-relative mb-4">
        <div class="col-6 shopping-list-header" @click="highlightDishList">
          Lista przepisów
        </div>
        <div class="col-6 backpack-header" @click="highlightShoppingList">
          Lista zakupów
        </div>
        <div id="shoppingListHighlight"></div>
      </div>
      <transition name="fadeLong" mode="out-in">
        <!--dishes list-->
        <div v-if="showDishList" key="dishList">
          <!--search dishes-->
          <div class="dish-list-search-div">
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
            handle=".draggable-dish-handle"
          >
            <transition-group class="row dishes-container">
              <div v-for="(dish, index) in filteredDishes" :key="index">
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
                    <div class="draggable-dish-handle">
                      <i class="fas fa-arrows-alt"></i>
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
        <!--shopping list-->
        <div v-else-if="showShoppingList" key="shoppingList">
          <transition name="fadeLong" mode="out-in">
            <div
              v-if="loadingShoppingListFinished"
              key="mainDiv"
              class="shopping-list-div"
            >
              <transition-group name="list">
                <div
                  v-for="(ingredient, index) in shoppingList"
                  :key="ingredient.ingredient_id"
                  class="row px-1 pr-3"
                >
                  <label class="shopping-list-label">
                    <input
                      type="checkbox"
                      class="shopping-list-input"
                      @click="shoppingListMoveToEnd(index)"
                      v-model="ingredient.checked"
                    />
                    <div
                      class="shopping-list-col col-8 p-0 d-flex justify-content-start align-items-center"
                    >
                      <div class="shopping-list-checkmark"></div>
                      <p class="shopping-list-item">
                        {{ ingredient.ingredient_name }}
                      </p>
                    </div>
                    <div
                      class="shopping-list-col col-4 p-0 d-flex justify-content-end align-items-center"
                    >
                      <p class="shopping-list-item">
                        {{ ingredient.amount }} {{ ingredient.shortcut }}
                      </p>
                    </div>
                  </label>
                </div>
              </transition-group>
            </div>
            <div v-else key="loadingDiv">
              <div class="row mt-5 d-flex justify-content-center">
                <div class="loader loader-small"></div>
              </div>
            </div>
          </transition>
        </div>
      </transition>
    </div>
  </div>
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
            { dish_id: "", dish_name: "", image: "breakfast", ingredients: [] },
            { dish_id: "", dish_name: "", image: "dinner", ingredients: [] },
            { dish_id: "", dish_name: "", image: "supper", ingredients: [] },
          ],
        },
        {
          day: "",
          month: "",
          year: "",
          dishes: [
            { dish_id: "", dish_name: "", image: "breakfast", ingredients: [] },
            { dish_id: "", dish_name: "", image: "dinner", ingredients: [] },
            { dish_id: "", dish_name: "", image: "supper", ingredients: [] },
          ],
        },
        {
          day: "",
          month: "",
          year: "",
          dishes: [
            { dish_id: "", dish_name: "", image: "breakfast", ingredients: [] },
            { dish_id: "", dish_name: "", image: "dinner", ingredients: [] },
            { dish_id: "", dish_name: "", image: "supper", ingredients: [] },
          ],
        },
        {
          day: "",
          month: "",
          year: "",
          dishes: [
            { dish_id: "", dish_name: "", image: "breakfast", ingredients: [] },
            { dish_id: "", dish_name: "", image: "dinner", ingredients: [] },
            { dish_id: "", dish_name: "", image: "supper", ingredients: [] },
          ],
        },
        {
          day: "",
          month: "",
          year: "",
          dishes: [
            { dish_id: "", dish_name: "", image: "breakfast", ingredients: [] },
            { dish_id: "", dish_name: "", image: "dinner", ingredients: [] },
            { dish_id: "", dish_name: "", image: "supper", ingredients: [] },
          ],
        },
        {
          day: "",
          month: "",
          year: "",
          dishes: [
            { dish_id: "", dish_name: "", image: "breakfast", ingredients: [] },
            { dish_id: "", dish_name: "", image: "dinner", ingredients: [] },
            { dish_id: "", dish_name: "", image: "supper", ingredients: [] },
          ],
        },
        {
          day: "",
          month: "",
          year: "",
          dishes: [
            { dish_id: "", dish_name: "", image: "breakfast", ingredients: [] },
            { dish_id: "", dish_name: "", image: "dinner", ingredients: [] },
            { dish_id: "", dish_name: "", image: "supper", ingredients: [] },
          ],
        },
      ],
      draggedDish: {
        dish_id: "",
        dish_name: "",
        image: "",
        portions: "",
        preparation_time: "",
        rating: "",
      },
      replaceDayFormData: {
        day: "",
        month: "",
        year: "",
        index: "",
        dish_id: "",
        portions: "",
        preparation_time: "",
        rating: "",
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
      dragStartItem: "",
      gettingAllIngredientsFinished: true,
      portionsFormData: {},
      showShoppingList: false,
      showDishList: true,
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
      e.currentTarget.style.transitionDuration = "0s";
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
            ].dish_id,
            this.weekDays[this.draggedDishDayIndex].dishes[
              this.draggedDishMealIndex
            ].portions,
            this.weekDays[this.draggedDishDayIndex].dishes[
              this.draggedDishMealIndex
            ].preparation_time,
            this.weekDays[this.draggedDishDayIndex].dishes[
              this.draggedDishMealIndex
            ].rating
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
          this.draggedDish.dish_id,
          this.draggedDish.portions,
          this.draggedDish.preparation_time,
          this.draggedDish.rating
        );
        this.draggedDish = { dish_id: "", dish_name: "", image: "" };
      }
    },
    dragStart(e) {
      this.draggedDish.dish_id = this.filteredDishes[e.oldIndex].dish_id;
      this.draggedDish.dish_name = this.filteredDishes[e.oldIndex].dish_name;
      this.draggedDish.image = this.filteredDishes[e.oldIndex].image;
      this.draggedDish.preparation_time = this.filteredDishes[
        e.oldIndex
      ].preparation_time;
      this.draggedDish.rating = this.filteredDishes[e.oldIndex].rating;
      this.draggedDish.portions = "1";
      this.$forceUpdate();
    },
    dragStartCalendar(e, dayIndex, day) {
      this.dragStartItem = e.item;
      this.draggedDish.dish_id = this.weekDays[dayIndex].dishes[
        e.oldIndex
      ].dish_id;
      this.draggedDish.dish_name = this.weekDays[dayIndex].dishes[
        e.oldIndex
      ].dish_name;
      this.draggedDish.image = this.weekDays[dayIndex].dishes[e.oldIndex].image;
      this.draggedDish.preparation_time = this.weekDays[dayIndex].dishes[
        e.oldIndex
      ].preparation_time;
      this.draggedDish.rating = this.weekDays[dayIndex].dishes[
        e.oldIndex
      ].rating;
      this.draggedDish.portions = this.weekDays[dayIndex].dishes[
        e.oldIndex
      ].portions;
      if (this.draggedDish.dish_id !== "") {
        this.draggedDishDayIndex = dayIndex;
        this.draggedDishMealIndex = e.oldIndex;
      }
      this.deleteDay(day.day, day.month, day.year, e.oldIndex, dayIndex);
      this.$forceUpdate();
    },
    dragEnd() {
      this.draggedDish = { dish_id: "", dish_name: "", image: "" };
      this.getAllDishesIngredients();
    },
    dragEndCalendar() {
      this.draggedDish = { dish_id: "", dish_name: "", image: "" };
      this.draggedDishDayIndex = "";
      this.draggedDishMealIndex = "";
      this.getAllDishesIngredients();
    },
    dragOver(e) {
      if (this.dragStartItem === "") {
        e.currentTarget.style.background = "rgba(0, 255, 0, 0.2)";
        e.currentTarget.style.transitionDuration = "0.1s";
        e.currentTarget.style.transitionProperty = "background-color";
      }
    },
    dragLeave(e) {
      e.srcElement.style.background = "";
      e.target.style.background = "";
      e.toElement.style.background = "";
      for (var i = 0; i < 5; i++) {
        e.path[i].style.background = "";
        e.path[i].style.transitionDuration = "0.4s";
      }
      this.dragStartItem = "";
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

    replaceDay(
      day,
      month,
      year,
      index,
      dish_id,
      portions,
      preparation_time,
      rating
    ) {
      this.replaceDayFormData.day = day;
      this.replaceDayFormData.month = month;
      this.replaceDayFormData.year = year;
      this.replaceDayFormData.index = index;
      this.replaceDayFormData.dish_id = dish_id;
      this.replaceDayFormData.portions = portions;
      this.replaceDayFormData.preparation_time = preparation_time;
      this.replaceDayFormData.rating = rating;

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
          ingredients: [],
          rating: "",
          preparation_time: "",
        };
      } else if (index == 1) {
        this.weekDays[dayIndex].dishes[index] = {
          dish_id: "",
          dish_name: "",
          image: "dinner",
          ingredients: [],
          rating: "",
          preparation_time: "",
        };
      } else if (index == 2) {
        this.weekDays[dayIndex].dishes[index] = {
          dish_id: "",
          dish_name: "",
          image: "supper",
          ingredients: [],
          rating: "",
          preparation_time: "",
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
    async getAllDishesIngredients() {
      if (this.gettingAllIngredientsFinished) {
        this.gettingAllIngredientsFinished = false;
        this.loadingShoppingListFinished = false;
        for (var i = 0; i < 7; i++) {
          var dailyKcalSum = 0;
          for (var j = 0; j < 3; j++) {
            this.getIngredientsFormData.dish_id = this.weekDays[i].dishes[
              j
            ].dish_id;
            var ingredients = await this.getDishIngredients(
              this.getIngredientsFormData
            );

            this.$set(this.weekDays[i].dishes[j], "ingredients", ingredients);

            var kcalSum = 0;
            if (ingredients.length > 0) {
              for (var k = 0; k < ingredients.length; k++) {
                kcalSum +=
                  parseFloat(ingredients[k].amount) *
                  parseFloat(ingredients[k].kcal_per_unit);
              }
              kcalSum = Math.floor(kcalSum);
            }
            this.$set(this.weekDays[i].dishes[j], "kcalSum", kcalSum);
            dailyKcalSum += kcalSum;
          }
          this.$set(this.weekDays[i], "dailyKcalSum", dailyKcalSum);
        }
        await this.getShoppingList();
        this.$forceUpdate();
        this.gettingAllIngredientsFinished = true;
      }
    },
    async getShoppingList() {
      this.shoppingList = [];
      for (var i = 0; i < 7; i++) {
        for (var j = 0; j < 3; j++) {
          this.weekDays[i].dishes[j].ingredients.forEach((ingredient) => {
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
                  var shoppingIngredientAmount = parseFloat(
                    shoppingIngredient.amount
                  );
                  var ingredientAmount =
                    parseFloat(ingredient.amount) *
                    parseInt(this.weekDays[i].dishes[j].portions);
                  shoppingIngredient.amount = (
                    shoppingIngredientAmount + ingredientAmount
                  ).toString();
                }
              });
            } else {
              ingredient.amount = (
                parseFloat(ingredient.amount) *
                parseInt(this.weekDays[i].dishes[j].portions)
              ).toString();
              this.$set(ingredient, "checked", false);
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
                ingredients: [],
                rating: "",
                preparation_time: "",
              };
            } else if (j == 1) {
              this.weekDays[i].dishes[j] = {
                dish_id: "",
                dish_name: "",
                image: "dinner",
                ingredients: [],
                rating: "",
                preparation_time: "",
              };
            } else if (j == 2) {
              this.weekDays[i].dishes[j] = {
                dish_id: "",
                dish_name: "",
                image: "supper",
                ingredients: [],
                rating: "",
                preparation_time: "",
              };
            }
          }
        }
      }
      await this.getAllDishesIngredients();
      this.$forceUpdate();
      this.loadingCalendarFinished = true;
    },

    async setPortions(formData) {
      try {
        let response = await axios.post(
          "http://localhost/food_tracker/process.php?action=set_portions",
          formData
        );
        return response.data.message;
      } catch (err) {
        console.log(err);
      }
    },

    increasePortions(day, month, year, index, dayIndex, portions) {
      if (portions < 9) {
        portions++;
        this.weekDays[dayIndex].dishes[index].portions++;
        var formData = this.toFormData(
          (this.portionsFormData = {
            day: day,
            month: month,
            year: year,
            index: index,
            portions: portions,
          })
        );
        this.setPortions(formData);
        this.getAllDishesIngredients();
        this.$forceUpdate();
      }
    },
    decreasePortions(day, month, year, index, dayIndex, portions) {
      if (portions > 1) {
        portions--;
        this.weekDays[dayIndex].dishes[index].portions--;
        var formData = this.toFormData(
          (this.portionsFormData = {
            day: day,
            month: month,
            year: year,
            index: index,
            portions: portions,
          })
        );
        this.setPortions(formData);
        this.getAllDishesIngredients();
        this.$forceUpdate();
      }
    },
    highlightShoppingList() {
      document.getElementById("shoppingListHighlight").style.left = "50%";
      this.showShoppingList = true;
      this.showDishList = false;
    },
    highlightDishList() {
      document.getElementById("shoppingListHighlight").style.left = "0%";
      this.showDishList = true;
      this.showShoppingList = false;
    },
    shoppingListMoveToEnd(index) {
      console.log(index);
      this.shoppingList[index].checked = true;
      setTimeout(() => {
        this.sortShoppingList();
      }, 50);
    },
    sortShoppingList() {
      this.shoppingList.sort(function(a, b) {
        return a.checked - b.checked;
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
  created() {
    this.getCurrentDate();
    this.getAllDishes();
    this.setCurrentWeekToCalendar();
    this.getCurrentWeekFromDb();
  },
};
</script>
