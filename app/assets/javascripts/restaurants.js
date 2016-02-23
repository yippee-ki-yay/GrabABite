
/*$(document).ready(function(){
  var addressPicker = new AddressPicker({
  autocompleteService: {
    types: ['(cities)'], 
    componentRestrictions: { country: 'US' }
  }
});

$('#address').typeahead(null, {
  displayKey: 'description',
  source: addressPicker.ttAdapter()
})
});*/

$(document).ready(function()
{
  $("#add_new_table").click(function()
  {
    
     $.ajax({
             method: "POST",
              url: "/restaurants/add_table",
              data: "number_seats="+ $("#table_seats").val()
                })
                  .done(function( msg ) 
                  {
                   
                  });
  });
  
  
   $("#add_item").click(function()
  {
    
     var name = $("#item_name").val();
     var desc = $("#item_desc").val();
     var price = $("#item_price").val();
     
     var isValid = true;
     
      if(name == "")
      {
        isValid = false;
        $("#item_name").closest(".form-group").addClass("has-error");
      }
     else
      $("#item_name").closest(".form-group").removeClass("has-error");
     
      if(desc == "")
      {
        isValid = false;
        $("#item_desc").closest(".form-group").addClass("has-error");
      }
     else
      $("#item_desc").closest(".form-group").removeClass("has-error");
     
      if(!$.isNumeric(price))
        {
          toastr.error("Price must be a number");
        }
     
      if(price == "")
      {
        isValid = false;
        $("#item_price").closest(".form-group").addClass("has-error");
      }
     else
      $("#item_price").closest(".form-group").removeClass("has-error");
     
     if(isValid)
     $.ajax({
             method: "POST",
              url: "/restaurants/add_item",
              data: {name: name, desc: desc, price: price}
                })
                  .done(function( msg ) 
                  {
                    
                    $('#item_table tr:last').after('<tr><td>'+$("#item_name").val()+'</td><td>'+$("#item_desc").val()+'</td><td>'+$("#item_price").val()+'</td></tr>');
       
                    $("#item_name").val("")
                    $("#item_desc").val("");
                    $("#item_price").val("");
                  });
  });
  
});


//loads table configuration
 $(document).ready(function()
{
    $.ajax({
             method: "POST",
              url: "/reservation/get_tables"
                })
                  .done(function( msg ) 
                  {
                    $.each(msg, function(k, v) {
                      if(v.row != null)
                        {
                          $("#"+v.row).text(v.capacity);
                          $("#"+v.row).css('background-color', 'greenyellow');
                          $("#"+v.row).removeClass("can_add");
                          // $("#"+v.row).removeClass("table_view");
                          //  $("#"+v.row).addClass("table_taken col-md-2");
                        }
                    });
                  });
 })


  $(document).on('click', '.can_add', function(){
    var box = $(this);
    
    bootbox.prompt("Enter number of seats", function(result) {                
        if(result != null && $.isNumeric(result))
          {
            box.text(result);
            box.css('background-color', 'greenyellow');
            
            $.ajax({
             method: "POST",
              url: "/restaurants/add_table",
              data: "number_seats="+ result +"&row=" + box.attr("id")
                })
                  .done(function( msg ) 
                  {
                   box.removeClass("can_add");
                  });
          }
     });
  });
