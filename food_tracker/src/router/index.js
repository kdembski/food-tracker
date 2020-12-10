import Vue from "vue";
import VueRouter from "vue-router";
import DishList from "../views/DishList.vue";
import DishDetails from "../views/DishDetails.vue";
import IngredientList from "../views/IngredientList.vue";
import AddDish from "../views/AddDish.vue";
import Calendar from "../views/Calendar.vue";


Vue.use(VueRouter);

const routes = [
  {
    path: "/dishlist",
    name: "DishList",
    component: DishList
  },
  {
    path: "/details/:name/:id",
    name: "DishDetails",
    component: DishDetails,
    params: true
  },
  {
    path: "/adddish",
    name: "AddDish",
    component: AddDish,
  },
  {
    path: "/ingredientlist",
    name: "IngredientList",
    component: IngredientList,
  },
  {
    path: "/calendar",
    name: "Calendar",
    component: Calendar,
  }

];

const router = new VueRouter({
  routes
});

export default router;
