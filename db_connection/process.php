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
  $sql = $conn->query("SELECT * FROM dishes ORDER BY RAND()");
  $dishes = array();
  while($row = $sql->fetch_assoc()){
    array_push($dishes, $row);
  }
  $result['dishes'] = $dishes;
}
if($action == 'get_similar_dishes'){
  $tag1 = $_POST['tag1'];
  $tag2 = $_POST['tag2'];
  $tag3 = $_POST['tag3'];
  $tag4 = $_POST['tag4'];
  $category = $_POST['category'];

  $sql = $conn->query("SELECT * FROM dishes WHERE category LIKE '%{$category}%' AND (dish_name LIKE '%{$tag1}%' OR dish_name LIKE '%{$tag2}%' OR dish_name LIKE '%{$tag3}%' OR dish_name LIKE '%{$tag4}%')");
  $dishes = array();
  while($row = $sql->fetch_assoc()){
    array_push($dishes, $row);
  }
  $result['dishes'] = $dishes;
}

if($action == 'add_dish'){
  $name = $_POST['dish_name'];
  $image = $_POST['image'];
  $prepTime = $_POST['preparation_time'];
  $rating = $_POST['rating'];
  $category = $_POST['category'];

  $sql = $conn->query("INSERT INTO dishes (dish_name, preparation_time, rating, image, category) VALUES('$name','$prepTime','$rating','$image', '$category')");
  
  if($sql){
    $added_id = $conn->insert_id;
    $result['added_id'] = $added_id;
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
  $category = $_POST['category'];

  $sql = $conn->query("UPDATE dishes SET dish_name='$name',preparation_time='$prepTime',rating='$rating',image='$image', category='$category' WHERE dish_id='$id'");

  if($sql){
    $result['message'] = "Dish updated successfully!";
  }
  else{
    $result['error'] = true;
    $result['message'] = "Failed to update dish!";
  }
}

if($action == 'delete_dish'){
  $id = $_POST['dish_id'];

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
  $sql = $conn->query("SELECT * FROM recipes_ingredients_view WHERE dish_id='$id' ORDER BY recipe_element_id");
  $dish_ingredients = array();
  while($row = $sql->fetch_assoc()){
    array_push($dish_ingredients, $row);
  }
  $result['dish'] = $dish;
  $result['dish_steps'] = $dish_steps;
  $result['dish_ingredients'] = $dish_ingredients;
}

if($action == 'get_dish_ingredients'){
  $id = $_POST['dish_id'];

  $sql = $conn->query("SELECT * FROM recipes_ingredients_view WHERE dish_id='$id' ORDER BY recipe_element_id");
  $dish_ingredients = array();
  while($row = $sql->fetch_assoc()){
    array_push($dish_ingredients, $row);
  }
  $result['dish_ingredients'] = $dish_ingredients;
}

if($action == 'update_step'){
  $id = $_POST['step_id'];
  $number = $_POST['step_number'];
  $instructions = $_POST['instructions'];

  $sql = $conn->query("UPDATE recipes_steps SET step_number='$number',instructions='$instructions' WHERE step_id='$id'");

  if($sql){
    $result['message'] = "Step updated successfully!";
  }
  else{
    $result['error'] = true;
    $result['message'] = "Failed to update step!";
  }
}

if($action == 'add_step'){
  $number = $_POST['step_number'];
  $instructions = $_POST['instructions'];
  $dishid = $_POST['dish_id'];

  $sql = $conn->query("INSERT INTO recipes_steps (step_number, instructions, dish_id) VALUES('$number','$instructions','$dishid')");

  if($sql){
    $result['message'] = "Step added successfully!";
  }
  else{
    $result['error'] = true;
    $result['message'] = "Failed to add step!";
  }
}

if($action == 'delete_step'){
  $id = $_POST['step_id'];

  $sql = $conn->query("DELETE FROM recipes_steps WHERE step_id='$id'");

  if($sql){
    $result['message'] = "Step deleted successfully!";
  }
  else{
    $result['error'] = true;
    $result['message'] = "Failed to delete step!";
  }
}

if($action == 'get_ingredients'){
  $sql = $conn->query("SELECT * FROM ingredients_view");
  $ingredients = array();
  while($row = $sql->fetch_assoc()){
    array_push($ingredients, $row);
  }
  $result['ingredients'] = $ingredients;
}

if($action == 'get_units'){
  $sql = $conn->query("SELECT * FROM unit");
  $units = array();
  while($row = $sql->fetch_assoc()){
    array_push($units, $row);
  }
  $result['units'] = $units;
}

if($action == 'update_ingredient'){
  $recipe_element_id = $_POST['recipe_element_id'];
  $ingredient_id = $_POST['ingredient_id'];
  $amount = $_POST['amount'];

  $sql = $conn->query("UPDATE recipes_ingredients SET ingredient_id='$ingredient_id', amount='$amount' WHERE recipe_element_id='$recipe_element_id'");

  if($sql){
    $result['message'] = "Ingredient updated successfully!";
  }
  else{
    $result['error'] = true;
    $result['message'] = "Failed to update ingredient!";
  }
}

if($action == 'add_ingredient'){
  $dish_id = $_POST['dish_id'];
  $ingredient_id = $_POST['ingredient_id'];
  $amount = $_POST['amount'];

  $sql = $conn->query("INSERT INTO recipes_ingredients (ingredient_id, amount, dish_id) VALUES('$ingredient_id','$amount','$dish_id')");

  if($sql){
    $result['message'] = "Ingredient added successfully!";
  }
  else{
    $result['error'] = true;
    $result['message'] = "Failed to add ingredient!";
  }
}

if($action == 'delete_ingredient'){
  $recipe_element_id = $_POST['recipe_element_id'];

  $sql = $conn->query("DELETE FROM recipes_ingredients WHERE recipe_element_id='$recipe_element_id'");

  if($sql){
    $result['message'] = $recipe_element_id;
  }
  else{
    $result['error'] = true;
    $result['message'] = "Failed to delete ingredient!";
  }
}

if($action == 'get_day'){
  $day = $_POST['day'];
  $month = $_POST['month'];
  $year = $_POST['year'];
  $index = $_POST['index'];

  $sql = $conn->query("SELECT * FROM date_dish_view WHERE day = '$day' AND month = '$month' AND year = '$year' AND meal_number = '$index'");
  $day = array();
  while($row = $sql->fetch_assoc()){
    array_push($day, $row);
  }
  $result['day'] = $day;
}

if($action == 'set_portions'){
  $day = $_POST['day'];
  $month = $_POST['month'];
  $year = $_POST['year'];
  $index = $_POST['index'];
  $portions = $_POST['portions'];

  $sql = $conn->query("UPDATE calendar SET portions='$portions' WHERE day = '$day' AND month = '$month' AND year = '$year' AND meal_number = '$index'");

  if($sql){
    $result['message'] = "Success!";
  }
  else{
    $result['error'] = true;
    $result['message'] = "Failed!";
  }
}


if($action == 'replace_day'){
  $day = $_POST['day'];
  $month = $_POST['month'];
  $year = $_POST['year'];
  $index = $_POST['index'];
  $dish_id = $_POST['dish_id'];
  $preparation_time = $_POST['preparation_time'];
  $rating = $_POST['rating'];
  $portions = $_POST['portions'];

  $sql = $conn->query("REPLACE INTO calendar (day, month, year, meal_number, dish_id, portions, preparation_time, rating ) VALUES ('$day','$month','$year','$index','$dish_id','$portions','$preparation_time','$rating')");

  if($sql){
    $result['message'] = "Day replaced successfully!";
  }
  else{
    $result['error'] = true;
    $result['message'] = "Failed to replace day!";
  }
}

if($action == 'delete_day'){
  $day = $_POST['day'];
  $month = $_POST['month'];
  $year = $_POST['year'];
  $index = $_POST['index'];

  $sql = $conn->query("DELETE FROM calendar WHERE day = '$day' AND month = '$month' AND year = '$year' AND meal_number = '$index'");

  if($sql){
    $result['message'] = "Day deleted successfully!";
  }
  else{
    $result['error'] = true;
    $result['message'] = "Failed to delete day!";
  }
}

if($action == 'update_global_ingredient'){
  $ingredient_id = $_POST['ingredient_id'];
  $ingredient_name = $_POST['ingredient_name'];
  $unit_id = $_POST['unit_id'];
  $kcal_per_unit = $_POST['kcal_per_unit'];

  $sql = $conn->query("UPDATE ingredients SET ingredient_name='$ingredient_name', unit_id='$unit_id', kcal_per_unit='$kcal_per_unit' WHERE ingredient_id='$ingredient_id'");

  if($sql){
    $result['message'] = "Ingredient updated successfully!";
  }
  else{
    $result['error'] = true;
    $result['message'] = "Failed to update ingredient!";
  }
}

if($action == 'add_global_ingredient'){
  $ingredient_name = $_POST['ingredient_name'];
  $unit_id = $_POST['unit_id'];
  $kcal_per_unit = $_POST['kcal_per_unit'];

  $sql = $conn->query("INSERT INTO ingredients (ingredient_name, unit_id, kcal_per_unit) VALUES ('$ingredient_name', '$unit_id', '$kcal_per_unit')");

  if($sql){
    $result['message'] = "Ingredient added successfully!";
  }
  else{
    $result['error'] = true;
    $result['message'] = "Failed to add ingredient!";
  }
}

if($action == 'delete_global_ingredient'){
  $ingredient_id = $_POST['ingredient_id'];

  $sql = $conn->query("DELETE FROM ingredients WHERE ingredient_id='$ingredient_id'");

  if($sql){
    $result['message'] = $ingredient_id;
  }
  else{
    $result['error'] = true;
    $result['message'] = "Failed to delete ingredient!";
  }
}

if($action == 'update_unit'){
  $unit_id = $_POST['unit_id'];
  $unit_name = $_POST['unit_name'];
  $shortcut = $_POST['shortcut'];

  $sql = $conn->query("UPDATE unit SET unit_name='$unit_name', shortcut='$shortcut' WHERE unit_id='$unit_id'");

  if($sql){
    $result['message'] = "Unit updated successfully!";
  }
  else{
    $result['error'] = true;
    $result['message'] = "Failed to update unit!";
  }
}

if($action == 'add_unit'){
  $unit_name = $_POST['unit_name'];
  $shortcut = $_POST['shortcut'];

  $sql = $conn->query("INSERT INTO unit (unit_name, shortcut) VALUES ('$unit_name','$shortcut')");

  if($sql){
    $result['message'] = "Unit added successfully!";
  }
  else{
    $result['error'] = true;
    $result['message'] = "Failed to add unit!";
  }
}

if($action == 'delete_unit'){
  $unit_id = $_POST['unit_id'];

  $sql = $conn->query("DELETE FROM unit WHERE unit_id='$unit_id'");

  if($sql){
    $result['message'] = $unit_id;
  }
  else{
    $result['error'] = true;
    $result['message'] = "Failed to delete unit!";
  }
}

$conn->close();
echo json_encode($result);
?>
