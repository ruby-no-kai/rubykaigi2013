(function(window) {
  function showMap() {
    var rubykaigi2013 = new google.maps.LatLng(35.620322756056446, 139.77647379040718);
    var center_position = new google.maps.LatLng(35.620322756056446, 139.77647379040718);
    var MY_MAPTYPE_ID = 'rubykaigi2013';

    var stylez = [
      {
        featureType: "all",
        elementType: "all",
        stylers: [
          { hue: "#abdbde" } ] },
    ];

    var mapOptions = {
      zoom: 17,
      center: center_position,
      mapTypeControlOptions: {
        mapTypeIds: [google.maps.MapTypeId.ROADMAP, MY_MAPTYPE_ID]
      },
      mapTypeId: MY_MAPTYPE_ID,
    };
    var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
    var styledMapOptions = {
    };

    var infowindow = new google.maps.InfoWindow();

    var marker = new google.maps.Marker({
      position: rubykaigi2013,
      map: map,
      icon: '/2013/forAttendeesMapPin.svg'
    });

    infowindow.open(map,marker);

    var jayzMapType = new google.maps.StyledMapType(stylez, styledMapOptions);
    map.mapTypes.set(MY_MAPTYPE_ID, jayzMapType);
  }
  window.showMap = showMap;
}(window));
