$(function () {
  var map = L.map('availability_map').setView([39.984, -0.044], 13);

  var CartoDB_PositronNoLabels = L.tileLayer('https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_nolabels/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> &copy; <a href="http://cartodb.com/attributions">CartoDB</a>',
    subdomains: 'abcd',
    maxZoom: 19
  }).addTo(map);



  // ---> Station Markers
  var bikeIcon = L.Icon.Default;

  var stations = $('#availability_map').data('stations');
  var station_markers = [];

  var favorites = $('#availability_map').data('favorites');
  var favorite_marker_options = {
    radius: 5,
    color: 'orange',
    fillOpacity: 0
  };

  $.each(stations, function (index, station) {
    if ($.inArray(station.id, favorites) > -1) {
      L.marker([station.y, station.x], favorite_marker_options).addTo(map);
    }

    var marker_options = {
      radius: station.total * 2,
      color: availability_color(station.bikes_available),
      fillColor: availability_color(station.anchors_available)
    };

    var marker = L.circle([station.y, station.x], marker_options).addTo(map);

    marker.bindPopup(`<b><a href='/stations/${station.id}'>${station.name}</a></b>
      <br/>Bikes available: ${station.bikes_available} out of ${station.total}
      <br/>Anchors available: ${station.anchors_available} out of ${station.total}`);

    station_markers.push(marker);
  });



  // ---> "You clicked here" alert
  function onMapClick(e) {
    // console.log("You clicked the map at " + e.latlng);
    // console.log(e);
  };

  map.on('click', onMapClick);



  // ---> Geolocation marker
  map.locate({setView: true, maxZoom: 16});

  function onLocationFound(e) {
    // Accuracy radius indicator
    var radius = e.accuracy / 2;
    L.circle(e.latlng, {radius: radius, stroke: false}).addTo(map);

    // Actual location marker
    var location_marker_options = {
      radius: 6,
      color: 'white',
      fillColor: '#3388ff',
      fillOpacity: 1,
      weight: 2
    }
    L.circleMarker(e.latlng, location_marker_options).addTo(map)
      .bindPopup("You are within " + radius + " meters from this point").openPopup();
  }
  map.on('locationfound', onLocationFound);

  function onLocationError(e) {
    console.log(e.message);
  }
  map.on('locationerror', onLocationError);
});

function availability_color(count) {
  if (count > 3) {
    return 'green';
  } else if (count > 0) {
    return 'orange';
  } else {
    return 'red';
  }
}
