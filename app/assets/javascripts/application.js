// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery-ui
//= require popper
//= require bootstrap-sprockets
//= require chosen-jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require lazyload
//= require scaffold
//= require clipboard
//= require_tree .

$(document).ready(function(){

  console.log("Document ready!")

  var clipboard = new Clipboard('.clipboard-btn');
  console.log(clipboard);

  // Tooltip

$('.clipboard-btn').tooltip({
  trigger: 'click',
  placement: 'bottom'
});

function setTooltip(btn, message) {
  $(btn).tooltip('show')
    .attr('data-original-title', message)
    .tooltip('show');
}

function hideTooltip(btn) {
  setTimeout(function() {
    $(btn).tooltip('hide');
  }, 1000);
}

clipboard.on('success', function(e) {
  setTooltip(e.trigger, 'Kopiert!');
  hideTooltip(e.trigger);
});

clipboard.on('error', function(e) {
  setTooltip(e.trigger, 'Failed!');
  hideTooltip(e.trigger);
});

});
