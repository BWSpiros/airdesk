
// var map;

$(document).ready(function(){
  console.log("SHOULD WORK!")
  get_location()

  function get_location() {
    navigator.geolocation.getCurrentPosition(initialize);
  };

  function initialize(position) {
    console.log(position)
    map = L.mapbox.map("map-canvas", 'examples.map-y7l23tes').setView([position.coords.latitude, position.coords.longitude], 10);

    L.mapbox.markerLayer({
      type: 'User',
      geometry: {
        type: 'Point',
        coordinates: [position.coords.latitude, position.coords.longitude]
      },
      properties: {
        'marker-size': 'large',
        'marger-color': 'f00'
      }
    }).addTo(map)
  }
});

