/**
 * 
 */

function userCreated(){
	Lobibox.alert("success",{
		msg : 'User Added Successfully And Details Has Been Sent To Your Registered Email Address.',
		beforeClose: function(lobibox){
        	if(parent.$.fancybox){
        		location.href = "/ResourcePlan/pages/login/login.jsp";
        	}
        }
	});
}