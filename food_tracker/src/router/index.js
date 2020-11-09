import Vue from "vue";
import VueRouter from "vue-router";
import DishList from "../views/DishList.vue";
import DishDetails from "../views/DishDetails.vue";

Vue.use(VueRouter);

const routes = [
  {
    path: "/dishlist",
    name: "DishList",
    component: DishList
  },
  {
    path: "/details/:id:name",
    name: "DishDetails",
    component: DishDetails,
    params: true
  }
];

const router = new VueRouter({
  routes
});

export default router;
