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
include 'maincode.html';
?>


		</main><!-- .site-main -->
	</div><!-- .content-area -->

<?php
get_footer();
