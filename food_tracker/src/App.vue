<template>
  <div class="main-div">
    <nav class="navbar sticky-top navbar-expand-lg" id="nav-div">
      <img src="./assets/logo.png" class="navbrand" loading="lazy" />
      <div class="brand-name">food tracker</div>
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
            <router-link to="/dishlist">PRZEPISY</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/calendar">KALENDARZ</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/ingredientlist">SKŁADNIKI</router-link>
          </li>
        </ul>
      </div>
    </nav>
    <transition name="fade" mode="out-in">
      <router-view :key="$route.fullPath" />
    </transition>
  </div>
</template>
