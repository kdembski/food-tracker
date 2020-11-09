<template>
  <div class="container-fluid px-5">
    <!---->
    <div class="row">
      <div class="form-group has-search">
        <span class="fa fa-search form-control-feedback"></span>
        <input
          class="form-control"
          type="text"
          placeholder="Wyszukaj przepis..."
          v-model="search"
          id="search-input"
          autocomplete="off"
          hidden="true;"
        />
      </div>
    </div>
    <!---->
    <div class="row">
      <div class="dish-div pt-3">
        <img src="../assets/add.png" alt="" class="dish-image" id="add-icon" />
        <div class="row justify-content-center">
          <p class="dish-name">Dodaj nowy przepis</p>
        </div>
      </div>
      <!---->
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
          <!---->
          <div class="row justify-content-center">
            <img v-if="dish.image!=''" :src="dish.image" alt="" class="dish-image" />
            <img v-else src="../assets/logo.png" alt="" class="dish-image alt-image" />
          </div>
          <!---->
          <div class="row justify-content-center px-3">
            <p class="dish-name ellipsis">{{ dish.dish_name }}</p>
          </div>
          <!---->
          <div class="row">
            <div class="col-5">
              <div class="row justify-content-center">
                <img src="../assets/clock.png" class="clock-icon" />
              </div>
              <div class="row justify-content-center">
                <p>{{ dish.preparation_time }} min</p>
              </div>
            </div>
            <div class="col-7 d-flex justify-content-center mt-2">
              <div v-for="index in 5" :key="index">
                <img
                  src="../assets/star2.png"
                  class="star-icon"
                  v-if="dish.rating >= index"
                />
                <img v-else src="../assets/star.png" class="star-icon" />
              </div>
            </div>
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
        .get("http://localhost/food_tracker/process.php?action=read")
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
div.col {
  padding: 0;
  margin: 0;
}
.dish-image {
  width: 270px;
  height: 210px;
  border: 1px solid #8a8a8a;
}
.alt-image{
  background-color: whitesmoke;
  padding: 20px 40px;
}
.clock-icon {
  width: 40px;
  height: 40px;
  border-radius: 60px;
  background-color: #ffcc00;
}
.dish-div {
  width: calc(100% / 6);
  display: inline-block;
  height: 360px;
  text-align: center;
  transition: 0.3s ease-out;
}
.dish-div:hover {
  background-color: #fff494;
  transform: scale(1.05);
  box-shadow: 2px 2px 7px 2px rgba(66, 66, 66, 0.8);
}
.star-icon {
  height: 24px;
  width: 24px;
  float: left;
}
.dish-name {
  height: 60px;
  font-size: 18px;
  font-weight: 500;
  margin-bottom: 0;
}
#add-icon {
  border: 1px solid #8a8a8a;
  padding-left: 90px;
  padding-right: 90px;
  padding-top: 60px;
  padding-bottom: 60px;
  background-color: whitesmoke;
}
.has-search .form-control {
  padding-left: 2.375rem;
  border: 1px solid #8a8a8a;
  border-radius: 0px;
}
.has-search .form-control-feedback {
  position: absolute;
  z-index: 2;
  display: block;
  width: 2.375rem;
  height: 2.375rem;
  line-height: 2.375rem;
  text-align: center;
  pointer-events: none;
  color: #ffcc00;
}
input#search-input:focus {
  background-color: #fff494;
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
    height: 310px;
  }
  .dish-image {
    width: 220px;
    height: 160px;
  }
}
@media (max-width: 570px) {
  .dish-div {
    width: calc(100%);
  }
  .dish-div {
    height: 430px;
  }
  .dish-image {
    width: 340px;
    height: 280px;
  }
}
@media (max-width: 470px) {
  .dish-div {
    height: 350px;
  }
  .dish-image {
    width: 260px;
    height: 200px;
  }
}
@media (max-width: 380px) {
  .dish-div {
    height: 270px;
  }
  .dish-image {
    width: 180px;
    height: 120px;
  }
}
</style>
