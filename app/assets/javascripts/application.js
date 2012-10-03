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
//= require bootstrap
//= require_tree .
//= require bootstrap-transition.js
//= require bootstrap-carousel.js

$(document).ready(function() {
  $('.carousel').carousel( {
		interval: 10000
	});
});


$(document).ready( function() {
  var biteMatch = $('#tab-1');
  var addedByYou = $('#tab-2');
  var search = $('#tab-3');
  
  // var tabs = [biteMatch, addedByYou, search];
    
  // for (i = 0; i < 3; i++) {
  //   tabs[i].click(function() {
  //       tabs[0].removeClass('active');
  //       tabs[1].removeClass('active');
  //       tabs[2].removeClass('active');
  //       tabs[i].addClass('active');
  //   });
  // }

  addedByYou.click(function() {
    addedByYou.addClass('active')
    biteMatch.removeClass('active')
    search.removeClass('active')
    $.get('/panel/user_added', function(data) {
      $('div.tab').html(data);
    });
  });
  
  search.click(function() {
    search.addClass('active')
    biteMatch.removeClass('active')
    addedByYou.removeClass('active')
    $.get('/panel/search', function(data) {
      $('div.tab').html(data);
    });
  });
  
  biteMatch.click(function() {
    biteMatch.addClass('active')
    addedByYou.removeClass('active')
    search.removeClass('active')
    $.get('/panel/bite_match', function(data) {
      $('div.tab').html(data);
    }); 
  }); 
  
});