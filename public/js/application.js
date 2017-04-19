$(document).ready(function(){
	$("#edit_profile").click(function(){
		$(this).remove()
		$(".profile_page form").append("<input type=\"submit\" id=\"edit_profile\" value=\"Update\">")
		$(".profile_page input").removeAttr('disabled')
	}) 
})
