
$(document).ready(function() {
  // TODO: This should ask the user for their current location
  // and place the map there.
	var map = L.map('map').setView([39.97, -75.15], 12);

	L.tileLayer('https://{s}.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png', {
		maxZoom: 18,
		attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
			'<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
			'Imagery © <a href="http://mapbox.com">Mapbox</a>',
		id: 'examples.map-i86knfo3'
	}).addTo(map);

  $.getJSON("/properties.json", function(data) {
    data.forEach(function(property) {
      var lat   = parseFloat(property["property"]["latitude"]);
      var lng   = parseFloat(property["property"]["longitude"]);
      var price = property["property"]["price"];
      var add   = property["property"]["address"];
      L.marker([lat, lng]).addTo(map).bindPopup(price + "<br/>" + add);
    });
  });
});
