// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery_ujs
//= require bootstrap-twipsy
//= require bootstrap-popover
//= require bootstrap-alerts
//= require_tree .

$(document).ready(function() {
  $(".delete-all-btn").live('ajax:success', function(data, status, xhr){
    deleteAllHistory();
    $("#delete-all-confirm").modal('hide');
  });

  $(".delete-all-btn").live('ajax:error', function(xhr, status, error){
    alert("Oops. Something went wrong when trying to clear history.");
  });

});

function deleteUnfriendEntry(id) {
  $('#deletion_' + id).fadeOut(500, function() { $('#deletion_' + id).remove(); });

  var currentDeletions = $("#numOfDeletions").html();
  $("#numOfDeletions").html(currentDeletions - 1);
}

function deleteAllHistory() {
  $('#deletedFriendsSorted').fadeOut(500, function() { $('#deletedFriendsSorted').remove(); });
  var currentDeletions = $("#numOfDeletions").html();
  $("#numOfDeletions").html("0");
  $("#clear_history").html("History cleared.");
}


