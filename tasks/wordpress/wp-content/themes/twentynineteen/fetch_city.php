<?php
$servername = "localhost";
$username = "wordpress";
$password = "1234";
$connname = "wordpress";

$conn = new mysqli($servername,$username,$password,$connname);

if ($conn->connect_error) {
    die("Connection failed:" . $conn->connect_error);
}
 
// Get search term 
$searchTerm = $_GET['term']; 
 
// Fetch matched data from the database 
$query = $conn->query("SELECT * FROM markersAPI WHERE countryName LIKE '%".$searchTerm."%' AND status = 1 ORDER BY countryName ASC"); 
 
// Generate array with skills data 
$skillData = array(); 
if($query->num_rows > 0){ 
    while($row = $query->fetch_assoc()){ 
        $data['id'] = $row['id']; 
        $data['value'] = $row['countryName']; 
        array_push($skillData, $data); 
    } 
} 
 
// Return results as json encoded array 
echo json_encode($skillData); 
?>
