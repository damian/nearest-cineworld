$(function() {
  var date_switcher = $('#date-switcher').find('a');
  var date_content = date_switcher.map(function() {
    return $($(this).attr('href'));
  });

  var hidden = $('.hidden');

  date_switcher.bind('click', function(e) {
    e.preventDefault();
    var el = $(this);
    var hr = el.attr('href');
    if (el.hasClass('active')) { return; }

    date_switcher.removeClass('active');
    el.addClass('active');

    date_content.toggleClass('hidden');

  });

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(success, error);
  } else {
    alert('not supported');
  }

});

function success(position) {
  console.log(position);
  var lat = position.coords.latitude;
  var lng = position.coords.longitude;
}

function error(position) {
  alert('fail');
}

