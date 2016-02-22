$(function(){ //DOM Ready

    $(".gridster ul").gridster({
        widget_margins: [10, 10],
        widget_base_dimensions: [140, 140]
    }).data('gridster');

});


  $(document).on("click", "#save_rating", function()
  {
    var rating = $('input[name=example]:checked', '#rating').val();
    var inv = $(this).attr("data-id");
      $.ajax({
             method: "POST",
              url: "/reservation/rate_visit",
              data: {rating: rating, inv: inv }
                })
                  .done(function( msg ) 
                  {
                   window.location.replace("/home/visits");
     });
    
  });


  $(document).on("click","#add_visit", function()
  {
    var d = $("#date").val();
    var duration = $("#duration").val();
    var table_id = $("#table_id").val();
    var restaurant_id = $("#restaurant_id").attr("val");

     $.ajax({
             method: "POST",
              url: "/reservation/create",
              data: {date: d, duration: duration, table: table_id, restaurant: restaurant_id }
                })
                  .done(function( msg ) 
                  {
                   window.location.replace("/reservation/friends_to_visit?id=" + msg);
     });
  });


  $(document).on("click",".add_friend_visit", function()
  {

        var row = $(this).closest("tr");
             var emailRow = row.find("td:nth-child(1)");
        var firstname = row.find("td:nth-child(2)");
        var lastanme = row.find("td:nth-child(3)");
     $.ajax({
             method: "POST",
              url: "/reservation/invite_friend",
              data: {email: emailRow.text(), visit_id:$("#visit_id").attr("val") }
                })
                  .done(function( msg ) 
                  {
                   row.hide();
                    $("#user_list").after("<li>" +firstname.text() + " " + lastanme.text() + "</li>")
     });
  });