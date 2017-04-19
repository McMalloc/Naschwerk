$( document ).ready(function() {

  var fetched = {};

  $("#post-form").submit(function() {

    $("#save-post-btn").prop( "disabled", true );
    $("#cancel-post-btn").prop( "disabled", true );
  });

  $("#feedback-form").submit(function() {

    $("#send-feedback-btn").prop( "disabled", true );
  });

  $(".comment-expander").click(function() {
    var postId = this.dataset.id;
    if (fetched[postId]) return;
    fetched[postId] = true;
    $.get({
      url: "/comments/" + postId,
      success: function(res) {
        $("#comments-" + postId + " .comments").append(res);
      }
    })
  });

  $(".comment-text-area").bind('input propertychange', function() {
    var postId = this.dataset.id;
    if (this.value.length>1) {
      $("#comments-" + postId + " input[type='submit']").prop("disabled", false);
    } else {
      $("#comments-" + postId + " input[type='submit']").prop("disabled", true);
    }
  });

  $(".comment-form").submit(function(event) {
    event.preventDefault();
    $.ajax({
      url: "/comments",
      method: "POST",
      data: $( this ).serialize(),
      success: function(res) {
        console.log(res);
      }
    });
  });

});

