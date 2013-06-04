$(function() {

  // show nav
  $('div.container header#loginpage').addClass("shownav");
  $('div.container section.loginform').addClass("shownav");
  console.log('added the classes!')

  // when login clicked, collapse nav
  $("#login_button").click(function() {
    $('div.container header#loginpage').removeClass("shownav");
    $('div.container section.loginform').removeClass("shownav");
  });

});