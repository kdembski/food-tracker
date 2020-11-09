<template>
  <div>
    <nav class="navbar sticky-top navbar-expand-lg" id="nav-div">
      <img
        src="./assets/logo.png"
        id="navbrand"
        loading="lazy"
      />
      <button
        class="navbar-toggler navbar-dark"
        type="button"
        data-toggle="collapse"
        data-target="#nav-items-div"
        aria-controls="nav-items-div"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="nav-items-div">
        <ul class="navbar-nav">
          <li class="nav-item">
            <router-link to="/">GŁÓWNA</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/dishlist">PRZEPISY</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/calendar">KALENDARZ</router-link>
          </li>
        </ul>
      </div>
    </nav>
    <router-view />
  </div>
</template>
<style>
@import url("https://fonts.googleapis.com/css?family=Work+Sans:400,600");
#nav-div {
  background-color: #424242;
  font-family: "Work Sans", sans-serif;
  font-weight: 800;
}
#navbrand {
  width: 50px;
  height: 50px;
  border-radius: 60px;
  margin-right: 20px;
  background-color: #ffcc00;
  border: 0px solid black;
  box-shadow: 0px 0px 1px 1px black;
}
nav a {
  color: #ffcc00;
  position: relative;
}
nav li{
  margin: 0 20px;
}
nav a:hover {
  color: #fff494;
  text-decoration: none;
}
nav a::after {
  content: "";
  display: block;
  height: 7px;
  margin-top: 14px;
  background-color: #fff494;

  position: absolute;
  width: 0%;

  transition: all ease-in-out 250ms;
}
@media (max-width: 990px){
  nav a::after{
    height: 4px;
    margin-top: -5px;
  }
  #nav-items-div{
    margin-top: 20px;
  }
  nav li{
  margin: 0;
}
}
nav a:hover::after {
  width: 100%;
}
.router-link-exact-active {
  color: #fff494;
}
.router-link-exact-active::after {
  width: 100%;
}
</style>
