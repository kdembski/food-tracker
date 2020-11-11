<?php
include "config.php";
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");

$result = array('error'=>false);
$action = '';

if(isset($_GET['action'])){
  $action = $_GET['action'];
}

if($action == 'get_all_dishes'){
  $sql = $conn->query("SELECT * FROM dishes");
  $dishes = array();
  while($row = $sql->fetch_assoc()){
    array_push($dishes, $row);
  }
  $result['dishes'] = $dishes;
}

if($action == 'add_dish'){
  $name = $_POST['name'];
  $prepTime = $_POST['prepTime'];
  $rating = $_POST['rating'];
  $image = $_POST['image'];

  $sql = $conn->query("INSERT INTO dishes (dish_name, preparation_time, rating, image) VALUES('$name','$prepTime','$rating','$image')");

  if($sql){
    $result['message'] = "Dish added successfully!";
  }
  else{
    $result['error'] = true;
    $result['message'] = "Failed to add dish!";
  }
}

if($action == 'update_dish'){
  $id = $_POST['dish_id'];
  $name = $_POST['dish_name'];
  $image = $_POST['image'];
  $prepTime = $_POST['preparation_time'];
  $rating = $_POST['rating'];

  $sql = $conn->query("UPDATE dishes SET dish_name='$name',preparation_time='$prepTime',rating='$rating',image='$image' WHERE dish_id='$id'");

  if($sql){
    $result['message'] = "Dish updated successfully!";
  }
  else{
    $result['error'] = true;
    $result['message'] = "Failed to update dish!";
  }
}

if($action == 'delete_dish'){
  $id = $_POST['id'];

  $sql = $conn->query("DELETE FROM dishes WHERE dish_id='$id'");

  if($sql){
    $result['message'] = "Dish deleted successfully!";
  }
  else{
    $result['error'] = true;
    $result['message'] = "Failed to delete dish!";
  }
}

if($action == 'dish_details'){
  $id = $_POST['id'];

  $sql = $conn->query("SELECT step_id, step_number, instructions FROM recipes_steps WHERE dish_id='$id'");
  $dish_steps = array();
  while($row = $sql->fetch_assoc()){
    array_push($dish_steps, $row);
  }
  $sql = $conn->query("SELECT * FROM dishes WHERE dish_id='$id'");
  $dish = array();
  while($row = $sql->fetch_assoc()){
    array_push($dish, $row);
  }
  $sql = $conn->query("SELECT amount, ingredient_name, kcal_per_unit, unit_name, shortcut FROM recipes_ingredients_view WHERE dish_id='$id'");
  $dish_ingredients = array();
  while($row = $sql->fetch_assoc()){
    array_push($dish_ingredients, $row);
  }
  $result['dish'] = $dish;
  $result['dish_steps'] = $dish_steps;
  $result['dish_ingredients'] = $dish_ingredients;
}

$conn->close();
echo json_encode($result);
?>