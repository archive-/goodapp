// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery_ui
//= require autocomplete-rails
//= require bootstrap.min

$(function() {
  $('.tooltipped').tooltip();
  $('.tooltipped-bottom').tooltip({'placement': 'bottom'});

  var $fixy = $('.fixy'),
      fixyTop = $('.fixy').length && $('.fixy').offset().top - 45,
      isFixed = 0;
  $(document).scroll(function() {
    var scrollTop = $(this).scrollTop();
    if (scrollTop >= fixyTop && !isFixed) {
      isFixed = 1;
      $fixy.addClass('scrolled');
    } else if (scrollTop <= fixyTop && isFixed) {
      isFixed = 0;
      $fixy.removeClass('scrolled');
    }
  });
});

$('#home-carousel').carousel();
