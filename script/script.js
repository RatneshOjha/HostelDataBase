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
					$.each(data, function(i, item) {
			            var memberlist = "<li><a id='"+content+"member_"+item.id+"' href='#' data-transition='slide'><img src='images/no-image.jpeg'><h3>"+item.name+"</h3><p>"+item.company+", <span>"+item.department+"</span></p></a></li>";
						
						$("#hostelDetailUpdate").append(memberlist);
						$("#hostelDetail").append(memberlist);	
											
						
						 
						$("#deleteProfile").append("<li id='member_"+item.id+"'><img src='images/no-image.jpeg'><h3>"+item.name+"</h3><p>"+item.company+", <span>"+item.department+"</span></p><input type='checkbox' name='deleteProfie' class='deleteCheck' /></li>");	
						 
						 
						
						
						if(item.id == $id){
							$('#profName h1:first').html(item.name);
							$('#profName p:first').html(item.company).append(", <span>"+item.department+"</span>");
							$('#parmanentAddr').html(item.parmanentAddr);
							$('#birthdate').html(item.dob);
							$('#companyAddr').html(item.companyAddr);
							$('#joinDate').html(item.hjd);
							$('#emailId').html(item.emailId);
							$('#phoneNo').html(item.phoneNo);
							$('#alterNo').html(item.alterNo);
							$('#panNo').html(item.panNo);
							
							$('#profName').attr("value",item.name);
							$('#parmanentAddr').attr("value",item.parmanentAddr);
							$('#birthdate').attr("value",item.dob);
							$('#companyAddr').attr("value",item.companyAddr);
							$('#joinDate').attr("value",item.hjd);
							$('#emailId').attr("value",item.emailId);
							$('#phoneNo').attr("value",item.phoneNo);
							$('#alterNo').attr("value",item.alterNo);
							$('#panNo').attr("value",item.panNo);
							$('#companyName').attr("value",item.company);
							$('#department').attr("value",item.department);
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
		
		function backToHome(){
			$.mobile.changePage('index.html');
			readJSON("info");	
		}
		
});