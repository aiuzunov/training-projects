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