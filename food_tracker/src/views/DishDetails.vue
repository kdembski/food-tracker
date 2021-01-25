<template>
  <div class="container-fluid py-2 py-lg-4 px-lg-5">
    <!---->
    <div class="row mb-lg-3" v-for="(dish, index) in dish" :key="index">
      <!--image-->
      <div
        class="dish-details-image-div"
        v-bind:style="{ 'background-image': 'url(' + dish.image + ')' }"
      >
        <!--dish-->
        <div class="dish-details-div">
          <!--name-->
          <div class="row">
            <p id="dish-name">{{ dish.dish_name }}</p>
          </div>
          <div class="row">
            <!--rating-->
            <div id="stars">
              <div v-for="index in 5" :key="index">
                <label
                  class="star-icon checked"
                  v-if="dish.rating >= index"
                ></label>
                <label v-else class="star-icon star-icon-dish-details"></label>
              </div>
            </div>
            <!--category-->
            <div id="category">
              <span class="fas fa-utensils"></span>
              <div class="d-flex justify-content-start category">
                <div
                  class="d-flex justify-content-start"
                  v-for="(category, index) in dishCategory"
                  :key="index"
                >
                  <p>
                    {{ category }}
                  </p>
                  <p class="px-1" v-if="index == 0 && dishCategory.length >= 2">
                    /
                  </p>
                  <p class="px-1" v-if="index == 1 && dishCategory.length == 3">
                    /
                  </p>
                </div>
              </div>
            </div>
            <!--kcal-->
            <div id="kcal">
              <span class="fas fa-fire-alt"></span>
              <div>
                <p>{{ kcalSum }} kcal</p>
              </div>
            </div>
            <!--prep time-->
            <div id="preptime">
              <span class="fas fa-clock"></span>
              <div>
                <p>{{ dish.preparation_time }} min.</p>
              </div>
            </div>
          </div>
          <!--buttons-->
          <div class="row dish-details-buttons-div">
            <div class="button mr-3 dish-details-button" @click="editingDish">
              <div class="button-icon">
                <i class="fas fa-pen"></i>
              </div>
              <span>edytuj</span>
            </div>
            <div
              class="button dish-details-button"
              @click="showDeleteDishModal"
            >
              <div class="button-icon">
                <i class="fas fa-trash-alt"></i>
              </div>
              <span>usuń</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!--end of first row-->

    <div class="row">
      <!--ingredients-->
      <div class="col-lg-5 p-0">
        <div class="ingredient-main-div mb-3 mb-lg-0">
          <div class="row">
            <div class="col-6 p-0"><h2 class="mb-4">Składniki:</h2></div>
            <div class="col-6 portions-header p-0 d-flex justify-content-end">
              <p class="pr-2">Porcje:</p>
              <div
                :class="decreasePortionsButtonClass"
                @click="decreasePortions"
              >
                <i class="fas fa-minus"></i>
              </div>
              <p class="px-3 portions-number">{{ portions }}</p>
              <div
                :class="increasePortionsButtonClass"
                @click="increasePortions"
              >
                <i class="fas fa-plus"></i>
              </div>
            </div>
          </div>
          <div>
            <div style="margin-top:-16px">
              <transition-group name="dishIngredientsList">
                <div
                  v-for="(ingredient, index) in dishIngredients"
                  :key="index"
                  class="dish-ingredients-list"
                >
                  <label class="row ingredient-div ingredient-label">
                    <input
                      type="checkbox"
                      class="ingredient-input"
                      :disabled="isIngredientsEdited"
                    />
                    <div
                      class="ingredient-col col-9 p-0 d-flex justify-content-start align-items-end"
                    >
                      <div class="ingredient-checkmark"></div>
                      <p class="m-0 mr-2 ingredient-name">
                        {{ ingredient.ingredient_name }}
                      </p>
                      <transition
                        name="slideEditIngredientButtons"
                        mode="out-in"
                      >
                        <div
                          v-if="isIngredientsEdited"
                          class="row edit-ingredient-buttons-div"
                        >
                          <div
                            class="button-small button-xxs"
                            @click="
                              showEditIngredientModal(
                                ingredient.recipe_element_id
                              )
                            "
                          >
                            <i class="fas fa-pen"></i>
                          </div>
                          <div
                            class="button-small button-xxs"
                            @click="showDeleteIngredientModal(index)"
                          >
                            <i class="fas fa-trash-alt"></i>
                          </div>
                        </div>
                      </transition>
                    </div>
                    <div
                      class="ingredient-col col-3 p-0 d-flex justify-content-end align-items-end"
                    >
                      <p class="m-0 ingredient-name">
                        {{ ingredient.amount }} {{ ingredient.shortcut }}
                      </p>
                    </div>
                  </label>
                </div>
              </transition-group>
            </div>
            <div class="row d-flex justify-content-start"></div>
          </div>
          <!--buttons-->
          <div v-if="isIngredientsEdited" class="row mt-4">
            <div class="button mr-3" @click="showAddIngredientModal">
              <div class="button-icon">
                <i class="fas fa-plus"></i>
              </div>
              <span>dodaj</span>
            </div>
            <div class="button" @click="cancelEditingAllIngredients">
              <div class="button-icon">
                <i class="fas fa-times"></i>
              </div>
              <span>anuluj</span>
            </div>
          </div>
          <div v-else class="row mt-4">
            <div class="button" @click="editingAllIngredients">
              <div class="button-icon">
                <i class="fas fa-pen"></i>
              </div>
              <span>edytuj</span>
            </div>
          </div>
        </div>
      </div>
      <!--steps-->
      <div class="col-lg-7 p-0">
        <div class="step-main-div">
          <div class="row">
            <h2 class="mb-4">Krok po kroku:</h2>
          </div>
          <div>
            <div>
              <transition-group name="dishStepsList">
                <div
                  v-for="(step, index) in dishSteps"
                  :key="index"
                  class="dish-steps-list"
                >
                  <div class="step-div">
                    <div class="row d-flex justify-content-start">
                      <h4 class="step-number">Krok {{ step.step_number }}</h4>
                      <transition name="slideEditStepButtons" mode="out-in">
                        <div v-if="isStepsEdited" class="edit-step-buttons-div">
                          <div
                            class="button-small button-xxs ml-2"
                            @click="showEditStepModal(index)"
                          >
                            <i class="fas fa-pen"></i>
                          </div>
                          <div
                            class="button-small button-xxs"
                            @click="showDeleteStepModal(index)"
                          >
                            <i class="fas fa-trash-alt"></i>
                          </div>
                        </div>
                      </transition>
                    </div>
                    <div class="row d-flex justify-content-start">
                      <p class="mb-0 step-instructions">
                        {{ step.instructions }}
                      </p>
                    </div>
                  </div>
                  <!--buttons-->
                  <div class="row" style="height:1.5rem"></div>
                </div>
              </transition-group>
            </div>
            <div class="row d-flex justify-content-start"></div>
          </div>
          <!--buttons-->
          <div v-if="isStepsEdited" class="row">
            <div class="button mr-3" @click="showAddStepModal">
              <div class="button-icon">
                <i class="fas fa-plus"></i>
              </div>
              <span>dodaj</span>
            </div>
            <div class="button" @click="cancelEditingAllSteps">
              <div class="button-icon">
                <i class="fas fa-times"></i>
              </div>
              <span>anuluj</span>
            </div>
          </div>
          <div v-else class="row">
            <div class="button" @click="editingAllSteps">
              <div class="button-icon">
                <i class="fas fa-pen"></i>
              </div>
              <span>edytuj</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!--similar dishes-->
    <div class="row px-xl-3 pt-3"><h2>Podobne przepisy:</h2></div>
    <div class="similar-dishes-div py-3">
      <div
        v-for="(dish, index) in similarDishesList"
        :key="index"
        class="similar-dish mx-3"
        v-bind:style="{ 'background-image': 'url(' + dish.image + ')' }"
      >
        <router-link
          :to="{
            name: 'DishDetails',
            params: { id: dish.dish_id, name: dish.dish_name },
          }"
          class="routerlink"
          replace
        >
          <div class="similar-dish-name">{{ dish.dish_name }}</div>
          <div class="similar-dish-details">
            <div class="col-5 p-0 similar-dish-rating">
              <div v-for="index in 5" :key="index">
                <label
                  class="star-icon similar-dish-star-icon checked"
                  v-if="dish.rating >= index"
                ></label>
                <label v-else class="star-icon similar-dish-star-icon"></label>
              </div>
            </div>
            <div class="col-3 p-0 similar-dish-preptime">
              {{ dish.preparation_time }} min.
            </div>
            <div class="col-4 p-0 similar-dish-kcalsum">
              {{ dish.kcalSum }} kcal
            </div>
          </div>
        </router-link>
      </div>
    </div>

    <!--_____________________________________________________________modals___________________________________________________________________-->
    <!--edit dish modal-->
    <transition name="modal">
      <div v-if="editDishModal" class="overlay">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">
                Edytuj przepis
              </h5>
            </div>
            <div class="modal-body ">
              <transition name="alert">
                <div
                  v-show="editingDishError && editingDishErrorAlert"
                  class="alert custom-alert alert-danger"
                  role="alert"
                  @click="hideAlert"
                >
                  Nie udało sie zaktualizować przepisu!
                </div>
              </transition>
              <!--name-->
              <div class="edited-dish-details-div">
                <div class="row">
                  <h6>Nazwa przepisu:</h6>
                </div>
                <div class="row">
                  <input
                    type="text"
                    v-model="dish[0].dish_name"
                    class="form-control custom-input"
                  />
                </div>
                <transition name="modalsInputAlert">
                  <div
                    v-show="dish[0].dish_name == '' && editingDishError == true"
                    class="alert custom-alert-small alert-danger"
                    role="alert"
                  >
                    Nazwa przepisu nie może być pusta
                  </div>
                </transition>
                <!--prep time-->
                <div class="row mt-2">
                  <h6>Czas przygotowania (min):</h6>
                </div>
                <div class="row">
                  <input
                    type="number"
                    v-model="dish[0].preparation_time"
                    class="form-control custom-input"
                  />
                </div>
                <transition name="modalsInputAlert">
                  <div
                    v-show="
                      (dish[0].preparation_time < 1 ||
                        dish[0].preparation_time > 999 ||
                        dish[0].preparation_time == '') &&
                        editingDishError == true
                    "
                    class="alert custom-alert-small alert-danger"
                    role="alert"
                  >
                    Czas przygotowania musi być z przedziału od 1 do 999
                  </div>
                </transition>
                <!--image-->
                <div class="row mt-2">
                  <h6>Zdjęcie (link):</h6>
                </div>
                <div class="row">
                  <input
                    type="url"
                    v-model="dish[0].image"
                    class="form-control custom-input"
                  />
                </div>
                <!--rating-->
                <div class="row mt-2">
                  <h6>Ocena:</h6>
                </div>
                <div class="row mb-2">
                  <div class="edit-stars">
                    <div class="row mb-1" style="margin-top:-15px">
                      <input
                        class="star-icon order-10"
                        id="star-5"
                        type="radio"
                        name="star"
                        value="5"
                        v-model="starValue"
                      />
                      <label
                        class="star-icon star-5 order-9"
                        for="star-5"
                      ></label>

                      <input
                        class="star-icon order-8"
                        id="star-4"
                        type="radio"
                        name="star"
                        value="4"
                        v-model="starValue"
                      />
                      <label
                        class="star-icon star-4 order-7"
                        for="star-4"
                      ></label>

                      <input
                        class="star-icon order-6"
                        id="star-3"
                        type="radio"
                        name="star"
                        value="3"
                        v-model="starValue"
                      />
                      <label
                        class="star-icon star-3 order-5"
                        for="star-3"
                      ></label>

                      <input
                        class="star-icon order-4"
                        id="star-2"
                        type="radio"
                        name="star"
                        value="2"
                        v-model="starValue"
                      />
                      <label
                        class="star-icon star-2 order-3"
                        for="star-2"
                      ></label>

                      <input
                        class="star-icon order-2"
                        id="star-1"
                        type="radio"
                        name="star"
                        value="1"
                        v-model="starValue"
                      />
                      <label
                        class="star-icon star-1 order-1"
                        for="star-1"
                      ></label>
                    </div>
                  </div>
                </div>
                <!--category-->
                <div class="row">
                  <h6>Posiłek:</h6>
                </div>
                <div class="dish-category-div">
                  <label class="dish-category-label">
                    <input
                      type="checkbox"
                      value="1"
                      v-model="categoryList"
                      class="dish-category-input"
                    />
                    <div class="dish-category-checkmark"></div>
                    <p>śniadanie</p>
                  </label>
                  <label class="dish-category-label">
                    <input
                      type="checkbox"
                      value="2"
                      v-model="categoryList"
                      class="dish-category-input"
                    />
                    <div class="dish-category-checkmark"></div>
                    <p>obiad</p>
                  </label>
                  <label class="dish-category-label">
                    <input
                      type="checkbox"
                      value="3"
                      v-model="categoryList"
                      class="dish-category-input"
                    />
                    <div class="dish-category-checkmark"></div>
                    <p>kolacja</p>
                  </label>
                </div>
              </div>
            </div>
            <div class="modal-footer">
              <div class="button mr-3" @click="confirmEditingDish">
                <div class="button-icon">
                  <i class="fas fa-check"></i>
                </div>
                <span>akceptuj</span>
              </div>

              <div class="button" @click="cancelEditingDish">
                <div class="button-icon">
                  <i class="fas fa-times"></i>
                </div>
                <span>anuluj</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>
    <!--delete dish modal-->
    <transition name="modal">
      <div v-if="deleteDishModal" class="overlay">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">
                Usuń przepis
              </h5>
            </div>
            <div class="modal-body ">
              Czy na pewno chcesz usunąć przepis
              <b>{{ dish[0].dish_name }}</b> ?
            </div>
            <div class="modal-footer">
              <div class="button mr-3" @click="deleteCurrentDish">
                <div class="button-icon">
                  <i class="fas fa-check"></i>
                </div>
                <span>akceptuj</span>
              </div>
              <div class="button" @click="hideDeleteDishModal">
                <div class="button-icon">
                  <i class="fas fa-times"></i>
                </div>
                <span>anuluj</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>
    <!--edit step modal-->
    <transition name="modal">
      <div v-if="editStepModal" class="overlay">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">
                Zaktualizuj krok
              </h5>
              <div class="button-small" @click="hideEditStepModal">
                <i class="fas fa-times"></i>
              </div>
            </div>
            <div class="modal-body ">
              <transition name="alert">
                <div
                  v-show="editingStepError && editingStepErrorAlert"
                  class="alert custom-alert alert-danger"
                  role="alert"
                  @click="hideAlert"
                >
                  Nie udało się zaktualizować kroku!
                </div>
              </transition>
              <div class="row mt-1">
                <h6>Numer kroku:</h6>
              </div>
              <input
                type="number"
                v-model="dishSteps[editedStepIndex].step_number"
                class="form-control modal-custom-input"
              />
              <transition name="modalsInputAlert">
                <div
                  v-show="
                    (dishSteps[editedStepIndex].step_number < 1 ||
                      dishSteps[editedStepIndex].step_number > 99 ||
                      dishSteps[editedStepIndex].step_number == '') &&
                      editingStepError == true
                  "
                  class="alert custom-alert-small alert-danger"
                  role="alert"
                >
                  Numer kroku musi być z przedziału od 1 do 99
                </div>
              </transition>
              <div class="row mt-1">
                <h6>Instrukcje:</h6>
              </div>
              <div class="row">
                <textarea
                  rows="5"
                  cols="60"
                  class="form-control modal-custom-input"
                  name="instructions"
                  v-model="dishSteps[editedStepIndex].instructions"
                ></textarea>
                <transition name="modalsInputAlert">
                  <div
                    v-show="
                      dishSteps[editedStepIndex].instructions == '' &&
                        editingStepError == true
                    "
                    class="alert custom-alert-small alert-danger"
                    role="alert"
                  >
                    Musisz podać instrukcje
                  </div>
                </transition>
              </div>
            </div>
            <div class="modal-footer">
              <div class="button" @click="confirmEditingStep">
                <div class="button-icon">
                  <i class="fas fa-check"></i>
                </div>
                <span>akceptuj</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>
    <!--add step modal-->
    <transition name="modal">
      <div v-if="addStepModal" class="overlay">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">
                Dodaj krok
              </h5>
              <div class="button-small" @click="hideAddStepModal">
                <i class="fas fa-times"></i>
              </div>
            </div>
            <div class="modal-body ">
              <transition name="alert">
                <div
                  v-show="addingStepError && addingStepErrorAlert"
                  class="alert custom-alert alert-danger"
                  role="alert"
                  @click="hideAlert"
                >
                  Nie udało się dodać kroku!
                </div>
              </transition>
              <div class="row">
                <div class="row mt-1">
                  <h6>Numer kroku:</h6>
                </div>
                <input
                  type="number"
                  v-model="newStep.step_number"
                  class="form-control modal-custom-input"
                />
              </div>
              <transition name="modalsInputAlert">
                <div
                  v-show="
                    (newStep.step_number < 1 ||
                      newStep.step_number > 99 ||
                      newStep.step_number == '') &&
                      addingStepError == true
                  "
                  class="alert custom-alert-small alert-danger"
                  role="alert"
                >
                  Numer kroku musi być z przedziału od 1 do 99
                </div>
              </transition>
              <div class="row mt-1">
                <h6>Instrukcje:</h6>
              </div>
              <div class="row">
                <textarea
                  rows="5"
                  cols="60"
                  class="form-control modal-custom-input"
                  name="instructions"
                  v-model="newStep.instructions"
                ></textarea>
              </div>
              <transition name="modalsInputAlert">
                <div
                  v-show="newStep.instructions == '' && addingStepError == true"
                  class="alert custom-alert-small alert-danger mb-0"
                  role="alert"
                >
                  Musisz podać instrukcje
                </div>
              </transition>
            </div>
            <div class="modal-footer">
              <div class="button mr-3" @click="confirmAddingStep">
                <div class="button-icon">
                  <i class="fas fa-check"></i>
                </div>
                <span>akceptuj</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>
    <!--delete step modal-->
    <transition name="modal">
      <div v-if="deleteStepModal" class="overlay">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">
                Usuń krok
              </h5>
            </div>
            <div class="modal-body">
              Czy na pewno chcesz usunąć
              <b>Krok {{ dishSteps[editedStepIndex].step_number }}</b> ?
            </div>
            <div class="modal-footer">
              <div class="button mr-3" @click="confirmDeletingStep">
                <div class="button-icon">
                  <i class="fas fa-check"></i>
                </div>
                <span>akceptuj</span>
              </div>
              <div class="button" @click="hideDeleteStepModal">
                <div class="button-icon">
                  <i class="fas fa-times"></i>
                </div>
                <span>anuluj</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>
    <!--edit ingredient modal-->
    <transition name="modal">
      <div v-if="editIngredientModal" class="overlay">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">
                Zaktualizuj składnik
              </h5>
              <div class="button-small" @click="hideEditIngredientModal">
                <i class="fas fa-times"></i>
              </div>
            </div>
            <div class="modal-body">
              <transition name="alert">
                <div
                  v-show="editingIngredientError && editingIngredientErrorAlert"
                  class="alert custom-alert alert-danger"
                  role="alert"
                  @click="hideAlert"
                >
                  Nie udało sie zaktualizować składnika!
                </div>
              </transition>
              <h6>Składnik:</h6>
              <div class="input-group mb-3 mt-3">
                <p class="mt-2 mr-4 ml-1 font-italic">
                  {{ editedIngredient.ingredient_name }}
                </p>
                <div
                  class="button select-button"
                  @click="showChooseIngredientModal"
                >
                  <div class="button-icon">
                    <i class="fas fa-list"></i>
                  </div>
                  <span>wybierz</span>
                </div>
              </div>
              <h6>Ilość na jedną porcję ({{ editedIngredient.unit_name }}):</h6>
              <input
                type="number"
                class="form-control modal-custom-input"
                v-model="editedIngredient.amount"
              />
              <transition name="modalsInputAlert">
                <div
                  v-show="
                    (editedIngredient.amount < 0 ||
                      editedIngredient.amount > 9999 ||
                      editedIngredient.amount == '') &&
                      editingIngredientError == true
                  "
                  class="alert custom-alert-small alert-danger mb-0"
                  role="alert"
                >
                  Ilość składnika musi być z przedziału od 0 do 9999
                </div>
              </transition>
            </div>
            <div class="modal-footer">
              <div class="button" @click="confirmEditingIngredient">
                <div class="button-icon">
                  <i class="fas fa-check"></i>
                </div>
                <span>akceptuj</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>
    <!--choose ingredient modal-->
    <transition name="modal">
      <div v-if="chooseIngredientModal" class="overlay">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">
                Wybierz składnik
              </h5>
              <div class="button-small" @click="hideChooseIngredientModal">
                <i class="fas fa-times"></i>
              </div>
            </div>
            <div class="modal-body">
              <transition name="alert">
                <div
                  v-show="ingredientNotSelected"
                  class="alert custom-alert alert-danger"
                  role="alert"
                  @click="hideAlert"
                >
                  Nie wybrano żadnego składnika!
                </div>
              </transition>
              <input
                type="text"
                class="form-control custom-input ingredient-search-input"
                placeholder="Wpisz nazwę składnika"
                v-model="ingredientSearch"
              />
              <i class="fa fa-search ingredient-search-icon"></i>
              <div class="row border-bottom">
                <div class="col-8"><h6>Składnik:</h6></div>
                <div class="col-4"><h6>Jednostka:</h6></div>
              </div>
              <div class="ingredient-list-div">
                <transition-group name="ingredientsList">
                  <div
                    class="row"
                    v-for="(ingredient, index) in filteredIngredients"
                    :key="index"
                  >
                    <label class="choose-ingredient">
                      <input
                        type="radio"
                        name="ingredient"
                        :value="ingredient.ingredient_id"
                        v-model="chosenIngredientId"
                        class="choose-ingredient-input"
                      />
                      <div class="py-2">
                        <div class="row">
                          <div class="col-8 ml-1">
                            {{ ingredient.ingredient_name }}
                          </div>
                          <div class="col-3 ml-1">
                            {{ ingredient.unit_name }}
                          </div>
                        </div>
                      </div>
                    </label>
                  </div>
                </transition-group>
              </div>
            </div>
            <div class="modal-footer">
              <div class="button" @click="confirmChoosingIngredient">
                <div class="button-icon">
                  <i class="fas fa-check"></i>
                </div>
                <span>akceptuj</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>
    <!--add ingredient modal-->
    <transition name="modal">
      <div v-if="addIngredientModal" class="overlay">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">
                Dodaj składnik
              </h5>
              <div class="button-small" @click="hideAddIngredientModal">
                <i class="fas fa-times"></i>
              </div>
            </div>
            <div class="modal-body">
              <transition name="alert">
                <div
                  v-show="addingIngredientError && addingIngredientErrorAlert"
                  class="alert custom-alert alert-danger"
                  role="alert"
                  @click="hideAlert"
                >
                  Nie udało się dodać składnika!
                </div>
              </transition>
              <h6>Wybierz składnik:</h6>
              <div class="input-group mb-3 mt-3">
                <p
                  v-if="newIngredient.ingredient_name != ''"
                  class="mt-2 mr-4 ml-1 font-italic"
                >
                  {{ newIngredient.ingredient_name }}
                </p>
                <p
                  v-else
                  class="mt-2 mr-4 ml-1 font-italic"
                  :class="{ 'error-color': addingIngredientError }"
                >
                  nie wybrano...
                </p>
                <div class="button" @click="showNewIngredientModal">
                  <div class="button-icon">
                    <i class="fas fa-list"></i>
                  </div>
                  <span>wybierz</span>
                </div>
              </div>
              <h6>Ilość na jedną porcję ({{ newIngredient.unit_name }}):</h6>
              <input
                type="number"
                class="form-control modal-custom-input"
                v-model="newIngredient.amount"
              />
              <transition name="modalsInputAlert">
                <div
                  v-show="
                    (newIngredient.amount < 0 ||
                      newIngredient.amount > 9999 ||
                      newIngredient.amount == '') &&
                      addingIngredientError == true
                  "
                  class="alert custom-alert-small alert-danger mb-0"
                  role="alert"
                >
                  Ilość składnika musi być z przedziału od 0 do 9999
                </div>
              </transition>
            </div>
            <div class="modal-footer">
              <div class="button" @click="confirmAddingIngredient">
                <div class="button-icon">
                  <i class="fas fa-check"></i>
                </div>
                <span>akceptuj</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>
    <!--choose new ingredient modal-->
    <transition name="modal">
      <div v-if="newIngredientModal" class="overlay">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">
                Wybierz nowy składnik
              </h5>
              <div class="button-small" @click="hideNewIngredientModal">
                <i class="fas fa-times"></i>
              </div>
            </div>
            <div class="modal-body">
              <transition name="alert">
                <div
                  v-show="ingredientNotSelected"
                  class="alert custom-alert alert-danger"
                  role="alert"
                  @click="hideAlert"
                >
                  Nie wybrano żadnego składnika!
                </div>
              </transition>
              <input
                type="text"
                class="form-control custom-input ingredient-search-input"
                placeholder="Wpisz nazwę składnika"
                v-model="ingredientSearch"
              />
              <i class="fa fa-search ingredient-search-icon"></i>
              <div class="row border-bottom">
                <div class="col-8"><h6>Składnik:</h6></div>
                <div class="col-4"><h6>Jednostka:</h6></div>
              </div>
              <div class="ingredient-list-div">
                <transition-group name="ingredientsList">
                  <div
                    class="row"
                    v-for="(ingredient, index) in filteredIngredients"
                    :key="index"
                  >
                    <label class="choose-ingredient">
                      <input
                        type="radio"
                        name="ingredient"
                        :value="ingredient.ingredient_id"
                        v-model="chosenIngredientId"
                        class="choose-ingredient-input"
                      />
                      <div class="py-2">
                        <div class="row">
                          <div class="col-8 ml-1">
                            {{ ingredient.ingredient_name }}
                          </div>
                          <div class="col-3 ml-1">
                            {{ ingredient.unit_name }}
                          </div>
                        </div>
                      </div>
                    </label>
                  </div>
                </transition-group>
              </div>
            </div>
            <div class="modal-footer">
              <div class="button" @click="confirmNewIngredient">
                <div class="button-icon">
                  <i class="fas fa-check"></i>
                </div>
                <span>akceptuj</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>
    <!--delete ingredient modal-->
    <transition name="modal">
      <div v-if="deleteIngredientModal" class="overlay">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">
                Usuń składnik
              </h5>
            </div>
            <div class="modal-body">
              Czy na pewno chcesz usunąć
              <b>
                {{ dishIngredients[deletedIngredientIndex].ingredient_name }}</b
              >
              z listy składników ?
            </div>
            <div class="modal-footer">
              <div class="button mr-3" @click="confirmDeletingIngredient">
                <div class="button-icon">
                  <i class="fas fa-check"></i>
                </div>
                <span>akceptuj</span>
              </div>
              <div class="button" @click="hideDeleteIngredientModal">
                <div class="button-icon">
                  <i class="fas fa-times"></i>
                </div>
                <span>anuluj</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>
<script>
import axios from "axios";

export default {
  data() {
    return {
      dish: [],
      dishSteps: [],
      dishIngredients: [],
      ingredients: [],
      params: { id: this.$route.params.id },
      imgError: false,
      isDishEdited: false,
      deleteDishModal: false,
      starValue: "",
      data: { recipe_element_id: "" },
      editDishModal: false,
      categoryList: [],

      //alerts variables
      editingDishErrorAlert: false,
      editingIngredientErrorAlert: false,
      addingIngredientErrorAlert: false,
      editingStepErrorAlert: false,
      addingStepErrorAlert: false,

      ingredientNotSelected: false,
      editingDishError: false,
      editingIngredientError: false,
      addingIngredientError: false,
      editingStepError: false,
      addingStepError: false,

      //steps variables
      isStepsEdited: false,
      editStepModal: false,
      editedStepIndex: "",
      addStepModal: false,
      newStep: {
        step_id: "",
        step_number: "",
        instructions: "",
        dish_id: "",
      },
      deleteStepModal: false,

      //ingredients variables
      isIngredientsEdited: false,
      editIngredientModal: false,
      chooseIngredientModal: false,
      chosenIngredientId: "",
      editedRecipeElementId: "",
      formDataForUpdateIngredient: {
        recipe_element_id: "",
        ingredient_id: "",
        amount: "",
      },
      editedIngredient: {
        recipe_element_id: "",
        amount: "",
        ingredient_name: "",
        ingredient_id: "",
        kcal_per_unit: "",
        shortcut: "",
        unit_name: "",
      },
      addIngredientModal: false,
      newIngredient: {
        ingredient_name: "",
        ingredient_id: "",
        amount: "",
        unit_name: "",
        dish_id: "",
      },
      newIngredientModal: false,
      deleteIngredientModal: false,
      deletedIngredientIndex: "",
      ingredientSearch: "",

      //portions
      portions: "1",
      dishTagList: [],
      similarDishesList: [],
    };
  },
  mounted() {
    this.getCurrentDish();
    this.getIngredients();
  },
  methods: {
    //get current dish
    getCurrentDish() {
      var formData = this.toFormData(this.$route.params);
      axios
        .post(
          "http://localhost/food_tracker/process.php?action=dish_details",
          formData
        )
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          } else {
            this.dish = response.data.dish;
            this.dishSteps = response.data.dish_steps;
            this.dishSteps.sort((a, b) => a.step_number - b.step_number);
            this.dishIngredients = response.data.dish_ingredients;
            this.dishIngredients.forEach((ingredient) => {
              ingredient.amount = parseFloat(ingredient.amount).toString();
            });
            this.portions = "1";
            this.getSimilarDishesList();
            this.categoryList = Array.from(this.dish[0].category);
          }
        });
    },

    //update current dish
    updateCurrentDish() {
      this.dish[0].rating = this.starValue;
      this.categoryList.sort();
      if (this.categoryList.length == 1) {
        this.dish[0].category = this.categoryList[0];
      } else if (this.categoryList.length == 2) {
        this.dish[0].category = this.categoryList[0].concat(
          this.categoryList[1]
        );
      } else if (this.categoryList.length == 3) {
        this.dish[0].category = this.categoryList[0].concat(
          this.categoryList[1],
          this.categoryList[2]
        );
      } else if (this.categoryList.length == 0) {
        this.dish[0].category = "0";
      }

      var formData = this.toFormData(this.dish[0]);
      axios
        .post(
          "http://localhost/food_tracker/process.php?action=update_dish",
          formData
        )
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
            this.editingDishError = true;
            this.editingDishErrorAlert = true;
          } else {
            this.getCurrentDish();
            console.log(response.data);
            this.editingDishError = false;
            this.editingDishErrorAlert = false;
          }
        });
    },

    //delete current dish
    deleteCurrentDish() {
      var formData = this.toFormData(this.dish[0]);
      axios
        .post(
          "http://localhost/food_tracker/process.php?action=delete_dish",
          formData
        )
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          } else {
            this.getCurrentDish();
            console.log(response.data);
            this.$router.push({
              path: "/dishlist",
              name: "DishList",
              params: {
                dish_id: this.dish[0].dish_id,
                dish_name: this.dish[0].dish_name,
                image: this.dish[0].image,
              },
            });
          }
        });
    },

    //update selected step
    updateStep() {
      var formData = this.toFormData(this.dishSteps[this.editedStepIndex]);
      axios
        .post(
          "http://localhost/food_tracker/process.php?action=update_step",
          formData
        )
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          } else {
            this.getCurrentDish();
            console.log(response.data);
          }
        });
    },

    //add new step
    addNewStep() {
      this.newStep.dish_id = this.dish[0].dish_id;
      var formData = this.toFormData(this.newStep);
      axios
        .post(
          "http://localhost/food_tracker/process.php?action=add_step",
          formData
        )
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          } else {
            this.getCurrentDish();
            console.log(response.data);
          }
        });
    },

    //delete step
    deleteStep(index) {
      var formData = this.toFormData(this.dishSteps[index]);
      axios
        .post(
          "http://localhost/food_tracker/process.php?action=delete_step",
          formData
        )
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          } else {
            this.getCurrentDish();
            console.log(response.data);
          }
        });
    },
    // get all ingredinets
    getIngredients() {
      axios
        .get("http://localhost/food_tracker/process.php?action=get_ingredients")
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          } else {
            this.ingredients = response.data.ingredients;
          }
        });
    },
    //update ingredient in recipe
    updateIngredient() {
      this.formDataForUpdateIngredient.recipe_element_id = this.editedIngredient.recipe_element_id;
      this.formDataForUpdateIngredient.ingredient_id = this.editedIngredient.ingredient_id;
      this.formDataForUpdateIngredient.amount = this.editedIngredient.amount;
      var formData = this.toFormData(this.formDataForUpdateIngredient);
      axios
        .post(
          "http://localhost/food_tracker/process.php?action=update_ingredient",
          formData
        )
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
            this.editingIngredientError = true;
            this.editingIngredientErrorAlert = true;
          } else {
            this.getCurrentDish();
            this.editingIngredientError = false;
            this.editingIngredientErrorAlert = false;
          }
        });
    },

    //add new ingredient
    addNewIngredient() {
      this.newIngredient.dish_id = this.dish[0].dish_id;
      var formData = this.toFormData(this.newIngredient);
      axios
        .post(
          "http://localhost/food_tracker/process.php?action=add_ingredient",
          formData
        )
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          } else {
            this.getCurrentDish();
            console.log(response.data);
          }
        });
    },

    //delete ingredient
    deleteIngredient() {
      var formData = this.toFormData(
        (this.data = {
          recipe_element_id: this.dishIngredients[this.deletedIngredientIndex]
            .recipe_element_id,
        })
      );
      axios
        .post(
          "http://localhost/food_tracker/process.php?action=delete_ingredient",
          formData
        )
        .then((response) => {
          if (response.data.error) {
            this.errorMsg = response.data.message;
          } else {
            this.getCurrentDish();
            console.log(response.data);
          }
        });
    },

    toFormData(obj) {
      var fd = new FormData();
      for (var i in obj) {
        fd.append(i, obj[i]);
      }
      return fd;
    },

    //hide alert div on click
    hideAlert() {
      this.editingDishErrorAlert = false;
      this.editingIngredientErrorAlert = false;
      this.addingIngredientErrorAlert = false;
      this.editingStepErrorAlert = false;
      this.addingStepErrorAlert = false;
      this.ingredientNotSelected = false;
    },

    //dish editing methods
    editingDish() {
      this.editDishModal = true;
      this.starValue = this.dish[0].rating;
      this.isIngredientsEdited = false;
      this.isStepsEdited = false;
    },
    confirmEditingDish() {
      if (this.dish[0].dish_name == "") {
        this.editingDishError = true;
        this.editingDishErrorAlert = true;
      } else if (
        this.dish[0].preparation_time < 1 ||
        this.dish[0].preparation_time > 999 ||
        this.dish[0].preparation_time == ""
      ) {
        this.editingDishError = true;
        this.editingDishErrorAlert = true;
      } else {
        this.editDishModal = false;
        this.updateCurrentDish();
        this.editingDishError = false;
        this.editingDishErrorAlert = false;
      }
    },
    cancelEditingDish() {
      this.editDishModal = false;
      this.editingDishError = false;
      this.editingDishErrorAlert = false;
      this.getCurrentDish();
    },
    showDeleteDishModal() {
      this.deleteDishModal = true;
    },
    hideDeleteDishModal() {
      this.deleteDishModal = false;
    },

    //ingredients editing methods
    editingAllIngredients() {
      this.isIngredientsEdited = true;
      this.isDishEdited = false;
      this.isStepsEdited = false;
      this.editingDishError = false;
      this.editingDishErrorAlert = false;
      this.getCurrentDish();
    },
    confirmEditingAllIngredients() {
      this.isIngredientsEdited = false;
    },
    cancelEditingAllIngredients() {
      this.isIngredientsEdited = false;
    },
    showEditIngredientModal(recipe_element_id) {
      this.editIngredientModal = true;
      this.editedRecipeElementId = recipe_element_id;

      var ingredient = this.dishIngredients.find(
        (ingredient) =>
          ingredient.recipe_element_id === this.editedRecipeElementId
      );
      this.editedIngredient = ingredient;
    },
    hideEditIngredientModal() {
      this.editIngredientModal = false;
      this.editingIngredientError = false;
      this.editingIngredientErrorAlert = false;
      this.chosenIngredientId = "";
      this.getCurrentDish();
    },
    showChooseIngredientModal() {
      this.editIngredientModal = false;
      this.chooseIngredientModal = true;
      this.editingIngredientError = false;
      this.editingIngredientErrorAlert = false;
    },
    hideChooseIngredientModal() {
      this.editIngredientModal = true;
      this.chooseIngredientModal = false;
      this.ingredientNotSelected = false;
    },
    confirmChoosingIngredient() {
      if (this.chosenIngredientId == "") {
        this.ingredientNotSelected = true;
      } else {
        var ingredient = this.ingredients.find(
          (ingredient) => ingredient.ingredient_id === this.chosenIngredientId
        );
        this.editedIngredient.ingredient_id = ingredient.ingredient_id;
        this.editedIngredient.ingredient_name = ingredient.ingredient_name;
        this.editedIngredient.unit_name = ingredient.unit_name;
        this.chooseIngredientModal = false;
        this.editIngredientModal = true;
        this.ingredientNotSelected = false;
      }
    },
    confirmEditingIngredient() {
      if (
        this.editedIngredient.amount < 0 ||
        this.editedIngredient.amount > 9999 ||
        this.editedIngredient.amount == ""
      ) {
        this.editingIngredientError = true;
        this.editingIngredientErrorAlert = true;
      } else {
        this.updateIngredient();
        this.editIngredientModal = false;
        this.chosenIngredientId = "";
        this.editingIngredientError = false;
        this.editingIngredientErrorAlert = false;
      }
    },
    //ingredient adding methods
    showAddIngredientModal() {
      this.addIngredientModal = true;
    },
    hideAddIngredientModal() {
      this.addIngredientModal = false;
      this.addingIngredientError = false;
      this.addingIngredientErrorAlert = false;
      this.chosenIngredientId = "";
      this.newIngredient = {
        ingredient_name: "",
        ingredient_id: "",
        amount: "",
        unit_name: "",
        dish_id: "",
      };
    },
    confirmAddingIngredient() {
      if (
        this.newIngredient.amount < 0 ||
        this.newIngredient.amount > 9999 ||
        this.newIngredient.amount == ""
      ) {
        this.addingIngredientError = true;
        this.addingIngredientErrorAlert = true;
      } else if (this.newIngredient.ingredient_id == "") {
        this.addingIngredientError = true;
        this.addingIngredientErrorAlert = true;
      } else {
        this.addNewIngredient();
        this.addIngredientModal = false;
        this.chosenIngredientId = "";
        this.newIngredient = {
          ingredient_name: "",
          ingredient_id: "",
          amount: "",
          unit_name: "",
          dish_id: "",
        };
        this.addingIngredientError = false;
        this.addingIngredientErrorAlert = false;
      }
    },
    showNewIngredientModal() {
      this.newIngredientModal = true;
      this.addIngredientModal = false;
      this.addingIngredientError = false;
      this.addingIngredientErrorAlert = false;
    },
    hideNewIngredientModal() {
      this.newIngredientModal = false;
      this.addIngredientModal = true;
      this.ingredientNotSelected = false;
    },
    confirmNewIngredient() {
      if (this.chosenIngredientId == "") {
        this.ingredientNotSelected = true;
      } else {
        var ingredient = this.ingredients.find(
          (ingredient) => ingredient.ingredient_id === this.chosenIngredientId
        );
        this.newIngredient.ingredient_id = ingredient.ingredient_id;
        this.newIngredient.ingredient_name = ingredient.ingredient_name;
        this.newIngredient.unit_name = ingredient.unit_name;
        this.newIngredientModal = false;
        this.addIngredientModal = true;
        this.ingredientNotSelected = false;
      }
    },
    showDeleteIngredientModal(index) {
      this.deleteIngredientModal = true;
      this.deletedIngredientIndex = index;
    },
    hideDeleteIngredientModal() {
      this.deleteIngredientModal = false;
      this.deletedIngredientIndex = "";
    },
    confirmDeletingIngredient() {
      this.deleteIngredientModal = false;
      this.deleteIngredient();
      this.deletedIngredientIndex = "";
    },

    //steps editing methods
    editingAllSteps() {
      this.isStepsEdited = true;
      this.isDishEdited = false;
      this.isIngredientsEdited = false;
      this.editingDishError = false;
      this.editingDishErrorAlert = false;
      this.getCurrentDish();
    },
    cancelEditingAllSteps() {
      this.isStepsEdited = false;
    },
    showEditStepModal(index) {
      this.editStepModal = true;
      this.editedStepIndex = index;
    },
    hideEditStepModal() {
      this.editStepModal = false;
      this.getCurrentDish();
      this.editingStepError = false;
      this.editingStepErrorAlert = false;
    },
    confirmEditingStep() {
      if (
        this.dishSteps[this.editedStepIndex].step_number < 1 ||
        this.dishSteps[this.editedStepIndex].step_number > 99 ||
        this.dishSteps[this.editedStepIndex].step_number == ""
      ) {
        this.editingStepError = true;
        this.editingStepErrorAlert = true;
      } else if (this.dishSteps[this.editedStepIndex].instructions == "") {
        this.editingStepError = true;
        this.editingStepErrorAlert = true;
      } else {
        this.editStepModal = false;
        this.updateStep();
        this.editingStepError = false;
        this.editingStepErrorAlert = false;
      }
    },
    showAddStepModal() {
      var i;
      for (i = 0; i < this.dishSteps.length; i++) {
        if (!(this.dishSteps[i].step_number == i + 1)) {
          this.newStep.step_number = i + 1;
          break;
        }
      }
      if (this.dishSteps.length == i) {
        this.newStep.step_number = i + 1;
      }
      this.addStepModal = true;
    },
    hideAddStepModal() {
      this.addStepModal = false;
      this.newStep = {
        step_id: "",
        step_number: "",
        instructions: "",
        dish_id: "",
      };
      this.addingStepError = false;
      this.addingStepErrorAlert = false;
    },
    confirmAddingStep() {
      if (
        this.newStep.step_number < 1 ||
        this.newStep.step_number > 99 ||
        this.newStep.step_number == ""
      ) {
        this.addingStepError = true;
        this.addingStepErrorAlert = true;
      } else if (this.newStep.instructions == "") {
        this.addingStepError = true;
        this.addingStepErrorAlert = true;
      } else {
        this.addStepModal = false;
        this.addNewStep();
        this.newStep = {
          step_id: "",
          step_number: "",
          instructions: "",
          dish_id: "",
        };
        this.addingStepError = false;
        this.addingStepErrorAlert = false;
      }
    },
    showDeleteStepModal(index) {
      this.deleteStepModal = true;
      this.editedStepIndex = index;
    },
    hideDeleteStepModal() {
      this.deleteStepModal = false;
      this.editedStepIndex = "";
    },
    confirmDeletingStep() {
      this.deleteStepModal = false;
      this.deleteStep(this.editedStepIndex);
      this.editedStepIndex = "";
    },
    increasePortions() {
      if (this.portions < 9 && !this.isIngredientsEdited) {
        this.portions++;
        for (var i = 0; i < this.dishIngredients.length; i++) {
          this.dishIngredients[i].amount *= this.portions / (this.portions - 1);
        }
      }
    },
    decreasePortions() {
      if (this.portions > 1 && !this.isIngredientsEdited) {
        this.portions--;
        for (var i = 0; i < this.dishIngredients.length; i++) {
          this.dishIngredients[i].amount *= this.portions / (this.portions + 1);
        }
      }
    },

    async getSimilarDishesList() {
      var tagList = this.dish[0].dish_name.split(" ");
      tagList.forEach(function(tag, index, array) {
        if (tag.length < 4) {
          array.splice(index, 1);
        }
      });
      tagList.forEach(function(tag, index, array) {
        array[index] = tag.slice(0, -Math.floor(tag.length / 3));
      });
      console.log(tagList);
      var formData = this.toFormData(
        (this.dishTagList = {
          tag1: tagList[0],
          tag2: tagList[1],
          tag3: tagList[2],
          tag4: tagList[3],
          category: this.dish[0].category,
        })
      );
      var response = await axios.post(
        "http://localhost/food_tracker/process.php?action=get_similar_dishes",
        formData
      );
      this.similarDishesList = response.data.dishes;

      var index = this.similarDishesList
        .map(function(dish) {
          return dish.dish_id;
        })
        .indexOf(this.dish[0].dish_id);

      if (index !== -1) {
        this.similarDishesList.splice(index, 1);
      }

      if (this.similarDishesList.length > 5) {
        var randomIndexesList = [];
        var tempList = [];
        while (randomIndexesList.length < 5) {
          let randIndex = Math.floor(
            Math.random() * (this.similarDishesList.length - 1)
          );
          if (randomIndexesList.indexOf(randIndex) < 0) {
            randomIndexesList.push(randIndex);
          }
        }
        for (let i = 0; i < randomIndexesList.length; i++) {
          tempList.push(this.similarDishesList[randomIndexesList[i]]);
        }
        this.similarDishesList = tempList;
      }

      for (var j = 0; j < this.similarDishesList.length; j++) {
        var ingredientsFormData = {
          dish_id: this.similarDishesList[j].dish_id,
        };
        var ingredients = await this.getDishIngredients(ingredientsFormData);

        var kcalSum = 0;
        if (ingredients.length > 0) {
          for (var k = 0; k < ingredients.length; k++) {
            kcalSum +=
              parseFloat(ingredients[k].amount) *
              parseFloat(ingredients[k].kcal_per_unit);
          }
          kcalSum = Math.floor(kcalSum);
        }
        this.$set(this.similarDishesList[j], "kcalSum", kcalSum);
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
  },

  computed: {
    kcalSum: function() {
      var kcal = 0;
      if (this.dish.length > 0) {
        for (var i = 0; i < this.dishIngredients.length; i++) {
          kcal +=
            parseFloat(this.dishIngredients[i].amount) *
            parseFloat(this.dishIngredients[i].kcal_per_unit);
        }
      }
      kcal = Math.floor(kcal);
      return kcal;
    },
    filteredIngredients: function() {
      return this.ingredients.filter((ingredient) => {
        return ingredient.ingredient_name
          .toLowerCase()
          .match(this.ingredientSearch.toLowerCase());
      });
    },
    increasePortionsButtonClass: function() {
      if (this.portions >= 9 || this.isIngredientsEdited) {
        return "button-small portions-button-inactive";
      } else {
        return "button-small portions-button";
      }
    },
    decreasePortionsButtonClass: function() {
      if (this.portions <= 1 || this.isIngredientsEdited) {
        return "button-small portions-button-inactive";
      } else {
        return "button-small portions-button";
      }
    },
    dishCategory: function() {
      var categoryList = [];
      for (let i = 0; i < this.categoryList.length; i++) {
        if (this.categoryList[i] == 0) {
          categoryList.push("Brak kategorii");
        }
        if (this.categoryList[i] == 1) {
          categoryList.push("Śniadanie");
        }
        if (this.categoryList[i] == 2) {
          categoryList.push("Obiad");
        }
        if (this.categoryList[i] == 3) {
          categoryList.push("Kolacja");
        }
      }
      return categoryList;
    },
  },
  watch: {
    $route: function() {
      this.getCurrentDish();
      this.getIngredients();
    },
  },
};
</script>
