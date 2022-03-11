/*
 *

var jsSVC = {};
jsSVC.TRANSACTION = function(trid, url, params , callback ) {
	$.ajax({ type:'POST', url:url, data:params,
		success: function(args){
			callback(trid, url, args, '');
		},
		error:function(e){
			alert("실패 : " + url  );
			callback(trid, -1, e.responseText);
		}
	});
}

*
* 사용법
*

	var   trid = "";
	var    url = "";
	var params = ""; 


	TRANZACTION(trid, url, params , {}, function(trid, bRet, data, loopbackData){   //  TRANJSON, TRANZACTION
	    if(!bRet) {  alert(trid + " ERROR OCCURED !!!"); return false; }

		alertify.notify("message", "SUCCESS", 3);
	});


*/



/* ----------------------------------------------------------------------------------------------------------------
const  MAX_MINUTE  = 1198;
var latestTrTime = new Date();

function getReaminSessionTime() {
	var nowdt = new Date();
	var df = nowdt.getTime() - latestTrTime.getTime();
	var elapsed = Math.trunc(df / 1000);	// tr이 없던

	return { elapsed_seconds : elapsed, remain_seconds: MAX_MINUTE- elapsed,  timeout_seconds:  MAX_MINUTE };
}
---------------------------------------------------------------------------------------------------------------- */


/* ----------------------------------------------------------------------------------------------------------------

function timecheck() {
	var nowdt = new Date();
	var df = nowdt.getTime() - latestTrTime.getTime();


	var elapsed = Math.trunc(df / 1000);	// tr이 없던
	var remain = MAX_MINUTE - elapsed;

	var msg = "minute elapsed: " + elapsed + ", *remain:" + remain + ",  timediff=" + df + ", contextpath=" + sessionStorage.getItem("contextpath");

	if(remain <= 0) {
		alert("사용 중단으로 인하여 접속이 종료 되었습니다.");		
		window.location.replace(sessionStorage.getItem("contextpath") + "/index.jsp");
		return 0;
	}

	return (remain);
}
---------------------------------------------------------------------------------------------------------------- */


/* ----------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------- */
function TRANSACTION(trid, url, params , fn_callback, loopbackData ) {

	$.ajax({

		      type:'POST',
		       url:url,
		      data:params,
		   success: function(args)
		   			{
			   			console.log(url + " > success");
			   			fn_callback(trid, true, args, loopbackData );
			   		},

	         error: function(e)
	         		{
	        	 		console.log(url + " > error"  );
	         			fn_callback(trid, false, e.responseText, loopbackData);
	         		}
	});
}


/* ----------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------- */
function TRANZACTION(trid, url, params , loopbackData, fn_callback ) {


	$.ajax({

		      type:  'POST',
		       url:  url,
		      data:  params,
		   success: function(args)
		   			{
			   			console.log(url + " > success");			   
			   			fn_callback(trid, true, args, loopbackData );
			   		},

	         error: function(e)
	         		{
	        	 		console.log(url + " > error");	        	 
	         			fn_callback(trid, false, e.responseText, loopbackData);
	         		}
	});
}


/* ----------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------- */
function TRANJSON(trid, url, params , loopbackData, fn_callback ) {


	$.ajax({

		      type: 'POST',
		       url: url,
		      data: params,
	      dataType: "json",
		   success: function(args)
		   			{
			   			console.log(url + " > success");	
			   			fn_callback(trid, true, args, loopbackData );
			   		},

	         error: function(e)
	         		{
	        	 		console.log(url + " > error");
	         			fn_callback(trid, false, e.responseText, loopbackData);
	         		}
	});
}

