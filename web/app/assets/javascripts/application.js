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
//= require bootstrap.min
//= require bootstrap-tooltip
//= require bootstrap-tab
//= require bootstrap-carousel

$(function() {
  $(".tooltipped").tooltip({"placement": "bottom"});
});

var refreshMini = function(model, id) {
  $this = $("#" + model + "-" + id);
  $this.load("/" + model + "s/" + id + "/mini");
  // TODO (remove comment) this is to stop image flickering once app is finished
  // TODO stop this one tick sooner (still refreshes once when unnecessary)
  if ($this.find(".active").length > 0) setTimeout("refreshMini(\"" + model + "\", " + id + ")", 5000);
};

var hideMini = function(model, id) {
  $("#" + model + "-" + id).fadeOut("slow");
}

$('.carousel').carousel();
