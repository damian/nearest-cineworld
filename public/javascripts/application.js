var spinner = '',
    loading_text = '',
    body = '',
    body_id = '';

$(function() {
  body = $('body');
  body_id = body.attr('id');

  if (body_id == 'cinemas-controller-search-action' && Modernizr.geolocation) {
    spinner = $('#spinner'),
    loading_text = $('.loading');
    spinner.show();
    navigator.geolocation.getCurrentPosition(success, error);
  } else if (body_id == 'cinemas-controller-show-action') {
    plot_map();
  }

});

function success(position) {
  var lat = position.coords.latitude;
  var lng = position.coords.longitude;
  var content = $('#content');

  $.ajax({
    type: 'get',
    url: '/cinemas/search',
    data: 'lat=' + lat + '&lng=' + lng,
    success: function(msg) {
      spinner.hide();
      content.append(msg);
      var cinema_header = $('#cinema-address', content).find('h2');
      var cinema_path = cinema_header.attr('data-href');
      var cinema_name = cinema_header.text();
      loading_text.hide();
      if (Modernizr.history) {
        history.pushState({ path: window.location.path }, '', cinema_path);
      }
      plot_map();
    }
  });

}

function plot_map() {
  var h = $('#cinema-address h2');
  var lat = h.attr('data-latitude'),
      lng = h.attr('data-longitude'),
      m = $('#map');
  var latlng = new google.maps.LatLng(lat, lng);
  var myOptions = {
    zoom: 12,
    center: latlng,
    mapTypeControl: false,
    navigationControlOptions: { style: google.maps.NavigationControlStyle.SMALL },
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    scrollwheel: false
  };
  var map = new google.maps.Map(m[0], myOptions);

  var marker = new google.maps.Marker({
    position: latlng,
    map: map,
    title:"You are here!"
  });
}

function error(position) {
  alert('fail');
}

