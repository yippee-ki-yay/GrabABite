



  $(document).on("click", "#save_rating", function()
  {
    var rating = $('input[name=example]:checked', '#rating').val();
    var inv = $(this).attr("data-id");
    var isValid = true;
    
    if(rating == undefined)
      {
        toastr.error("Rate the visit")
        isValid = false;
      }
    
    if(isValid)
      $.ajax({
             method: "POST",
              url: "/reservation/rate_visit",
              data: {rating: rating, inv: inv, rest_id:$("#restaurant_id").attr("val") }
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
    var restaurant_id = $("#restaurant_id").attr("val");
    var hours = $( "#hours option:selected" ).text();
    var min = $( "#minutes option:selected" ).text();
    
    var isValid = true;
    
    if(d == "" || d == null)
    {
        $("#date").closest(".form-group").addClass("has-error");
       isValid = false;
    }
    
     if(duration == "" || duration == null)
    {
        $("#duration").closest(".form-group").addClass("has-error");
       isValid = false;
    }
    
    if((Math.floor($("#duration").val()) != $("#duration").val())|| ($.isNumeric($('#duration').val()) == false))
      {
         toastr.error('Duration must be a number of hours you visit to last')
         isValid = false;
      }
    
    if($("#duration").val() <= 0)
      {
        isValid = false;
        toastr.error("Must be a positive number");
      }
    
     if(hours == "" || hours == null)
    {
        $("#hours").closest(".form-group").addClass("has-error");
       toastr.error('You must enter the hour of your visit');
       isValid = false;
    }
    
     if(min == "" || min == null)
    {
        $("#minutes").closest(".form-group").addClass("has-error");
      toastr.error('You must enter the minutes of your visit')
       isValid = false;
    }

     if(isValid == true)
       {
          $.ajax({
             method: "POST",
              url: "/reservation/create",
              data: {date: d, duration: duration, restaurant: restaurant_id, hours: hours, min: min }
                })
                  .done(function( msg ) 
                  {
                   window.location.replace("/reservation/choose_table?id=" + msg);
     });
       }
    
  });


  $(document).on("click",".add_friend_visit", function()
  {
        var table_seats = $("#table_seats").text();
        var row = $(this).closest("tr");
        var emailRow = row.find("td:nth-child(1)");
        var firstname = row.find("td:nth-child(2)");
        var lastanme = row.find("td:nth-child(3)");
    
        var length = $("#friends_list li").length;
    
       if(length >= table_seats)
         {
           toastr.error("All the seats are taken");
         }
  else{
     $.ajax({
             method: "POST",
              url: "/reservation/invite_friend",
              data: {email: emailRow.text(), visit_id:$("#visit_id").attr("val") }
                })
                  .done(function( msg ) 
                  {
                   row.hide();
                    $("#friends_list").append("<li>" +firstname.text() + " " + lastanme.text() + "</li>")
     });}
  });