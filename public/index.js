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


  var page = 1;

  var isFetching = false;
  $(window).scroll(function() {
    if (($(window).scrollTop() + $(window).height() >= $(document).height()-100) && (!isFetching)) {
      isFetching = true;
      $("#scroll-loader").show();
      httpGet("posts/page/" + page, function(data) {
        $("main").append(data);
        $("#scroll-loader").hide();
        isFetching = false;
      });
      page++;
    }
  });


  if (!!$.fn.DataTable) {
    $("table.table").DataTable({
      paging: false,
      order: [[ 0, "desc" ]],
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
    };
    xmlHttp.open("GET", theUrl, true); // true for asynchronous
    xmlHttp.send(null);
  }

});

