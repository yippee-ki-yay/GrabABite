
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
    
    var date = $("#");
    var duration = $("#");
    var table_id = $("#");
    var restaurant_id = $("#");
    
     $.ajax({
             method: "POST",
              url: "/restaurants/add_table",
              data: "number_seats="+ $("#table_seats").val()
                })
                  .done(function( msg ) 
                  {
                   
                  });
  });
});
