$(function() {

  $('#date-switcher a').live('click', function(e) {
    e.preventDefault();
    var el = $(this);
    var hr = el.attr('href');
    if (el.hasClass('active')) { return; }
    var date_switcher = $('#date-switcher a');

    date_switcher.removeClass('active');
    el.addClass('active');

    var date_content = date_switcher.map(function() {
      return $($(this).attr('href'));
    }).toggleClass('hidden');

  });

  if (window.location.pathname == "/cinemas/search" && navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(success, error);
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
      content.append(msg);
      var cinema_path = content.find('h2').attr('datahref');
      history.pushState({ path: window.location.path }, '', cinema_path)
    }
  });

}

function error(position) {
  alert('fail');
}

