<template>
  <div class="container-fluid my-2 my-lg-4 px-lg-5">
    <!--filters bar-->
    <div id="filters-bar">
      <div
        class="button-transparent"
        id="hide-filter-bar-button"
        @click="hideFiltersBar"
      >
        <i class="fas fa-times"></i>
      </div>
      <div class="m-3 mt-5">
        <!--prep time-->
        <div class="row mb-2">
          <h5 class="filters-header">Czas przygotowania:</h5>
        </div>
        <div class="row">
          <label class="filter-dishes">
            <input
              type="checkbox"
              value="1"
              v-model="prepTimeFilter"
              class="prep-time-input"
            />
            <span class="filters-checkmark"></span>
            <p>&lt; 10 min.</p>
          </label>
        </div>
        <div class="row">
          <label class="filter-dishes">
            <input
              type="checkbox"
              value="2"
              v-model="prepTimeFilter"
              class="prep-time-input"
            />
            <span class="filters-checkmark"></span>
            <p>10 min. - 30 min.</p>
          </label>
        </div>
        <div class="row">
          <label class="filter-dishes">
            <input
              type="checkbox"
              value="3"
              v-model="prepTimeFilter"
              class="prep-time-input"
            />
            <span class="filters-checkmark"></span>
            <p>30 min. - 60 min.</p>
          </label>
        </div>
        <div class="row">
          <label class="filter-dishes">
            <input
              type="checkbox"
              value="4"
              v-model="prepTimeFilter"
              class="prep-time-input"
            />
            <span class="filters-checkmark"></span>
            <p>60 min. &lt;</p>
          </label>
        </div>
        <!--kcals-->
        <div class="row mt-3 mb-2">
          <h5 class="filters-header">Ilość kalorii:</h5>
        </div>
        <div class="row">
          <label class="filter-dishes">
            <input type="checkbox" value="1" v-model="kcalFilter" />
            <span class="filters-checkmark"></span>
            <p>&lt; 100 kcal</p>
          </label>
        </div>
        <div class="row">
          <label class="filter-dishes">
            <input type="checkbox" value="2" v-model="kcalFilter" />
            <span class="filters-checkmark"></span>
            <p>100 - 300 kcal</p>
          </label>
        </div>
        <div class="row">
          <label class="filter-dishes">
            <input type="checkbox" value="3" v-model="kcalFilter" />
            <span class="filters-checkmark"></span>
            <p>300 - 500 kcal</p>
          </label>
        </div>
        <div class="row">
          <label class="filter-dishes">
            <input type="checkbox" value="4" v-model="kcalFilter" />
            <span class="filters-checkmark"></span>
            <p>500 - 700 kcal</p>
          </label>
        </div>
        <div class="row">
          <label class="filter-dishes">
            <input type="checkbox" value="5" v-model="kcalFilter" />
            <span class="filters-checkmark"></span>
            <p>700 kcal &lt;</p>
          </label>
        </div>
        <!--category-->
        <div class="row mt-3 mb-2">
          <h5 class="filters-header">Posiłek:</h5>
        </div>
        <div class="row">
          <label class="filter-dishes">
            <input type="checkbox" value="1" v-model="categoryFilter" />
            <span class="filters-checkmark"></span>
            <p>śniadanie</p>
          </label>
        </div>
        <div class="row">
          <label class="filter-dishes">
            <input type="checkbox" value="2" v-model="categoryFilter" />
            <span class="filters-checkmark"></span>
            <p>obiad</p>
          </label>
        </div>
        <div class="row">
          <label class="filter-dishes">
            <input type="checkbox" value="3" v-model="categoryFilter" />
            <span class="filters-checkmark"></span>
            <p>kolacja</p>
          </label>
        </div>
      </div>
      <div class="button reset-filters-button" @click="resetFiltersValue">
        <div class="button-icon">
          <i class="fas fa-redo"></i>
        </div>
        <span>resetuj</span>
      </div>
    </div>
    <!--search bar-->
    <div id="search-bar">
      <div
        class="button-transparent"
        id="hide-search-bar-button"
        @click="hideSearchBar"
      >
        <i class="fas fa-times"></i>
      </div>
      <input
        type="text"
        class="form-control custom-input search-input"
        placeholder="Wpisz nazwę przepisu"
        v-model="search"
      />
    </div>
    <!--filters buttons-->
    <div class="filters-button" @click="showSearchBar">
      <div>
        <i class="fa fa-search"></i>
      </div>
      <span>szukaj</span>
    </div>
    <div
      class="filters-button"
      style="margin-top: 65px"
      @click="showFiltersBar"
    >
      <div>
        <i class="fa fa-filter"></i>
      </div>
      <span>filtruj</span>
    </div>
    <div
      class="filters-button"
      style="margin-top: 130px"
      @click="redirectToAddNewDish"
    >
      <div>
        <i class="fa fa-plus"></i>
      </div>
      <span>dodaj</span>
    </div>
    <!--dish deleted-->
    <transition appear name="deletedDish">
      <div v-if="deletedDishPopup" class="deleted-dish-div">
        <p class="deleted-dish-header">Usunięto przepis:</p>
        <img :src="deletedDish.image" class="deleted-dish-image" />
        <div class="deleted-dish-name">
          <p class="m-0">{{ deletedDish.dish_name }}</p>
        </div>
      </div>
    </transition>

    <!--header-->
    <div class="row mb-lg-2">
      <div>
        <h2 class="header">PRZEPISY ({{ filteredSearchDishes.length }})</h2>
      </div>
      <div
        v-if="
          prepTimeFilterView.length > 0 ||
            kcalFilterView.length > 0 ||
            categoryFilterView.length > 0
        "
        class="filters-list"
      >
        <p>FILTRY:</p>
        <div
          v-for="(filter, index) in prepTimeFilterView"
          :key="index"
          class="d-flex justify-content-start"
        >
          <p>({{ filter }}),</p>
        </div>
        <div
          v-for="(filter, index) in kcalFilterView"
          :key="index"
          class="d-flex justify-content-start"
        >
          <p>({{ filter }}),</p>
        </div>
        <div
          v-for="(filter, index) in categoryFilterView"
          :key="index"
          class="d-flex justify-content-start"
        >
          <p>({{ filter }}),</p>
        </div>
      </div>
    </div>
    <transition name="fadeLong" mode="out-in">
      <div v-if="dishListLoadingFinished" key="mainDiv">
        <transition-group name="list">
          <!--list of dishes-->
          <div
            v-for="(dish, index) in filteredSearchDishes"
            :key="index"
            class="dish-div mb-3"
          >
            <router-link
              :to="{
                name: 'DishDetails',
                params: { id: dish.dish_id, name: dish.dish_name },
              }"
              class="routerlink"
            >
              <!--dish image-->
              <div class="row justify-content-center dish-image-div">
                <img
                  v-if="
                    dish.image == '' ||
                      dish.image ==
                        'http://localhost:8080/img/logo.2c3c8bdd.png'
                  "
                  src="../assets/logo.png"
                  alt=""
                  class="dish-image alt-image"
                />
                <img
                  v-else
                  :src="dish.image"
                  class="dish-image"
                  @error="setAltImg(index)"
                  :id="index"
                />
              </div>
              <!--dish name-->
              <div class="row justify-content-center px-3">
                <p class="dish-name">{{ dish.dish_name }}</p>
              </div>
              <div class="row details mt-2">
                <!-- rating -->
                <div class="col-5 rating my-auto">
                  <div class="row d-flex justify-content-center">
                    <div v-for="index in 5" :key="index">
                      <label
                        class="star-icon checked"
                        v-if="dish.rating >= index"
                      ></label>
                      <label v-else class="star-icon"></label>
                    </div>
                  </div>
                </div>
                <!-- preptime-->
                <div class="col-4 preptime">
                  <div
                    class="row d-flex justify-content-center align-items-center"
                  >
                    <span class="fas fa-clock clock-icon"></span>
                  </div>
                  <div
                    class="row d-flex justify-content-center align-items-center"
                  >
                    <p>{{ dish.preparation_time }} min.</p>
                  </div>
                </div>
                <!--kcal-->
                <div class="col-3 kcal">
                  <div
                    class="row d-flex justify-content-center align-items-center"
                  >
                    <span class="fas fa-fire-alt people-icon"></span>
                  </div>
                  <div
                    class="row d-flex justify-content-center align-items-center"
                  >
                    <p>{{ dish.kcalSum }} kcal</p>
                  </div>
                </div>
              </div>
              <!---->
            </router-link>
          </div>
        </transition-group>
        <!---->
      </div>
      <div v-else class="row dish-list-div-loading" key="loadingDiv">
        <div class="loader"></div>
      </div>
    </transition>
  </div>
</template>

<script>
import axios from "axios";
import jQuery from "jquery";
global.$ = jQuery;

export default {
  name: "DishList",
  components: {},
  data() {
    return {
      dishes: [],
      search: "",
      imgError: false,
      searchBar: false,
      filtersBar: false,
      prepTimeFilter: [],
      kcalFilter: [],
      categoryFilter: [],
      deletedDish: "",
      deletedDishPopup: false,
      dishListLoadingFinished: false,
    };
  },
  async mounted() {
    await this.getAllDishes();
    this.showDeletedDishPopup();
  },
  methods: {
    async getAllDishes() {
      try {
        var response = await axios.get(
          "http://localhost/food_tracker/process.php?action=get_all_dishes"
        );
      } catch (err) {
        console.log(err);
      }
      this.dishes = response.data.dishes;
      for (var i = 0; i < this.dishes.length; i++) {
        var formData = { dish_id: this.dishes[i].dish_id };
        var ingredients = await this.getDishIngredients(formData);
        var kcalSum = 0;
        for (var j = 0; j < ingredients.length; j++) {
          kcalSum +=
            parseFloat(ingredients[j].amount) *
            parseFloat(ingredients[j].kcal_per_unit);
        }
        kcalSum = Math.floor(kcalSum);
        this.$set(this.dishes[i], "kcalSum", kcalSum);
      }
      this.dishListLoadingFinished = true;
    },

    setAltImg(index) {
      this.dishes[index].image = "http://localhost:8080/img/logo.2c3c8bdd.png";
      var dish = document.getElementById(index);
      dish.classList.add("alt-image");
    },
    showFiltersBar() {
      document.getElementById("filters-bar").style.left = "0";
      this.filtersBar = true;
      if (this.searchBar) {
        document.getElementById("search-bar").style.height = "0";
        this.searchBar = false;
      }
    },
    hideFiltersBar() {
      document.getElementById("filters-bar").style.left = "-235px";
      this.filtersBar = false;
    },
    showSearchBar() {
      if (this.searchBar) {
        document.getElementById("search-bar").style.height = "0";
        this.searchBar = false;
      } else {
        document.getElementById("search-bar").style.height = "80px";
        this.searchBar = true;
      }
    },
    hideSearchBar() {
      document.getElementById("search-bar").style.height = "0";
      this.searchBar = false;
    },
    resetFiltersValue() {
      this.prepTimeFilter = [];
      this.kcalFilter = [];
      this.categoryFilter = [];
    },
    redirectToAddNewDish() {
      this.$router.push("/adddish");
    },
    sleep(ms) {
      return new Promise((resolve) => setTimeout(resolve, ms));
    },
    async showDeletedDishPopup() {
      if (this.isDishDeleted) {
        this.deletedDish = this.$route.params;
        this.deletedDishPopup = true;
        await this.sleep(3000);
        this.deletedDishPopup = false;
      }
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
    toFormData(obj) {
      var fd = new FormData();
      for (var i in obj) {
        fd.append(i, obj[i]);
      }
      return fd;
    },
  },
  computed: {
    isDishDeleted: function() {
      if (Object.keys(this.$route.params).length !== 0) {
        return true;
      } else {
        return false;
      }
    },

    filteredSearchDishes: function() {
      let dishes = this.dishes;
      dishes = dishes.filter((dish) => {
        return dish.dish_name.toLowerCase().match(this.search.toLowerCase());
      });
      if (
        this.prepTimeFilter.length > 0 ||
        this.kcalFilter.length > 0 ||
        this.categoryFilter.length > 0
      ) {
        dishes = dishes.filter((dish) => {
          var bool = (() => {
            var prepTimeBool = true;
            if (this.prepTimeFilter.length > 0) {
              prepTimeBool = this.prepTimeFilter.some((filter) => {
                if (filter == 1) {
                  return dish.preparation_time <= 10;
                }
                if (filter == 2) {
                  return (
                    dish.preparation_time > 10 && dish.preparation_time <= 30
                  );
                }
                if (filter == 3) {
                  return (
                    dish.preparation_time > 30 && dish.preparation_time <= 60
                  );
                }
                if (filter == 4) {
                  return dish.preparation_time > 60;
                }
              });
            }
            var kcalBool = true;
            if (this.kcalFilter.length > 0) {
              kcalBool = this.kcalFilter.some((filter) => {
                if (filter == 1) {
                  return dish.kcalSum <= 100;
                }
                if (filter == 2) {
                  return dish.kcalSum > 100 && dish.kcalSum <= 300;
                }
                if (filter == 3) {
                  return dish.kcalSum > 300 && dish.kcalSum <= 500;
                }
                if (filter == 4) {
                  return dish.kcalSum > 500 && dish.kcalSum <= 700;
                }
                if (filter == 5) {
                  return dish.kcalSum > 700;
                }
              });
            }
            var categoryList = Array.from(dish.category);
            var categoryBool = true;

            if (this.categoryFilter.length > 0) {
              categoryBool = this.categoryFilter.some((filter) => {
                return categoryList.some((category) => {
                  return category == filter;
                });
              });
            }

            var bool = (() => {
              if (prepTimeBool && kcalBool && categoryBool) {
                return true;
              } else {
                return false;
              }
            })();

            return bool;
          })();
          return bool;
        });
      }
      return dishes;
    },
    prepTimeFilterView: function() {
      var tempArray = [];
      this.prepTimeFilter.forEach((filter) => {
        if (filter == 1) {
          tempArray.push("< 10 min.");
        } else if (filter == 2) {
          tempArray.push("10 min. - 30 min.");
        } else if (filter == 3) {
          tempArray.push("30 min. - 60 min.");
        } else if (filter == 4) {
          tempArray.push("60 min. <");
        }
      });
      return tempArray;
    },

    kcalFilterView: function() {
      var tempArray = [];
      this.kcalFilter.forEach((filter) => {
        if (filter == 1) {
          tempArray.push("< 100 kcal");
        } else if (filter == 2) {
          tempArray.push("100 - 300 kcal");
        } else if (filter == 3) {
          tempArray.push("300 - 500 kcal");
        } else if (filter == 4) {
          tempArray.push("500 - 700 kcal");
        } else if (filter == 5) {
          tempArray.push("700 kcal <");
        }
      });
      return tempArray;
    },
    categoryFilterView: function() {
      var tempArray = [];
      this.categoryFilter.forEach((filter) => {
        if (filter == 1) {
          tempArray.push("śniadanie");
        } else if (filter == 2) {
          tempArray.push("obiad");
        } else if (filter == 3) {
          tempArray.push("kolacja");
        }
      });
      return tempArray;
    },
  },
};
</script>
