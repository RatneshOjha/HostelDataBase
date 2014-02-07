$(document).ready(function(){
		var JSONurl = "data/data.json";
		var $id;
		
		function readJSON(content){
			$.ajax({
				url: JSONurl,
				dataType: "json",	
				beforeSend: function() { $.mobile.showPageLoadingMsg(); }, //Show spinner
           		complete: function() { $.mobile.hidePageLoadingMsg(); }, // hide spinner
				success: function(data){
					$("#hostelDetailUpdate").empty();
					$("#hostelDetail").empty();	
					$("#deleteProfile").empty();
					$.each(data.hostelmember, function(i, item) {
			            var memberlist = "<li><a id='"+content+"member_"+data.hostelmember[i].id+"' href='#' data-transition='slide'><img src='images/no-image.jpeg'><h3>"+data.hostelmember[i].name+"</h3><p>"+data.hostelmember[i].company+", <span>"+data.hostelmember[i].department+"</span></p></a></li>";
						
						$("#hostelDetailUpdate").append(memberlist);
						$("#hostelDetail").append(memberlist);	
											
						
						 
						$("#deleteProfile").append("<li id='member_"+data.hostelmember[i].id+"'><img src='images/no-image.jpeg'><h3>"+data.hostelmember[i].name+"</h3><p>"+data.hostelmember[i].company+", <span>"+data.hostelmember[i].department+"</span></p><input type='checkbox' name='deleteProfie' class='deleteCheck' /></li>");	
						 
						 
						
						
						if(data.hostelmember[i].id == $id){
							$('#profName h1:first').html(data.hostelmember[i].name);
							$('#profName p:first').html(data.hostelmember[i].company).append(", <span>"+data.hostelmember[i].department+"</span>");
							$('#parmanentAddr').html(data.hostelmember[i].parmanentAddr);
							$('#birthdate').html(data.hostelmember[i].dob);
							$('#companyAddr').html(data.hostelmember[i].companyAddr);
							$('#joinDate').html(data.hostelmember[i].hjd);
							$('#emailId').html(data.hostelmember[i].emailId);
							$('#phoneNo').html(data.hostelmember[i].phoneNo);
							$('#alterNo').html(data.hostelmember[i].alterNo);
							$('#panNo').html(data.hostelmember[i].panNo);
							
							$('#profName').attr("value",data.hostelmember[i].name);
							$('#parmanentAddr').attr("value",data.hostelmember[i].parmanentAddr);
							$('#birthdate').attr("value",data.hostelmember[i].dob);
							$('#companyAddr').attr("value",data.hostelmember[i].companyAddr);
							$('#joinDate').attr("value",data.hostelmember[i].hjd);
							$('#emailId').attr("value",data.hostelmember[i].emailId);
							$('#phoneNo').attr("value",data.hostelmember[i].phoneNo);
							$('#alterNo').attr("value",data.hostelmember[i].alterNo);
							$('#panNo').attr("value",data.hostelmember[i].panNo);
							$('#companyName').attr("value",data.hostelmember[i].company);
							$('#department').attr("value",data.hostelmember[i].department);
							$('#newMemberInfo .ui-header').find('h1.ui-title').text("Update Profile");
							$('#depoAmount').parent().parent().hide();
							$('#depoAmount').parent().parent().prev().hide();
						}					
						
						
					});
					$('#hostelDetail').listview('refresh');
					$('#hostelDetailUpdate').listview('refresh');
					$('#deleteProfile').listview('refresh');
					$id=0;
				}
			});
		}
		
		readJSON('info');
		
		$("a.ui-link-inherit").live("click", function(){
			var $target = $(this).attr('id');
			var $array = $(this).attr('id').split( '_' );
			$id = $array[1];
			if($target.indexOf('info')){
				$.mobile.changePage('newupdateProfile.html');
				
			}else{
				$.mobile.changePage('memberProfile.html');
			}
		});
		
		$('#save').click(function() {
 			 $('form').submit();
		});
		
		$('form').submit(function() {
		  var val = $(this).serializeArray();
		  
		  $.each(val, function(i, item){
			console.log('Data ' + item.value);				   
		  });
		  console.log(val);
		  
		  return false;
		});
				
		$("#cancel").live("click", function(){
			backToHome();
		});
		
		$('#new').live('click',function(){
        	$.mobile.changePage('newupdateProfile.html');	
   		});	
		
		$('#update').live('click',function(){
        	$.mobile.changePage('updateProfile.html');	
   		});	
		
		$("#delete").live('click', function(){
			$.mobile.changePage('deleteProfile.html');	
		});
		
		$('#back').live("click",function(){
        	backToHome();
   		});
		
		function backToHome(){
			$.mobile.changePage('index.html');
			readJSON("info");	
		}
		
		$("input[name='deleteProfie']").live("click", function(){
				var count = $("input[name='deleteProfie']:checked" ).length;												
				if(count == 0){
					$("#deleteBttn").hide();
				}else{
					$("#deleteBttn").show();
				}
		});
		
		$("#deleteBttn").live("click", function(){
			$("input[name='deleteProfie']:checked" ).each(function(){
				$(this).closest('li').remove();
			});		
			$("#deleteBttn").hide();
		});
		
		$('#memberInfo').live('pageshow',function(){
        	readJSON();			
   		});	
		
		$('#newMemberInfo').live('pageshow',function(){
        	readJSON();
		});	
		
		$('#updatedProfile').live('pageshow',function(){
        	readJSON("update");			
   		});	
		
		$('#deleteInfo').live('pageshow',function(){
			$( document ).bind( 'mobileinit', function(){
			  $.mobile.loader.prototype.options.text = "loading";
			  $.mobile.loader.prototype.options.textVisible = true;
			  $.mobile.loader.prototype.options.theme = "a";
			  $.mobile.loader.prototype.options.html = "";
			});									  
			readJSON();			
   		});	
		
			
});