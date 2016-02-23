 //dump new friend
        $(document).on('click', '.dump_friend', function(){
              
             var row = $(this).closest("tr");
             var emailRow = row.find("td:nth-child(1)"); 
             var firstname = row.find("td:nth-child(2)");
           var lastname = row.find("td:nth-child(3)"); 
             
            $.ajax({
                  method: "POST",
                  url: "/home/dump_friend",
                  data: "email="+ emailRow.text()
                })
                  .done(function( msg ) 
                  {
                    if(msg == true)
                    {
                         row.hide();
                        $('#user_table_id tr:last').after(" <tr class='success'>"+
            '<td>'+emailRow.text()+'</td>'+
            '<td>'+firstname.text()+'</td>'+
            '<td>'+lastname.text()+'</td>'+
            "<td><button class='btn btn-success add_friend'>Add friend</button></tr>");
                 
                    }
                  });
            
        });
        
        //add your friend
         $(document).on('click', '.add_friend', function(){
              
             var row = $(this).closest("tr");
             var emailRow = row.find("td:nth-child(1)"); 
           var firstname = row.find("td:nth-child(2)");
           var lastname = row.find("td:nth-child(3)"); 
             
            $.ajax({
                  method: "POST",
                  url: "/home/add_friend",
                  data: "email="+ emailRow.text()
                })
                  .done(function( msg ) {
                    row.hide();
                    $('#friends_table_id tr:last')
                        .after(" <tr class='info'>"+
            '<td>'+emailRow.text()+'</td>'+
            '<td>'+firstname.text()+'</td>'+
            '<td>'+lastname.text()+'</td>'+
            "<td><button class='btn btn-danger dump_friend'>Dump</button></td></tr>");
              
              window.location.reload();
              
                  });
            
        });

        //accept invite
        $(document).on('click', '.accept_invite', function()
        {
             $.ajax({
                  method: "POST",
                  url: "/home/accept_invite",
                  data: "invite="+ $(this).attr("data-id")
                })
                  .done(function( msg ) {
                    location.reload();
             });
        });

        //decline invite
        $(document).on('click', '.decline_invite', function(){
             $.ajax({
                  method: "POST",
                  url: "/home/decline_invite",
                  data: "invite="+ $(this).attr("data-id")
                })
                  .done(function( msg ) {
                    location.reload();
             });
        });


    