$(function() {

  // show nav
  $('.container header').css('top') {
    // top: 0px;
  });

  $('#main').css({
    // top: 0px;
  });

  // when login clicked, collapse nav
  $( "#login_button" ).click({
    $('.container header').css({
      // top: -65px;
    });
    $('#main').css({
      // top: -55px;
    });
  });
});
