$(function(){ 
  $('#notice-close').click(function() {
    $('#notice').slideUp('slow', function() {
    // Animation complete.
    });
  });
});