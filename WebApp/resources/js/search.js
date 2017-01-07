/**
 * 
 */
/**
 * This method is calling on change of search parameters.
 * Showing date picker if search by DOB is selected.
 * */

function searchKeySelect(selectObj){
	$("#searchValue").val('');
	if(selectObj.options[selectObj.selectedIndex].value == 3){
		var yrRange = '1900:'+ new Date().getFullYear();
		$( "#searchValue" ).datepicker({
		      changeMonth: true,
		      changeYear: true,
		      dateFormat : 'yy-mm-dd',
		      minDate: '1900-1-1',
		      maxDate: new Date(),
		      yearRange : yrRange,
		      onSelect: function(dateText, inst) {
		    	  $("#searchValue").attr('readonly', true);
		      }
		    });
	}else{
		$( "#searchValue" ).datepicker("destroy");
		$("#searchValue").attr('readonly', false);
	}
}

function openPage(oepration, patientId, appointmentId){
	
	var formObj = $(document.createElement('form'));
	formObj.attr("method", "post");
	
	var userIdObj = $(document.createElement('input'));
	userIdObj.attr("type", "text");
	userIdObj.attr("value", patientId);
	userIdObj.attr("name", "patientId");
	
	formObj.append(userIdObj);
	
	switch (oepration) { 
    case 'edit': 
        alert('Edit called');
        break;
    case 'delete': 
        alert('Delete called');
        break;
    case 'vHistory': 
        //alert('Visit History Called');
    	
    	var paramsMap = new Map();
    	var dataMap = new Map();
    	
    	dataMap.put(PATIENT_ID, patientId);
    	dataMap.put(MENU_REQUIRED,false);
    	
    	paramsMap.put(WIN_URL, '/Krishnadeep/pages/doctor/visitHistory.jsp');
    	paramsMap.put(DATA, dataMap);
    	
    	openWindow(paramsMap);
    	    	
    	break;      
    case 'vNew': 
    	
    	if(appointmentId !== undefined){
    		var appointObj = $(document.createElement('input'));
        	appointObj.attr("type", "text");
        	appointObj.attr("value", appointmentId);
        	appointObj.attr("name", "appointmentId");
        	formObj.append(appointObj);
    	}
    	
    	formObj.attr("action", "/Krishnadeep/pages/doctor/newVisit.jsp");
        formObj.submit();
        break;
    default:
        alert('Something went wrong!');
}
}
	
function openWindow(paramsMap){
	
	var winName='MyWindow';
	  var winURL = paramsMap.get(WIN_URL);
	  var width = paramsMap.hasKey(WIDTH) ? paramsMap.get(WIDTH) : screen.width;
	  var height = paramsMap.hasKey(HEIGHT) ? paramsMap.get(HEIGHT) : screen.height;
	  
	  //alert("width==>" + width + height);
	  
	  var left = (screen.width/2)-(width/2);
	  var top = (screen.height/2)-(height/2);
	  
	  var windowoption='resizable=yes,height='+height+',width='+width+',top='+top+',left='+left+',location=0,menubar=0,scrollbars=1';
	  var dataMap = paramsMap.get(DATA);         
	  var form = document.createElement("form");
	  form.setAttribute("method", "post");
	  form.setAttribute("action", winURL);
	  form.setAttribute("target",winName);
	  
	  if(dataMap && !dataMap.isEmpty()){
		  dataMap.each(function(key, value){
			  var input = document.createElement('input');
		      input.type = 'hidden';
		      input.name = key;
		      input.id = key;
		      input.value = value;
		      form.appendChild(input);
		  });
	  }
	              
	  document.body.appendChild(form);                       
	  window.open('', winName,windowoption);
	  form.target = winName;
	  form.submit();                 
	  document.body.removeChild(form);
	  
	  dataMap = null;paramsMap = null;
}

/*	
function openWindowWithPostRequest() {
	  var winName='MyWindow';
	  var winURL='search.action';
	  var windowoption='resizable=yes,height=600,width=800,location=0,menubar=0,scrollbars=1';
	  var params = { 'param1' : '1','param2' :'2'};         
	  var form = document.createElement("form");
	  form.setAttribute("method", "post");
	  form.setAttribute("action", winURL);
	  form.setAttribute("target",winName);  
	  for (var i in params) {
	    if (params.hasOwnProperty(i)) {
	      var input = document.createElement('input');
	      input.type = 'hidden';
	      input.name = i;
	      input.value = params[i];
	      form.appendChild(input);
	    }
	  }              
	  document.body.appendChild(form);                       
	  window.open('', winName,windowoption);
	  form.target = winName;
	  form.submit();                 
	  document.body.removeChild(form);           
	}*/


function openPatientFancyBox(patientId, operation, obj){
	
	var paramMap = new Map();
	
	var url, btnObj;
	
	if(operation == 'visitHistory'){
		url = contextPath + '/pages/doctor/visitHistory.jsp?menuRequired=false&patientId=' + patientId;
	}else{
		url = contextPath + '/pages/doctor/createPatient.jsp?menuRequired=false&patientId=' + patientId;
	}
	
	paramMap.put(URL, url);
	paramMap.put(WIDTH, '70%');
	paramMap.put(HEIGHT, '80%');
	
	openFancyBox(obj, paramMap);
}

$(document).ready(function() {
	$('#newPatient').click(function(){
		openPatientFancyBox(0, 'newPatient', this);
	});
	
	$('img[name=editPatient]').click(function(e){
			openPatientFancyBox($(this).id, 'updatePatient', this);
		});
	
	$('input[name=visitHistory]').click(function(e){
		openPatientFancyBox($(this).id, 'visitHistory', this);
	});
	
	$( "#dob" ).datepicker({
		changeMonth: true,
	    changeYear: true,
	    dateFormat: 'yy-mm-dd',
	    maxDate: new Date()
	});
});

function displaySuccessCreatePatient(patientId){
	
	console.log("patientId==>" + patientId);
	
	var msg = "Patient added successfully.";
	if(patientId !== '' || patientId !== 0){
		msg = "Patient updated successfully.";
	}
	
	Lobibox.alert("success",{
		msg : msg,
		beforeClose: function(lobibox){
        	parent.location.reload();
        }
	});
	
}

function validateCreatePatientForm(){
	
	var elementIds = [
		                  ['firstName','first name'], ['lastName','last name'], ['gender', 'gender'], ['dob','DOB'],
		                  ['contact', 'contact no'], ['address', 'address']
	                 ];
	var errorFound = false;
	var paramMap = new Map();
	$.each(elementIds, function( index, value ) {
		if(value[0] == 'gender' && $('#' + value[0]).val() == -1){
			paramMap.put(MSG, 'Please select ' + value[1]);
			errorFound = true;
			return false;
		}else if($('#' + value[0]).val() == ''){
			  paramMap.put(MSG, 'Please enter ' + value[1]);
			  errorFound = true;
			  return false;
		  }
		});
	if(errorFound){
		displayNotification(paramMap);
		return false;
	}else if($('#email').val() != '' && !isValidEmailAddress($('#email').val())){
		paramMap.put(MSG, 'Please enter valid email.');
		displayNotification(paramMap);
		return false;
	}
	
	var patientId = patientObj.patientId;
	if(patientId !== undefined){
		var oldFirstName = patientObj.firstName;
		var oldLastName = patientObj.lastName;
		var oldDob = patientObj.dob;
		
		var firstName = $('#firstName').val();
		var lastName = $('#lastName').val()
		var dob = $('#dob').val();
		
		var oldCombineText = (oldFirstName+oldLastName+oldDob).toLowerCase();
		var combineText = (firstName+lastName+dob).toLowerCase();
		
		if(oldCombineText != combineText){
			var patientTable = parent.$('#patientData');
			
			var firstNameArray = $(patientTable).DataTable().column(0).data();	
			firstNameArray = convertCaseArray(firstNameArray, LOWER_CASE);
			
			var lastNameArray = $(patientTable).DataTable().column(2).data();	
			lastNameArray = convertCaseArray(lastNameArray, LOWER_CASE);
			
			var dobArray = $(patientTable).DataTable().column(4).data();	
			
			$.each(firstNameArray, function( index, value ) {
				var cmbText = value + lastNameArray[index] + dobArray[index];
				if(combineText == cmbText){
					errorFound = true;
					paramMap.put(MSG, 'Duplicate combination of first name, last name and dob.');
					return false;
				}				
			});
		}
		
		if(errorFound){
			displayNotification(paramMap);
			return false;
		}
	}
}









	
