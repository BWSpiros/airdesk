
// var map;

$(document).ready(function(){
  console.log("SHOULD WORK!")
  get_location()

  function get_location() {
    navigator.geolocation.getCurrentPosition(initialize);
  };

  function initialize(position) {
    console.log(position)
    var map = L.mapbox.map("map-canvas", 'examples.map-y7l23tes').setView([position.coords.latitude, position.coords.longitude], 10);

    L.mapbox.markerLayer({
      type: 'Feature',
      geometry: {
        type: 'Point',
        coordinates: [position.coords.longitude, position.coords.latitude]
      },
      properties: {
        'marker-symbol': 'commercial',
        'marker-size': 'small',
        'marker-color': 'f00',
        title: "YOU!",
        description: "You are here, you asshole"
      }
    }).addTo(map)
  }
});

