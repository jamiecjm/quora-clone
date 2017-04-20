$(document).ready(function(){
	$("#edit_profile").click(function(){
		$(this).remove()
		$(".profile_page form").append("<input type=\"submit\" id=\"edit_profile\" value=\"Update\">")
		$(".profile_page input").removeAttr('disabled')
	}) 

	$(".vote_button a").click(function(e){
		// e.preventDefault()
		// $.ajax({
		// 	url: '/qupvote/:id',
		// 	method: "get",

		// 	success: function(){
		// 		switch ($(this).html()){
		// 			debugger
		// 			case "Vote":
		// 				$(this).html("Voted")
		// 				count = parseInt($(this).next().html())+1
		// 				$(this).next().html(count)
		// 				break;
		// 			case "Voted":
		// 				$(this).html("Vote")
		// 				count = parseInt($(this).next().html())-1
		// 				$(this).next().html(count)
		// 				break;
		// 		} //end of switch
		// 	}//end of success
		// })//end of ajax
		
	})

})
