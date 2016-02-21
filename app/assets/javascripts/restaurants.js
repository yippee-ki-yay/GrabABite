
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
