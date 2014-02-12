// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
jQuery(function($) {
  $('.board').each(function() {
    var $boardHeight = $(this).height();
    var _that = $(this);

    $(this).find('.rod').each(function() {
      $(this).height($boardHeight);
    });

  });
});
