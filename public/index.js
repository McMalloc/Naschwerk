$( document ).ready(function() {

  var fetched = {};

  $("#post-form").submit(function() {
    $("#post-loader").show();
    $("#save-post-btn").prop( "disabled", true );
    $("#cancel-post-btn").prop( "disabled", true );
  });

  $("#feedback-form").submit(function() {

    $("#send-feedback-btn").prop( "disabled", true );
  });


  var page = 0;

  $(window).scroll(function() {
    if($(window).scrollTop() + $(window).height() === $(document).height()) {
      httpGet("posts/page/" + page, function(data) {
        page++;
        $("main").append(data);
      })
    }
  });


  if (!!$.fn.DataTable) {
    $("table.table").DataTable({
      paging: false,
      columnDefs: [
        { "type": "date", "targets": 0 }
      ]
    });
  }

  $('#table-filter').on('keyup click', function () {
    filterGlobal();
  });

  function filterGlobal () {
    $('table.table').DataTable().search(
      $('#table-filter').val(), false, true
    ).draw();
  }

  function httpGet(theUrl, callback) {
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.onreadystatechange = function() {
      if (xmlHttp.readyState == 4 && xmlHttp.status == 200)
        callback(xmlHttp.responseText);
    }
    xmlHttp.open("GET", theUrl, true); // true for asynchronous
    xmlHttp.send(null);
  }

});

