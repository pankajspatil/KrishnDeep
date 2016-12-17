( function( $ ) {
$( document ).ready(function() {
$('#cssmenu').prepend('<div id="menu-button">Menu</div>');
	$('#cssmenu #menu-button').on('click', function(){
		var menu = $(this).next('ul');
		if (menu.hasClass('open')) {
			menu.removeClass('open');
		}
		else {
			menu.addClass('open');
		}
	});
});
} )( jQuery );

function logout(){
	
	/*if(confirm("Do you really want to logout?") == true){
		location.href = '/ResourcePlan/pages/login/logout.jsp';
	}*/
	
	var lobibox = Lobibox.confirm({
		msg: "Do you want to logout?",
		callback: function ($this, type) {
            if (type === 'yes') {
            	
            	var contextPath = document.getElementById("contextPath").value; 
            	location.href =contextPath + '/pages/login/logout.jsp';
            }
        }
		});
}
