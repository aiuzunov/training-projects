<?php

$servername = "localhost";
$username = "wordpress";
$password = "1234";
$dbname = "wordpress";

$conn = new mysqli($servername,$username,$password,$dbname);

if ($conn->connect_error) {
    die("Connection failed:" . $conn->connect_error);
}
