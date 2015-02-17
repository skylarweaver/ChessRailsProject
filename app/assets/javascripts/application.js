// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery_nested_form
//= require jquery-ui/datepicker
//= require foundation
//= require turbolinks
//= require_tree .
//= require underscore
//= require gmaps/google
//= require underscore
//= require foundation-datetimepicker
//= require jquery-ui/datepicker



$(function(){ $(document).foundation(); });


// Datepicker code
$(function() {
  $(".datepicker").datepicker({
    format: 'mm/dd/YYYY'
  });
});

// $(window).bind("load", function () {
//   var footer = $("#footer");
//   var pos = footer.position();
//   var height = $(window).height();
//   height = height - pos.top;
//   height = height - footer.height();
//   if (height > 0) {
//       footer.css({
//           'margin-top': height + 'px'
//       });
//   }
// });