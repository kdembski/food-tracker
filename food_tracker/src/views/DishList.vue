<template>
  <!--filters bar-->
  <div class="container-fluid my-2 my-lg-4 px-lg-5">
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
        <!--portions-->
        <div class="row mt-3 mb-2">
          <h5 class="filters-header">Ilość porcji:</h5>
        </div>
        <div class="row">
          <label class="filter-dishes">
            <input type="checkbox" value="1" v-model="portionFilter" />
            <span class="filters-checkmark"></span>
            <p>1 os.</p>
          </label>
        </div>
        <div class="row">
          <label class="filter-dishes">
            <input type="checkbox" value="2" v-model="portionFilter" />
            <span class="filters-checkmark"></span>
            <p>2 os.</p>
          </label>
        </div>
        <div class="row">
          <label class="filter-dishes">
            <input type="checkbox" value="3" v-model="portionFilter" />
            <span class="filters-checkmark"></span>
            <p>3 os.</p>
          </label>
        </div>
        <div class="row">
          <label class="filter-dishes">
            <input type="checkbox" value="4" v-model="portionFilter" />
            <span class="filters-checkmark"></span>
            <p>4 os.</p>
          </label>
        </div>
        <div class="row">
          <label class="filter-dishes">
            <input type="checkbox" value="5" v-model="portionFilter" />
            <span class="filters-checkmark"></span>
            <p>4 os. &lt;</p>
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
    <!--buttons-->
    <div class="filters-button" style="top:45%" @click="showSearchBar">
      <div>
        <i class="fa fa-search"></i>
      </div>
      <span>szukaj</span>
    </div>
    <div
      class="filters-button"
      style="top:50%; margin-top:20px"
      @click="showFiltersBar"
    >
      <div>
        <i class="fa fa-filter"></i>
      </div>
      <span>filtruj</span>
    </div>
    <div class="filters-button" style="top:55%; margin-top:40px">
      <div>
        <i class="fa fa-plus"></i>
      </div>
      <span>dodaj</span>
    </div>

    <!--header-->
    <div class="row mb-2">
      <div class="col-sm-6 order-sm-1 align-self-end">
        <h2 class="header">PRZEPISY ({{ filteredSearchDishes.length }})</h2>
      </div>
    </div>
    <div>
      <transition-group name="list">
        <!--add new dish-->
        <div key="addDish" class="dish-div add-dish-div pt-3">
          <router-link to="/adddish" class="routerlink">
            <i class="fas fa-plus-circle dish-image" id="add-icon"></i>
            <div class="row justify-content-center">
              <p class="dish-name">Dodaj nowy przepis</p>
            </div>
          </router-link>
        </div>

        <!--list of dishes-->
        <div
          v-for="(dish, index) in filteredSearchDishes"
          :key="index"
          class="dish-div pt-3"
        >
          <router-link
            :to="{
              name: 'DishDetails',
              params: { id: dish.dish_id, name: dish.dish_name },
            }"
            class="routerlink"
          >
            <!--dish image-->
            <div class="row justify-content-center">
              <img
                v-if="
                  dish.image == '' ||
                    dish.image == 'http://localhost:8080/img/logo.2c3c8bdd.png'
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
              <p class="dish-name ellipsis">{{ dish.dish_name }}</p>
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
              <!--portions-->
              <div class="col-3 portions">
                <div
                  class="row d-flex justify-content-center align-items-center"
                >
                  <span class="fas fa-user-friends people-icon"></span>
                </div>
                <div
                  class="row d-flex justify-content-center align-items-center"
                >
                  <p>{{ dish.portions }} os.</p>
                </div>
              </div>
            </div>
            <!---->
          </router-link>
        </div>
      </transition-group>

      <!---->
    </div>
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
      portionFilter: [],
    };
  },
  mounted() {
    this.getAllDishes();
  },
  methods: {
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
      this.portionFilter = [];
    },
  },
  computed: {
    filteredSearchDishes: function() {
      let dishes = this.dishes;
      dishes = dishes.filter((dish) => {
        return dish.dish_name.toLowerCase().match(this.search.toLowerCase());
      });
      if (this.prepTimeFilter.length > 0 || this.portionFilter.length > 0) {
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
            var portionBool = true;
            if (this.portionFilter.length > 0) {
              portionBool = this.portionFilter.some((filter) => {
                if (filter == 1) {
                  return dish.portions == 1;
                }
                if (filter == 2) {
                  return dish.portions == 2;
                }
                if (filter == 3) {
                  return dish.portions == 3;
                }
                if (filter == 4) {
                  return dish.portions == 4;
                }
                if (filter == 5) {
                  return dish.portions > 4;
                }
              });
              console.log(dish.portions, portionBool);
            }

            var bool = (() => {
              if (prepTimeBool && portionBool) {
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
  },
};
</script>
