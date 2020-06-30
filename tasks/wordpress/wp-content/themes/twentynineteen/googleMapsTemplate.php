<?php /* Template Name: googleMapsTemplate */
get_header();
global $wp,$post,$wp_query;
?>

	<div id="primary" class="content-area">
		<main id="main" class="site-main">
		
		<?php
		if ( have_posts() ) {

			// Load posts loop.
			while ( have_posts() ) {
				the_post();
				get_template_part( 'template-parts/content/content' );
			}

			// Previous/next page navigation.
			twentynineteen_the_posts_navigation();

		} else {

			// If no content, include the "No posts found" template.
			get_template_part( 'template-parts/content/content', 'none' );

		}
		?>
		
<?php
require_once 'databaseconnect.php';
    
/*$jsondata = "https://browse.search.hereapi.com/v1/browse?at=47.094289,17.911956&categories=700-7010-0108,700-7000-0107&limit=100&apiKey=iSooBtsSDS2AuZFbXYjM7m66YCBWr75vl2EJJtKFwVA";
$jsonstring = file_get_contents($jsondata);
$phpdata = json_decode($jsonstring,true);
for($x = 0 ; $x<count($phpdata["items"]);$x++) {
$sql = "INSERT INTO markersAPI (name,lat,lng,address,type,phone,website,countryCode,countryName,state,city,district,street,postalCode,houseNumber,county,resultType,placeAPIId,distance) VALUES ('" . $phpdata["items"][$x]["title"] . "', '" . $phpdata["items"][$x]["position"]["lat"] . "', '" . $phpdata["items"][$x]["position"]["lng"] . "', '" . $phpdata["items"][$x]["address"]["label"] . "', '" . $phpdata["items"][$x]["categories"][0]["name"] . "', '" . $phpdata["items"][$x]["contacts"][0]["phone"][0]["value"] . "', '" . $phpdata["items"][$x]["contacts"][0]["www"][0]["value"] . "', '" . $phpdata["items"][$x]["address"]["countryCode"] . "', '" . $phpdata["items"][$x]["address"]["countryName"] . "', '" . $phpdata["items"][$x]["address"]["state"] . "', '" . $phpdata["items"][$x]["address"]["city"] . "', '" . $phpdata["items"][$x]["address"]["district"] . "', '" . $phpdata["items"][$x]["address"]["street"] . "', '" . $phpdata["items"][$x]["address"]["postalCode"] . "', '" . $phpdata["items"][$x]["address"]["houseNumber"] . "', '" . $phpdata["items"][$x]["address"]["county"] . "', '" . $phpdata["items"][$x]["resultType"] . "', '" . $phpdata["items"][$x]["id"] . "', '" . $phpdata["items"][$x]["distance"] . "')";

if ($conn->query($sql) === TRUE) {
} else {
#echo "Error: " . $sql . "<br>" . $conn->error;
}
}
*/
$sql = "SELECT id,lat,lng,name,address,city,countryName FROM markersAPI";
$result = $conn->query($sql);
$result2 = $conn->query($sql);

?>
<!DOCTYPE html">
<head>
<title> Google Map With Markers :) </title>
<style type="text/css">

#insertblock {
width:70%;
margin: 0 auto;
}
#mapCanvas {
    width: 70%;
    height: 500px;
    margin: auto;
}

</style>
<script src="https://maps.googleapis.com/maps/api/js?key=Hidden"></script>
 <script src="//code.jquery.com/jquery-1.10.2.js"></script>
 <script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
 <link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" />
 <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-3-typeahead/4.0.2/bootstrap3-typeahead.min.js"></script>  
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />  

</head>
 

<script>
var map
function initMap() {
   latLong = new google.maps.LatLng(47.0303105, 28.815481);
     map = new google.maps.Map(document.getElementById('mapCanvas'), {
         center: latLong,
         mapTypeId: google.maps.MapTypeId.ROADMAP,
         zoom: 14
     });
            map.markers = [];
            load_markers()
 }
 function load_markers(){
    var markers = [
        <?php if($result->num_rows >0){
            while($row = $result->fetch_assoc()){
                echo '["'.$row['name'].'", '.$row['lat'].', '.$row['lng'].', "'.$row['city'].'", "'.$row['countryName'].'"],';;
                }
        }
        ?>
    ];
                          
    
    var infoWindowContent = [
        <?php if($result2->num_rows > 0){
            while($row = $result2->fetch_assoc()){ ?>
                ['<div class="info_content">' +
                '<h3><?php echo $row['name']; ?></h3>' +
                '<p><?php echo $row['address']; ?></p>' +
                '<p>Lat: <?php echo $row['lat']; ?></p>' +
                '<p>Lng: <?php echo $row['lng']; ?></p>' +
                '<p>Country: <?php echo $row['countryName']; ?></p>' +
                '<p>City: <?php echo $row['city']; ?></p>' +
                 '</div>'],
        <?php }
        }
        ?>
    ];
    var bounds = new google.maps.LatLngBounds();
    var infoWindow = new google.maps.InfoWindow(), marker, i;

    for( i = 0; i < markers.length; i++ ) {
        var position = new google.maps.LatLng(markers[i][1], markers[i][2]);
        marker = new google.maps.Marker({
            position: position,
            map: map,
            title: markers[i][0],
            latitude: markers[i][1],
            longtitude: markers[i][2],
            city: markers[i][3],
            country: markers[i][4]
        });
   	marker.setMap(map);
   	map.markers.push(marker);
        bounds.extend(marker.position);

         google.maps.event.addListener(marker, 'click', (function(marker, i) {
            return function() {
                infoWindow.setContent(infoWindowContent[i][0]);
                infoWindow.open(map, marker);
            }
        })(marker, i));
        google.maps.event.addListener(marker, 'click', function() {
	map.panTo(this.getPosition());
	map.setZoom(15);
});  
      }
      

     map.fitBounds(bounds);

 }

function markerFilter(){
    	var bounds = new google.maps.LatLngBounds();
    	var cc = document.getElementById("cc").value.trim().split(", ");
    	if(document.getElementById("cc").value.trim().length!=0){
    		if (/[0-9!@#\/$%\^\&*\)\(+=._-]/.test(cc[0])||/[0-9!@#\$%\^\&*\)\(+=._-]+/.test(cc[1])){
    			alert("Invalid Input for City/Country! Use only alphabetical characters!");
    			return;
    		}
    	}
    	
    	if(cc.length==1){
    		var country=cc[0];
    		var city=0;
    	}
    	else if(cc.length==2){
    		var city=cc[0];
    		var country=cc[1];
    	}
    	//var city = city;
	//var country = country;
	var x1 = document.getElementById("cords1").value.trim();
	var x2 = document.getElementById("cords2").value.trim();
	var x3 = document.getElementById("cords3").value.trim();
	var x4 = document.getElementById("cords4").value.trim();
	if(isNaN(x1)||isNaN(x2)||isNaN(x3)||isNaN(x4)){
		alert("Please type only numbers in the coordinate fields");
		return;
	}
	if(x1>90||x1<-90||x2>90||x2<-90||x3>180||x3<-180||x4>180||x4<-180){
		alert("Invalid Coordinates Input");
		return;
	}
	var counter1=0,counter2=0,counter3=0,counter4=0,pointscounter=0;	 if(document.getElementById("cc").value.trim().length==0&&document.getElementById("cords1").value.trim().length==0&&document.getElementById("cords2").value.trim().length==0&&document.getElementById("cords3").value.trim().length==0&&document.getElementById("cords4").value.trim().length==0){	
	return;	 
	}
	

	
	if(document.getElementById("cords1").value.trim().length!=0&&document.getElementById("cords2").value.trim().length!=0&&document.getElementById("cords3").value.trim().length!=0&&document.getElementById("cords4").value.trim().length!=0){
	if(x1>x2||x3<x4){
		alert("Lower Left Point Latitude/Longtitude must be lower than Upper Right Point Latitude/Longtitude");
		return;
		}
	for( i=0;i<map.markers.length;i++){
		if(city!=0&&country!=0){
if(map.markers[i].latitude>=x1&&map.markers[i].latitude<=x2&&map.markers[i].longtitude<=x3&&map.markers[i].longtitude>=x4&&map.markers[i].country==country&&map.markers[i].city==city){
	counter4++;
	
}
		}
		else if(country!=0){
			if(map.markers[i].latitude>=x1&&map.markers[i].latitude<=x2&&map.markers[i].longtitude<=x3&&map.markers[i].longtitude>=x4&&map.markers[i].country==country){
	
	counter4++;
}
		}
		else if(city!=0){
	if(map.markers[i].latitude>=x1&&map.markers[i].latitude<=x2&&map.markers[i].longtitude<=x3&&map.markers[i].longtitude>=x4&&map.markers[i].city==city){
	
	counter4++;
}
		}
		else if(city==0&&country==0){
			if(map.markers[i].latitude>=x1&&map.markers[i].latitude<=x2&&map.markers[i].longtitude<=x3&&map.markers[i].longtitude>=x4){
	counter4++;
	
}
		}
	}
	if(counter4==0){
		alert("No matching locations were found in the database");
		return;
		}
} else if(document.getElementById("cords1").value.trim().length==0&&document.getElementById("cords2").value.trim().length==0&&document.getElementById("cords3").value.trim().length==0&&document.getElementById("cords4").value.trim().length==0){
	for( i=0;i<map.markers.length;i++){
		if(map.markers[i].country==country&&map.markers[i].city==city){
		counter3++;	
	}
	if(map.markers[i].country==country)
			counter1++;
	if(map.markers[i].city==city)
			counter2++;
	}
	if((counter3==0)&&city!=0&&country!=0){
	alert("The country and city combination was not found in the database");
	return;	
	}
	else if(counter1==0&&country!=0){
	alert("The country was not found in the database");
	return;
	}
	else if(counter2==0 && city!=0){
	alert("The city was not found in the database");
	return;
	}
	}
	else if(document.getElementById("cords1").value.trim().length==0||document.getElementById("cords2").value==0||document.getElementById("cords3").value.trim().length==0||document.getElementById("cords4").value.trim().length==0){
	alert("One or more of the coordinate boxes is left empty")
	return;
	}
	for( i=0;i<map.markers.length;i++){
	map.markers[i].setMap(null);
		if(country!=0&&city==0&&document.getElementById("cords1").value.trim().length!=0&&document.getElementById("cords2").value.trim().length!=0&&document.getElementById("cords3").value.trim().length!=0&&document.getElementById("cords4").value.trim().length!=0){	 if(map.markers[i].latitude>=x1&&map.markers[i].latitude<=x2&&map.markers[i].longtitude<=x3&&map.markers[i].longtitude>=x4&&map.markers[i].country==country){	
 	bounds.extend(map.markers[i].position);					  					
	map.markers[i].setMap(map);
	pointscounter++;
 	}
}
	else if(city!=0&&country!=0&&document.getElementById("cords1").value.trim().length!=0&&document.getElementById("cords2").value.trim().length!=0&&document.getElementById("cords3").value.trim().length!=0&&document.getElementById("cords4").value.trim().length!=0){	 if(map.markers[i].latitude>=x1&&map.markers[i].latitude<=x2&&map.markers[i].longtitude<=x3&&map.markers[i].longtitude>=x4&&map.markers[i].city==city&&map.markers[i].country==country){	
 	bounds.extend(map.markers[i].position);					  					
	map.markers[i].setMap(map);
	pointscounter++;
 	}
}
	else if(document.getElementById("cords1").value.trim().length!=0&&document.getElementById("cords2").value.trim().length!=0&&document.getElementById("cords3").value.trim().length!=0&&document.getElementById("cords4").value.trim().length!=0){		  			 if(map.markers[i].latitude>=x1&&map.markers[i].latitude<=x2&&map.markers[i].longtitude<=x3&&map.markers[i].longtitude>=x4){	
	bounds.extend(map.markers[i].position);					  					
	map.markers[i].setMap(map);
	pointscounter++;
	}		
	}
	else if(city!=0&&country!=0){
		if(map.markers[i].city==city&&map.markers[i].country==country){
			bounds.extend(map.markers[i].position);					  				 		map.markers[i].setMap(map);
			pointscounter++;
		}
	}
	else if(country!=0){
		if(map.markers[i].country==country){
			bounds.extend(map.markers[i].position);					  				 		map.markers[i].setMap(map);
			pointscounter++;
		}
	}
	else if(city!=0){
		if(map.markers[i].city==city){
			bounds.extend(map.markers[i].position);					  				 		map.markers[i].setMap(map);
			pointscounter++;
		}
	}
	}
	map.fitBounds(bounds);
 	document.getElementById("counter").innerHTML = pointscounter;
}
 google.maps.event.addDomListener(window, 'load', initMap);
 
 function clearInput(){
 	document.getElementById("cc").value = "";
	document.getElementById("cords1").value = "";
	document.getElementById("cords2").value = "";
	document.getElementById("cords3").value = "";
	document.getElementById("cords4").value = "";
 
 }
 
 </script>

<script>
$(document).ready(function(){
 
 $('#cc').typeahead({
  source: function(query, result)
  {
  var data = {
                        'action': 'cities_details',
                        'query': query
            }
   $.ajax({
    url:"<?= admin_url('admin-ajax.php'); ?>",
    method:"POST",
    data: data,
    dataType:"json",
    success:function(data)
    {
     result($.map(data, function(item){
      return item;
     }));
    }
   })
  }
 });
 
});
</script>


<body>
 <div id="insertblock">  
                <input type="text" name="country" id="cc" placeholder="Enter Country Name" /> 
                <div id="countryList"></div>  
                <input type="text" placeholder="Lower Left Point Latitude" id="cords1">
                <input type="text" placeholder="Lower Left Point Longtitude" id="cords4">
		<input type="text" placeholder="Upper Right Point Latitude" id="cords2">
		<input type="text" placeholder="Upper Right Point Longtitude" id="cords3">
		</br>
		<div>
		<label>Matching Points: </label>
		<p id="counter"></p>
		</div>
		<button type="button" onclick="markerFilter();">Filter</button>
		<button type="button" onclick="clearInput();">Clear Input</button>
		
		
           </div>  
           
           


<div id="mapContainer">
    <div id="mapCanvas"></div>
</div>


</body>
</html>

		</main><!-- .site-main -->
	</div><!-- .content-area -->

<?php
get_footer();
