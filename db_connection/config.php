<?php
$host= "localhost";
$user= "root";
$password = "";
$dbname = "food_tracker";

$conn = new mysqli($host,$user,$password,$dbname);
$conn->query("SET NAMES 'utf8'");

if($conn->connect_error){
    die("Connection failed: " .$conn->connect_error);
}
?>