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
  var biteMatchTab = $('#tab-1');
  var addedByYouTab = $('#tab-2');
  var searchTab = $('#tab-3');
  
  addedByYouTab.click(function() {
    addedByYouTab.addClass('active')
    biteMatchTab.removeClass('active')
    searchTab.removeClass('active')
    $('div.tab').removeClass('search-tab')
    $.get('/panel/user_added', function(data) {
      $('div.tab').html(data);
    });
  });
  
  searchTab.click(function() {
    searchTab.addClass('active')
    biteMatchTab.removeClass('active')
    addedByYouTab.removeClass('active')
    $('div.tab').addClass('search-tab')
    $.get('/panel/search', function(data) {
      $('div.tab').html(data);
    });
    
  });
  
  biteMatchTab.click(function() {
    biteMatchTab.addClass('active')
    addedByYouTab.removeClass('active')
    searchTab.removeClass('active')
    $('div.tab').removeClass('search-tab')
    $.get('/panel/bite_match', function(data) {
      $('div.tab').html(data);
    }); 
  });
  
  $('.search-tab #search-submit').click(function(e) {
    e.preventDefault();
    $.get('/products', {
      allergies: {'milk' : Number($('#allergies_milk').is(":checked")),
                  'eggs' : Number($('#allergies_eggs').is(":checked")), 
                  'peanuts' : Number($('#allergies_peanuts').is(":checked")), 
                  'tree_nuts' : Number($('#allergies_tree_nuts').is(":checked")), 
                  'fish' : Number($('#allergies_fish').is(":checked")), 
                  'shellfish' : Number($('#allergies_shellfish').is(":checked")), 
                  'soy' : Number($('#allergies_soy').is(":checked")), 
                  'wheat' : Number($('#allergies_wheat').is(":checked"))}
    }, function(data) {
      $('div.tab').html($(data).find('div.row-fluid'));
    });
  });
});