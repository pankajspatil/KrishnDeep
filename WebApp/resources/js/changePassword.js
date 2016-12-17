/**
 * 
 */

if($('#changePasswordbutton') && $('#changePasswordbutton').length > 0){
	$('#changePasswordbutton').click(function(){
		var paramMap = new Map();
		if($('#currentPassword') && $('#currentPassword').val() == ''){
			paramMap.put(MSG, 'Please enter current password.');
			displayNotification(paramMap);
			return false;
		}
		if($('#newPassword').val() == ''){
			paramMap.put(MSG, 'Please enter new password.');
			displayNotification(paramMap);
			return false;
		}
		if($('#reEnterPassword').val() == ''){
			paramMap.put(MSG, 'Please re-enter password.');
			displayNotification(paramMap);
			return false;
		}
		if(!validPassword($('#newPassword').val())){
			paramMap.put(MSG, 'New password should contains at least one number, one lowercase and one uppercase letters and atleast six characters');
			displayNotification(paramMap);
			return false;
		}
		
		if($('#reEnterPassword').val() != $('#newPassword').val()){
			paramMap.put(MSG, 'New password and re-entered password should be same.');
			displayNotification(paramMap);
			return false;
		}
		return true;
	});
	
}