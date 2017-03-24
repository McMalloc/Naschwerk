$( document ).ready(function() {

  $("#post-form").submit(function(event) {

    $("#save-post-btn").prop( "disabled", true );
    $("#cancel-post-btn").prop( "disabled", true );
  })
});
