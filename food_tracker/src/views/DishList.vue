<template>
  <div class="container-fluid px-sm-5">
    <!--header and search bar-->
    <div class="row mb-2">
      <div
        class="col-sm-6 order-sm-2 d-flex justify-content-end"
        id="search-div"
      >
        <button class="btn">
          <i class="fa fa-search fa-lg"></i>
        </button>
        <input
          class="form-control"
          type="text"
          placeholder="Wyszukaj przepis..."
          v-model="search"
          autocomplete="off"
        />
      </div>
      <div class="col-sm-6 order-sm-1 align-self-end" id="header-div">
        <h2 id="header">PRZEPISY ({{ filteredDishes.length }})</h2>
      </div>
    </div>
    <!--add new dish-->
    <div class="row">
      <div class="dish-div pt-3">
        <i class="fas fa-plus-circle dish-image" id="add-icon"></i>
        <div class="row justify-content-center">
          <p class="dish-name">Dodaj nowy przepis</p>
        </div>
      </div>
      <!--list of dishes-->
      <div
        v-for="dish in filteredDishes"
        :key="dish.dish_id"
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
              v-if="dish.image != ''"
              :src="dish.image"
              alt=""
              class="dish-image"
            />
            <img
              v-else
              src="../assets/logo.png"
              alt=""
              class="dish-image alt-image"
            />
          </div>
          <!--dish name-->
          <div class="row justify-content-center px-3">
            <p class="dish-name ellipsis">{{ dish.dish_name }}</p>
          </div>
          <!--dish prep time and rating-->
          <div class="row d-flex justify-content-center">
            <div v-for="index in 5" :key="index">
              <label
                class="star-icon checked"
                v-if="dish.rating >= index"
              ></label>
              <label v-else class="star-icon"></label>
            </div>
          </div>
           <!---->
          <div class="row d-flex justify-content-center align-items-center preptime">
            <span class="fas fa-clock clock-icon"></span>
            <p>{{ dish.preparation_time }} min.</p>
          </div>
          <!---->
        </router-link>
      </div>
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
      errorMsg: "",
      successMsg: "",
      dishes: [],
      search: "",
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
  },
  computed: {
    filteredDishes: function() {
      return this.dishes.filter((dish) => {
        return dish.dish_name.toLowerCase().match(this.search.toLowerCase());
      });
    },
  },
};
</script>

<style>
div.row {
  margin: 0;
  padding: 0;
}
#header {
  font-family: "Work Sans", sans-serif;
  font-weight: 800;
  margin: 0;
}
.dish-image {
  width: 100%;
  height: 200px;
  border: 1px solid #dddddd;
  object-fit: cover;
}
.alt-image {
  background-color: whitesmoke;
  padding: 5% 15%;
}
.clock-icon {
  color: #ffcc00;
  font-size: 35px;
}
.dish-div {
  width: calc(100% / 6);
  display: inline-block;
  height: 370px;
  padding: 0 16px;
  text-align: center;
  -webkit-transition: all 0.25s ease-out;
  -moz-transition: all 0.25s ease-out;
  -o-transition: all 0.25s ease-out;
  transition: all 0.25s ease-out;
}
.dish-div:hover {
  background-color: #fff9c6;
  transform: scale(1.05);
  box-shadow: 2px 2px 7px 2px rgba(66, 66, 66, 0.3);
}
.star-icon {
  font-size: 35px;
  margin: 0 5px;
  margin-top: -7px;
  color: #424242;
}
.star-icon:before {
  content: "\2605";
}
.checked {
  color: #ffcc00;
}
.preptime p {
  font-size: 18px;
  font-weight: 500;
  margin-left: 10px;
  margin-bottom: 0;
  padding: 0;
}
.preptime .col {
  padding: 0;
}
.dish-name {
  height: 60px;
  font-size: 20px;
  font-weight: 600;
  margin-bottom: 0;
}
#add-icon {
  border: 1px solid #dddddd;
  background-color: whitesmoke;
  font-size: 90px;
  color: #424242;
}
#add-icon::before{
  position:absolute;
  margin-top: 55px;
  margin-left: -45px;
}
.routerlink {
  color: black;
}
.routerlink:hover {
  color: black;
  text-decoration: none;
}
.ellipsis {
  text-overflow: ellipsis;
  overflow: hidden;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}
#search-div button {
  background-color: #ffcc00;
  padding: 10px 20px;
  border-radius: 0;
}
#search-div button:focus {
  box-shadow: 0px 0px 0px inset, 0px 0px 0px;
}
#search-div input {
  -webkit-transition: all 0.5s ease-in-out;
  -moz-transition: all 0.5s ease-in-out;
  -o-transition: all 0.5s ease-in-out;
  transition: all 0.5s ease-in-out;
  height: 56px;
  padding: 0;
  border: 0px;
  border-radius: 0;

  width: 0%;
  opacity: 0;
}
#search-div:hover input,
#search-div input:focus {
  width: 90%;
  opacity: 1;
  padding: 0 20px;
  box-shadow: 0px 0px 0px inset, 0px 0px 0px;
}

@media (max-width: 1800px) {
  .dish-div {
    width: calc(100% / 5);
  }
}
@media (max-width: 1520px) {
  .dish-div {
    width: calc(100% / 4);
  }
}
@media (max-width: 1240px) {
  .dish-div {
    width: calc(100% / 3);
  }
}
@media (max-width: 960px) {
  .dish-div {
    width: calc(100% / 2);
  }
}
@media (max-width: 680px) {
  .dish-div {
    height: 320px;
  }
  .dish-image {
    height: 150px;
  }
  #header {
    font-size: 25px;
  }
  #add-icon::before{
    margin-top: 30px;
  }
}
@media (max-width: 576px) {
  .dish-div {
    width: calc(100%);
  }
  .dish-div {
    height: 450px;
  }
  .dish-image {
    height: 270px;
  }
  #search-div button {
    margin-bottom: 10px;
  }
  #header {
    margin-bottom: 10px;
  }
  .star-icon{
    font-size: 40px;
  }
  .clock-icon{
    font-size: 40px;
  }
  #add-icon::before{
    margin-top: 90px;
  }
}
@media (max-width: 390px) {
  .dish-div {
    height: 360px;
  }
  .dish-image {
    height: 190px;
  }
  .star-icon{
    font-size: 35px;
  }
  .clock-icon{
    font-size: 35px;
  }
  #add-icon::before{
    margin-top: 50px;
  }
}
</style>
