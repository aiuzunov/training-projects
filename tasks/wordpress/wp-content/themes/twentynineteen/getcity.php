<?php
    require_once ('databaseconnect.php');

    $q=$_REQUEST["term"]; 
    $sql="SELECT 'city' FROM 'markersAPI' WHERE city LIKE '%$q%'";
    $result = mysql_query($sql);

    $json=array();

    while($row = mysql_fetch_array($result)) {
      array_push($json, $row['city']);
    }

    echo json_encode($json);
?>
