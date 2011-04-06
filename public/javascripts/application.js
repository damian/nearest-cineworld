var spinner = '',
    loading_text = '',
    body = '',
    body_id = '';

$(function() {
  body = $('body');
  body_id = body.attr('id');

  if (body_id == 'cinemas-controller-search-action' && geo_position_js.init()) {
    spinner = $('#spinner'),
    loading_text = $('.loading');
    spinner.show();
    geo_position_js.getCurrentPosition(success, error);
  }
  
  if (body_id == 'cinemas-controller-show-action') {
    change_cinema();
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
      history.pushState({ path: window.location.path }, '', cinema_path);
      plot_map();
      change_cinema();
    }
  });

}

function change_cinema() {
  $('#change-location a').bind('click', function(e) {
    e.preventDefault();
    $(this).hide().next().fadeIn();
  });

  $('#cinema_cinema_id').bind('change', function(e) {
    $(this).parent().submit();
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

function error(err) {
  switch(err.code) {
    case err.PERMISSION_DENIED:
      alert("You gotsta share your location");
    break;

    case err.POSITION_UNAVAILABLE:
      alert("Hmmm, cant find your position");
    break;

    case err.TIMEOUT:
      alert("Timed out boyo");
    break;

    default:
      alert("Ok summit else is wrong");
    break;
  }

}

