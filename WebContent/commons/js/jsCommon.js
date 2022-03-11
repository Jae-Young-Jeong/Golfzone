/* 
 * Jain Systems 
 * Copyright ⓒ Since 2015 By Ja:in Systems ㈜ All Rights Reserved.
 * 2018-06-22 isValidDate, isValidPhone 함수 수정
 * 
 * 
 * 
 * 
 */

/*
특수문자 체크 정규식
const regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/g;

모든 공백 체크 정규식
const regExp = /\s/g;

숫자만 체크 정규식
const regExp = /[0-9]/g;

이메일 체크 정규식
const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

휴대폰번호 체크 정규식
const regExp = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;

핸드폰번호 정규식
const regExp = /^\d{3}-\d{3,4}-\d{4}$/;

일반 전화번호 정규식
const regExp = /^\d{2,3}-\d{3,4}-\d{4}$/;

아이디나 비밀번호 정규식
const regExp = /^[a-z0-9A-Z_]{4,20}$/;

휴대폰번호 체크 정규식
const regExp = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
*/

var console = window.console || { log: function() {} }; //console.log()를 사용할 때, IE8 버전의 경우 개발자도구가 열려있지 않으면 에러가 발생하고, 그 이하 버전(IE6, IE7)의 경우는 아예 console을 지원하지 않기 때문에 에러가 나게 된다. 이러한 상황을 방지할려면, 다음과 같은 코드를 상단에 추가해 주면 에러가 나는 상황을 방지할 수 있다. - See more at: http://www.deadfire.net/jscript/projscript003.html#sthash.ca6rgGvk.dpuf

Math.trunc = Math.trunc || function(x) { return x < 0 ? Math.ceil(x) : Math.floor(x); }


String.prototype.lpad = function(ilen, padstr){
	var s = this;
    while(s.length < ilen)
        s = str + s;
    return s;
}
 
String.prototype.rpad = function(ilen, padstr){
    var s = this;
    while(s.length < ilen)
        s += padstr;
    return s;
}




function firstUpper(str) {
	return str.substring(0,1).toUpperCase() + str.substring(1, 100);
}


if (!String.prototype.trim) {
	String.prototype.trim = function () {
		return this.replace(/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g, '');
	};
}


var myTimeoutVar;



function gete(str) {
	return document.getElementById(str);
}

function timeout() {
	alert("timeout" );
}

function number_format( number )
{
  var nArr = String(number).split('').join(',').split('');
  for( var i=nArr.length-1, j=1; i>=0; i--, j++)  if( j%6 != 0 && j%2 == 0) nArr[i] = '';
  return nArr.join('');
  
  //[출처] [JAVASCRIPT] 3자리 마다 쉼표만 찍어주는 number_format 함수|작성자 b1ix
}


/* --------------------------------------------------------------------
 * 
 * 
 * --------------------------------------------------------------------
 */
var regexp_phone = new RegExp(/^(02|0[0-9]{2})[-./\s]?([0-9]{3,4})[-./\s]?([0-9]{4})$/);

function isValidPhone(obj, isalertflag) {

	
	if( typeof obj == "object") {
		var ret =  isValidPhoneObject(obj, isalertflag);
		if(ret) {
			obj.style.backgroundColor = "white";
		} else {
			obj.style.backgroundColor = "#ffcccc";
		}
		return ret;
	} else {
		return isValidPhoneStr(obj,isalertflag);
	}
}

function isValidPhoneObject(obj, isalertflag) {
	var str = obj.value;
	
	if(str == "" ) return true;

	
	if(regexp_phone.test(str)) {
		var toks = regexp_phone.exec(str);
		var validphonestr = toks[1] + "-" + toks[2] + "-" + toks[3];
		obj.setAttribute( 'placeholder', "" );
		obj.value = validphonestr;
		
		return true;
	} else {
		obj.setAttribute( 'placeholder', str);
		obj.value = "";
		isalertflag && alert("전화번호 입력에 오류가 있습니다.");
		return false;
	}
}

function isValidPhoneStr(str, isalertflag) {
	if(str == "") return true;
	
	return regexp_phone.test(str);
}




function getValidPhone(obj, isalertflag) {
	
	if( typeof obj == "object") {
		return getValidPhoneObject(obj, isalertflag);
	} else {
		return getValidPhoneStr(obj,isalertflag);
	}
}

function getValidPhoneObject(obj, isalertflag) {
	var str = obj.value;
	
	if(str == "" ) return "";

	return getValidPhoneStr(str, isalertflag);
}

function getValidPhoneStr(str, isalertflag) {
	if(str == "") return "";
	
	if(regexp_phone.test(str)) {
		var toks = regexp_phone.exec(str);
		var validphonestr = toks[1] + "-" + toks[2] + "-" + toks[3];
		return validphonestr;
	} else {
		isalertflag && alert("전화번호 입력에 오류가 있습니다.");
		return "-1";
	}
}


/* --------------------------------------------------------------------
 * 
 * 
 * --------------------------------------------------------------------
 */

var regexp_date   = new RegExp(/^(19[0-9]{2}|[0-9]{4})[-./\s\/]?(0[1-9]|1[0-2]|[1-9])[-./\s\/]?(0[1-9]|[1-2][0-9]|3[0-1]|[1-9])$/);
var regexp_date_6 =            new RegExp(/^([0-9]{2})[-./\s\/]?(0[1-9]|1[0-2]|[1-9])[-./\s\/]?(0[1-9]|[1-2][0-9]|3[0-1]|[1-9])$/);
var regexp_date_4 =                                new RegExp(/^(0[1-9]|1[0-2]|[1-9])[-./\s\/]?(0[1-9]|[1-2][0-9]|3[0-1]|[1-9])$/); // 연도 없이 월 일만 입력하는 경우

function isValidYmd(y,m,d) {

	
	if(100 < y  && y < 1900 ) { return false; } 
	if(m < 1 || 12 < m) {  return false; }
	if(d < 1 || 31 < d) {  return false; }

	if(m == 2) {
		if((y % 400) == 0 && d <= 29) return true; 
		if((y % 100) == 0 && d <= 28) return true;
		if((y %   4) == 0 && d <= 29) return true;
		if(                  d <= 28) return true;
		return false;
		
	} else 	if((m == 4 || m == 6 || m == 9 || m == 11) && (30 < d)) {  
		return false;
	} else {
		// m in (1,3,5,7,8,10,12)
		return true;
	}
	return true; 
}

function ymdToStr(y,m,d) {
	
	return y + "-" + ((m < 10) ? "0":"") + m + "-" + ((d < 10) ? "0":"") + d;
}


function isValidDate(obj, isalertflag) {
console.log("isValidDate(...) typeof obj=" + typeof obj);
	if(typeof obj == "object") {
		if(isValidDateObject(obj, isalertflag)) {
			obj.style.backgroundColor = "white";
			return true; 
		} else {
			obj.style.backgroundColor = "#ffcccc";
			return false;
		}
	} else {
		return isValidDateStr(obj, isalertflag);
	}
}





function isValidDateObject(obj, isalertflag) {
	var ret = [];
	var str = obj.value;

	if( trim(str) == "") return true; 
	str = str.replace(/[-\/.년월일\s]/gi, "");

	if(str.length < 6 || str.length > 10) {
		obj.setAttribute("placeholder", obj.value);
		obj.value = "";
		
		isalertflag && alert("날짜 형식에 오류가 있습니다.");
		return false;
	}
	
	if(str.length == 6) {
		ret[0] = str;
		ret[1] = str.substring(0, 2);
		ret[2] = str.substring(2, 4);
		ret[3] = str.substring(4, 6);

		var dt = new Date();
		ret[1] = (((ret[1]*1) <= (dt.getYear() % 100)) ? 2000 : 1900) + ret[1]*1;

		if(!isValidYmd(ret[1], ret[2], ret[3])) {
			obj.setAttribute("placeholder", obj.value);
			obj.value = "";
			isalertflag && alert("날짜 형식에 오류가 있습니다.");
			return false;
		}

		obj.value = ret[1] + "-" + ((ret[2].length == 1) ? "0":"") + ret[2] + "-" + ((ret[3].length == 1) ? "0":"") + ret[3]; 
		return true;
	}
	else if(str.length == 8)
	{
		ret[0] = str;
		ret[1] = str.substring(0, 4);
		ret[2] = str.substring(4, 6);
		ret[3] = str.substring(6, 8);
		
		// 정상
		if(!isValidYmd(ret[1], ret[2], ret[3])) {
			obj.setAttribute("placeholder", obj.value);
			obj.value = "";
			isalertflag && alert("날짜 형식에 오류가 있습니다.");
			return false;
		}

		obj.value = ret[1] + "-" + ((ret[2].length == 1) ? "0":"") + ret[2] + "-" + ((ret[3].length == 1) ? "0":"") + ret[3]; 
		return true;
	} 
	else {
		obj.setAttribute("placeholder", obj.value);
		obj.value = "";
		isalertflag && alert("날짜 형식에 오류가 있습니다.");
		return false;		
	}
}





function isValidDateStr(str, isalertflag) {
	
	var ret = [];
	
	str = str.replace(/[-\/.년월일\s]/gi, "");
	if(str == "") return true;

	if(str.length == 6) {
		ret[0] = str;
		ret[1] = str.substring(0, 2);
		ret[2] = str.substring(2, 4);
		ret[3] = str.substring(4, 6);

		var dt = new Date();
		ret[1] = (((ret[1]*1) <= (dt.getYear() % 100)) ? 2000 : 1900) + ret[1]*1;

		if(!isValidYmd(ret[1], ret[2], ret[3])) {
			isalertflag && alert("날짜 형식에 오류가 있습니다.");
			return false;
		}
		return true;
	}
	else if(str.length == 8)
	{
		ret[0] = str;
		ret[1] = str.substring(0, 4);
		ret[2] = str.substring(4, 6);
		ret[3] = str.substring(6, 8);
		
		// 정상
		if(!isValidYmd(ret[1], ret[2], ret[3])) {
			isalertflag && alert("날짜 형식에 오류가 있습니다.");
			return false;
		}
		return true;
	} 
	else {
		isalertflag && alert("날짜 형식에 오류가 있습니다.");
		return false;		
	}
	return false;
}

function correctDateStr(str) {
	var toks;
	var ret;
	
	if(str == null || str == "") return "";
	
	if(regexp_date.test(str)) return true;
	
	var dt = new Date();
	
	if(regexp_date_6.test(str)) {
		toks = regexp_date_6.exec(str);
		return ("" +  Math.ceil(dt.getFullYear() / 100) + "-" + toks[0] + "-" + ((toks[1] < 9) ? "0" : "") + toks[1] +  "-" + ((toks[2] < 9) ? "0" : "") + toks[2]);
	}
	else if(regexp_date_4.test(str)) {
		toks = regexp_date_4.exec(str);
		return("" +  dt.getFullYear()  + "-" + ((toks[0] < 9) ? "0" : "") + toks[0] +  "-" + ((toks[1] < 9) ? "0" : "") + toks[1]);
	}
	
	return "";
	
}





function date_format(dt) {
	var y = dt.getFullYear();
	var m = dt.getMonth()+1;
	var d = dt.getDate();
	
	return y + "-" + (m<10 ? "0":"") + m + "-" + (d<10 ? "0":"") + d; 
}
/* --------------------------------------------------------------------
 * 
 * 
 * --------------------------------------------------------------------
 */
var regexp_num = new RegExp(/^(([0-9]*)|(([0-9]*)\.([0-9]*)))$/);

function isValidNum(obj, isalertflag) {
	if(typeof obj == "object") {
		return isValidNumObject(obj, isalertflag);
	} else {
		return isValidNumStr(obj, isalertflag);
	}
}


function isValidNumObject(obj, isalertflag) {
	
	if(obj.value == "") return true;
	
	var str = obj.value.replace(/[,\s]/g, '');

	if(regexp_num.test(str)) {
		obj.style.backgroundColor = "white";
		obj.value = number_format(str);
		obj.placeholder = "";
		return true;
	} else {
		obj.style.backgroundColor = "#ffcccc";
		isalertflag && alert("숫자 형식에 오류가 있습니다.");
		obj.placeholder = obj.value;
		obj.value="";
		return false;
	}
}

function isValidNumStr(numStr, isalertflag) {
	var str = numStr.replace(/,/g, '');

	if(str == "") return true;
	
	var tmp = regexp_num.test(str); 
	if(tmp ) {
		return true;
	} else {
		isalertflag && alert("숫자 형식에 오류가 있습니다.");
		return false;
	}

}










/* --------------------------------------------------------------------
 * 
 * isValidNum 과 다른 점은  number formating  울 하지 않는 것이다.
 * --------------------------------------------------------------------
 */

function isValidNo(obj, isalertflag) {
	if(typeof obj == "object") {
		return isValidNoObject(obj, isalertflag);
	} else {
		return isValidNoStr(obj, isalertflag);
	}
}


function isValidNoObject(obj, isalertflag) {
	
	if(obj.value == "") return true;
	
	var str = obj.value.replace(/[,\s]/g, '');

	if(regexp_num.test(str)) {
		obj.style.backgroundColor = "white";
//		obj.value = number_format(str);
		obj.placeholder = "";
		return true;
	} else {
		obj.style.backgroundColor = "#ffcccc";
		isalertflag && alert("숫자 형식에 오류가 있습니다.");
		obj.placeholder = obj.value;
		obj.value="";
		return false;
	}
}

function isValidNoStr(numStr, isalertflag) {
	var str = numStr.replace(/,/g, '');

	if(str == "") return true;
	
	var tmp = regexp_num.test(str); 
	if(tmp ) {
		return true;
	} else {
		isalertflag && alert("숫자 형식에 오류가 있습니다.");
		return false;
	}

}




/* --------------------------------------------------------------------
 * 
 * 
 * --------------------------------------------------------------------
 */
var regexp_rrno = new RegExp(/^([0-9]{6})[-./\s ]?([0-9]{7})$/);

function isValidRrno(obj, isalertflag) {

	
	if( typeof obj == "object") {
		return isValidRrnoObject(obj, isalertflag);
	} else {
		return isValidRrnoStr(obj,isalertflag);
	}
}

function isValidRrnoObject(obj, isalertflag) {

	if(obj.value == "" ) {
		obj.setAttribute("placeholder", "");
		return true;
	}

	if(regexp_rrno.test(obj.value)) {
		var toks = regexp_rrno.exec(obj.value);

		
		if(! isValidRrno6Str(toks[0], isalertflag)) {
			obj.style.backgroundColor = "#ffcccc";
			obj.setAttribute("placeholder", obj.value);
			obj.value = "";
			return false;			
		}

		// 우선 parrity 에 오류가 있는 경우 알려는 주지만 막지는 말자 
		if(! isValidRrnoParrity(data[0], data[1], isalertflag)) {
			obj.style.backgroundColor = "0xcacaff";
			obj.setAttribute("placeholder", obj.value);
		//	obj.value = "";
		}

		obj.style.backgroundColor = "white";
		obj.value = obj.value.replace(regexp_rrno, "$1-$2");
		return true;
	} else {
		obj.style.backgroundColor = "#ffcccc";
		obj.setAttribute("placeholder", obj.value);
		obj.value = "";
		isalertflag && alert("주민등록번호 형식에 오류가 있습니다.");
		return false;
	}
}

function isValidRrnoStr(str, isalertflag) {
	if(str == "") return true;
	
	return regexp_rrno.test(str);
}

function isValidRrnoParrity(f, r, isalertflag) {
	
	//	주민번호의 앞쪽 12자리 각각에 [2,3,4,5,6,7,8,9,2,3,4,5] 를 곱해서 다 던한 값(sum) 을    11 - (sum % 11)  한 값이 주민번호의 13번쨰 자리수이다. 
	
	var sum = 0;
	var m = [2,3,4,5,6,7,8,9,  2,3,4,5,6 ]
	if(f.length != 6 || r.length != 7) {
		return false;
	}
	
	ptr = 0;
	for(var n=0; n < 6; n++) {
		sum += f.substr(n, 1) * m[ptr++];
	}
	
	for(var n=0; n < 6; n++) {
		sum += r.substr(n, 1) * m[ptr++];
	}
	

	var mod11 = sum % 11;
	var parrity = 11 - mod11 ;
	
	if(r.substr(6,1) == parrity ) {
		return true;
	} else {
		isalertflag && alert("주민번호가 적정하지 않습니다.");
		return false;
	}
}

/* --------------------------------------------------------------------
 * 
 *	check RRNO6  
 * --------------------------------------------------------------------
 */

function isValidRrno6(obj, isalertflag) {
	
	if( typeof obj == "object") {
		return isValidRrno6Object(obj, isalertflag);
	} else {
		return isValidRrno6Str(obj,isalertflag);
	}
}

function isValidRrno6Object(obj, isalertflag) {

	if(obj.value == "" ) return true;
	
	
	
	if(isValidRrno6Str(obj.value,  isalertflag)) {
		obj.style.backgroundColor = "white";
		return true;
	} else {
		obj.style.backgroundColor = "#ffcccc";
		return false;
	}
}

function isValidRrno6Str(rrno6, isalertflag) {

	if( rrno6  == "") {
		return true;
	}

		
	if(rrno6.length != 6) {
		isalertflag && alert("주민번호앞 6자리는  필수 6자리를 입력하여 주십시요");
		return false;
	}

	var yy = rrno6.substr(0,2) * 1;
	var mm = rrno6.substr(2,2) * 1;
	var dd = rrno6.substr(4,2) * 1;
	var isLeap = 0;
	var days = 0;
	
	
	if(mm == 2) {
		if((yy %   4)==0) isLeap = 1;
		if((yy % 100)==0) isLeap = 0;
		if((yy % 400)==0) isLeap = 1;
		days = (28+isLeap);
	}
	else if(mm == 1 || mm == 3 || mm == 5|| mm == 7|| mm == 8|| mm == 10|| mm == 12) { 
		days = 31;
	}
	else {
		days = 30;
	}

	
	if(mm < 1 || 12 < mm) {
		$("[name=rrno6]").focus();
		isalertflag && alert("주민번호앞6자리(yymmdd) 중에서 월(mm)에 해당하는 부분에 오류가 있습니다. 월은 01~12 중에 입력이 되어야 합니다. ");
		return false;
	}

	if(dd < 1 || days < dd) {
		isalertflag && alert("주민번호앞6자리(yymmdd) 중에서 일(dd)에 해당하는 부분에 오류가 있습니다. 일은 01~" + days +  " 중에 입력이 되어야 합니다. ");
		return false;
	}

	return true;
}






/* --------------------------------------------------------------------
 * 
 * 
 * --------------------------------------------------------------------
 */

function makeparam(str) {
	var ret ;
	ret = str.replace(/\'/gm, '&#39;');
	ret = ret.replace(/\</gm, '&lt;');
	ret = ret.replace(/\>/gm, '&gt;');
	return ret;
}

function isNumeric(str)
{
//  return (input - 0) == str &&  (''+str).trim().length > 0; // trim() : chrome 10.0,  IE 9.0, firefox 3.5 navi 5.0 O 10.5 부터 지원
//	return (input - 0) == str &&  trim(''+str).length > 0;
	return !isNaN(str);
}

function trim(str) {
	return str.replace(/(^\s+)|(\s+$)/g,'');
	
	// Strimg.trim() 은  IE 9.0 부터 제공됨. 
	//return   str.replace(/(^\s+)|(\s+$)/g, "");
}


function fn_removeWhiteSpace(s) {
	return  s.replace( /\s+/gm , ' ' ); // enter 도 삭제 되네 ... ? 
}
function fn_removeEnter(s, tgt) {
	return s.replace( /\r?\n/gm , tgt );
}


function copyToClipboard(text) {
/*
    if (window.clipboardData) { // Internet Explorer
        window.clipboardData.setData("Text", text);
    } else {  
        unsafeWindow.netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");  
        const clipboardHelper = Components.classes["@mozilla.org/widget/clipboardhelper;1"].getService(Components.interfaces.nsIClipboardHelper);  
        clipboardHelper.copyString(text);
    }
*/
}

function isLeapYear(y) {
	
	if((y % 400)==0) {
		return 1;
	}
	if((y % 100)==0) {
		return 0;
	}
	if((y % 4) == 0 ) {
		return 1;
	}
	return 0;
}





//콤마찍기
function numberFormat(num) {
	
	if(num=="" || num == 0) {
		return "";
	}
	
	
	
	var str = String(num);
	var pattern = /(-?[0-9]+)([0-9]{3})/;
	while(pattern.test(str)) {
		str = str.replace(pattern,"$1,$2");
	}
	return str;
}



function toDate(dateStr) {
	var y=0;
	var m=0;
	var d=0;
	
	
	if(dateStr.length == 8 ) {
		y = dateStr.substr(0,4);
		m = dateStr.substr(4,2)-1;
		d = dateStr.substr(6,2);
	} else if( dateStr.length  == 10 ) {
		y = dateStr.substr(0,4);
		m = dateStr.substr(5,2)-1;
		d = dateStr.substr(8,2);
	}
	
	return new Date(y,m,d);
}

function addDate( dateStr, days ) {  

	var dt = toDate(dateStr);
	dt.setDate(dt.getDate() + days);

	alert(dt.format("yyyy-mm-dd"));
}


function formatDate(dt) {
	var y = dt.getFullYear();
	var m = dt.getMonth() + 1 ;
	var d = dt.getDate();

	var ret = y + "-";
	
	if(m < 10) { ret += "0" + m + "-";  } else { ret += m + "-"; }
	if(d < 10) { ret += "0" + d  ;      } else { ret += d;       }

	return ret;
}


function fitTextAreaById(textareaId) {
	var iDes=  document.getElementById(textareaId);

	var sh = iDes.scrollHeight;
	if( sh > 30 ) {
		iDes.style.height = (sh * 1 + 30) +'px';
	} else {
		
	}
}

function fitTextArea(textareaName) {
	var iDes=  document.getElementsByName(textareaName);

	
	for(var n=0; n<iDes.length;  n++) {
		var sh = iDes[n].scrollHeight;
		if( sh > 10 ) {
			iDes[n].style.height = sh +'px';
		} else {
			iDes[n].rows = 1;
		}
	}
}


function fitTextAreaByObj(obj) {	// obj  = textarea
	obj.style.height = 20 + "px";
	
		var sh = obj.scrollHeight;
		var lh = 20;
		
console.log("2 sh=" + sh + ", lh=" + lh);

	
		if( sh > lh ) {
			obj.style.height = sh +'px';
		} else {
			obj.rows = 1;
			obj.style.height = lh +'px';
		}
}




/*function FitToContent(id, maxHeight)
{
   var text = id && id.style ? id : document.getElementById(id);
   if ( !text )
      return;

   var adjustedHeight = text.clientHeight;
   if ( !maxHeight || maxHeight > adjustedHeight )
   {
      adjustedHeight = Math.max(text.scrollHeight, adjustedHeight);
      if ( maxHeight )
         adjustedHeight = Math.min(maxHeight, adjustedHeight);
      if ( adjustedHeight > text.clientHeight )
         text.style.height = adjustedHeight + "px";
   }
}
*/


function byteLength(s) {
/*	stringByteLength = (function(s,b,i,c){
	    for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
	    return b
	});*/
	
	var b,i,c;
//	for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);  << 이게 맞긴하다. 하지만 목적을 이룰 수 없어서 .. 변경해서 사용함.
	for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?2:c>>7?2:1);
	return b;
}




// font.js

/*
var font = (function () {
    var test_string = 'mmmmmmmmmwwwwwww';
    var test_font = '"Comic Sans MS"';
    var notInstalledWidth = 0;
    var testbed = null;
    var guid = 0;
    
    return {
        // must be called when the dom is ready
        setup : function () {
            if ($('#fontInstalledTest').length) return;

            $('head').append('<' + 'style> #fontInstalledTest, #fontTestBed { position: absolute; left: -9999px; top: 0; visibility: hidden; } #fontInstalledTest { font-size: 50px!important; font-family: ' + test_font + ';}</' + 'style>');
            
            
            $('body').append('<div id="fontTestBed"></div>').append('<span id="fontInstalledTest" class="fonttest">' + test_string + '</span>');
            testbed = $('#fontTestBed');
            notInstalledWidth = $('#fontInstalledTest').width();
        },
        
        isInstalled : function(font) {
            guid++;
        
            var style = '<' + 'style id="fonttestStyle"> #fonttest' + guid + ' { font-size: 50px!important; font-family: ' + font + ', ' + test_font + '; } <' + '/style>';
            
            $('head').find('#fonttestStyle').remove().end().append(style);
            testbed.empty().append('<span id="fonttest' + guid + '" class="fonttest">' + test_string + '</span>');
                        
            return (testbed.find('span').width() != notInstalledWidth);
        }
    };
})();
*/



function getChoUtf8(aChar) {
	// 출처: http://kipid.tistory.com/entry/한글-초성검색-in-Javascript [kipid's blog]
	
	var rCho = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"];
	var rJung = ["ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"];
	var rJong = ["", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ"
					, "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"];
 
	var cho, jung, jong;
	var nTmp=aChar.charCodeAt(0) - 0xAC00;
	var ret = "";
	
	
	jong = nTmp % 28; // 종성
	jung = ( (nTmp-jong)/28 ) % 21; // 중성
	cho  = ( ( (nTmp-jong)/28 ) - jung ) / 21; // 초성
/*	 
	console.log("cho=" + cho + ", jung=" + jung + ", jong=" + jong); 
	console.log(
	"초성:"+rCho[cho]+" "
	+"중성:"+rJung[jung]+" "
	+"종성:"+rJong[jong]
	);
*/
	if(0 <= cho && cho < 19) {
		ret += rCho[cho];
	}

}

function getChosUtf8(aStr) {
	// 출처: http://kipid.tistory.com/entry/한글-초성검색-in-Javascript [kipid's blog]
	
	var ret = "";
	var rCho = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"];
	var rJung = ["ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"];
	var rJong = ["", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ"
					, "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"];
 
	var cho, jung, jong;
	for(var n=0; n < aStr.length; n++) {
		var nTmp = aStr.charCodeAt(n) - 0xAC00;

		jong = nTmp % 28; // 종성
		jung = ( (nTmp-jong)/28 ) % 21; // 중성
		cho  = ( ( (nTmp-jong)/28 ) - jung ) / 21; // 초성
/*	 
		console.log("cho=" + cho + ", jung=" + jung + ", jong=" + jong); 
		console.log(
		"초성:"+rCho[cho]+" "
		+"중성:"+rJung[jung]+" "
		+"종성:"+rJong[jong]
		);
*/
		if(0 <= cho && cho < 19) {
			ret += rCho[cho];
		}

	}
	return ret;

}



function downloadExcel(targetid, savefilename) {
	var objDownload = document.getElementById(targetid);
	var oNewDoc = document.createDocumentFragment();
	var nLength = objDownload.rows.length;
	var objMeta = oNewDoc.createElement("<meta http-equiv='Content-Type' content='text/html; charset=utf-i'>");
	var objHead = oNewDoc.createElement("<head>");
	var objHtml = oNewDoc.createElement("<html>");
	var objBody = oNewDoc.createElement("<body>");
	var oCloneNode = objDownload.cloneNode(true);
	
	objHead.insertBefore(objMeta);
	objHtml.insertBefore(objHead);
	objBody.insertBefore(oCloneNode);
	objHtml.insertBefore(objBody);
	oNewDoc.insertBefore(objHtml);
	if(! savefilename) {
		savefilename = 'excel.xls';
	}
	oNewDoc.execCommand("SaveAs", true, savefilename);
}

function copyToClipboard(targetid) {
	if(window.clipboardData) {
		window.clipboardData.setData("Text", $("#" + targetid).html() );
		alert("엑셀에 붙여 넣으십시요 !");
	}
}

function showOpen(url, rWidth, rHeight) {
	var width = 0;
	var height = 0;
	
	if(rWidth <= 1) {
		width  = screen.width  * rWidth;
	} else {
		width  = rWidth;
	}

	if(rHeight <= 1) {
		height = screen.height * rHeight;
	} else {
		height = rHeight;
	}
	
	var winPosLeft = Math.round((screen.width  - width ) / 2);
	var winPosTop  = Math.round((screen.height - height) / 2);
/*
width : 팝업창 가로길이
height : 팝업창 세로길이
toolbar=no : 단축도구창(툴바) 표시안함
menubar=no : 메뉴창(메뉴바) 표시안함
location=no : 주소창 표시안함
scrollbars=no : 스크롤바 표시안함
status=no : 아래 상태바창 표시안함
resizable=no : 창변형 하지않음
fullscreen=no : 전체화면 하지않음
channelmode=yes : F11 키 기능이랑 같음
left=0 : 왼쪽에 창을 고정(ex. left=30 이런식으로 조절)
top=0 : 위쪽에 창을 고정(ex. top=100 이런식으로 조절)
example : "width=400, height=600, menubar=no, status=no, toolbar=no"  
출처: http://cho2.tistory.com/entry/windowopen-옵션 [초초의 다락방]
*/
	var sOption = "width=" + width + ", height=" + height + ", top=" + winPosTop + ", left=" + winPosLeft + ", scrollbars=yes, location=no, status=no, resizable=yes, menubar=no";
console.log("jsCommon.js showOpen sOption=" + sOption);
	// var args = window.dialogArguments;  client 화면에서 받을 수 있다. 
	var ret = window.open(url, "popupwindow", sOption); // 'status:1; resizable:1; dialogWidth:900px; dialogHeight:500px; dialogTop=50px; dialogLeft:100px');
	ret.moveTo(winPosLeft, winPosTop);
	ret.focus();
	return ret;
}


function showModal(url, args, rWidth, rHeight) {
	var width = 0;
	var height = 0;
	
	if(rWidth <= 1) {
		width  = screen.width  * rWidth;
	} else {
		width  = rWidth;
	}

	if(rHeight <= 1) {
		height = screen.height * rHeight;
	} else {
		height = rHeight;
	}
	
	var winPosLeft = Math.round((screen.width  - width ) / 2);
	var winPosTop  = Math.round((screen.height - height) / 2);
	
	var sOption = "dialogWidth:" + width + "px; dialogHeight:" + height + "px; status:0; resizable:1; dialogLeft:" +  winPosLeft + "px; dialogTop:" + winPosTop + "px;";
	
	// var args = window.dialogArguments;  client 화면에서 받을 수 있다. 
	if(window.showModalDialog) {
		var ret = window.showModalDialog(url, args, sOption); // 'status:1; resizable:1; dialogWidth:900px; dialogHeight:500px; dialogTop=50px; dialogLeft:100px');
		return ret;		
	}
	else {
		showOpen(url, rWidth, rHeight);
	}
}


function goNextIndex(obj) {
	var ni = $(obj).attr("tabindex") + 1;
//	console.log("nextIndex=" + nextIndex);
	$("[tabindex='" + ni + "']").focus();	//
}


/*
 * 오늘과 비교하여 적으면 -1 같으면 0    크면 1 이 반환됨.
 */
function compdate(d1) {
	var cd = correctDateStr(d1);
	
	var dt = new Date();
	
	var d1ymd = regexp_date.exec(cd);
	
	if( t1ymd[0] < dt.getFullYear())
		return -1;
	else if ( t1ymd[0] > dt.getFullYear())
		return 1;
	else {
			
		if( t1ymd[1] < (dt.getMonth() +1))
			return -1;
		else if ( t1ymd[1] > (dt.getMonth() +1))
			return 1;
		else {
		

			if( t1ymd[2] < dt.getDate())
				return -1;
			else if ( t1ymd[2] > dt.getDate())
				return 1;
			else {
				return 0;
			}
		}
	}
}



function checkValidForm(topcomponentSelector) {
	var errcnt = 0;
	$(topcomponentSelector).find(".strdate").each(function() {
		errcnt += isValidDate(this, false) ? 0 : 1;
	});
	
	if(errcnt > 0 ) {
		alert("날짜 형식에 입력 오류가 있습니다.");
		return false;
	}

	errcnt = 0;
	$(topcomponentSelector).find(".strphone").each(function() {
		errcnt += isValidPhone(this, false) ? 0 : 1;
	});
	
	if(errcnt > 0 ) {
		alert("전화번호 형식에 입력 오류가 있습니다.");
		return false;
	}

	return true;
}



/* ====================================================================
==
==	비미번호 체크 로직 
==================================================================== */

function checkSpace(str) { 
	if(str.search(/\s/) != -1) { return true; } else { return false; } 
}

function checkSpecial(str) { 
	var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
	if(special_pattern.test(str) == true) { return true; } else { return false; } 
}

function checkPasswordPattern(str) { 
	var pattern1 = /[0-9]+/;		// 숫자 
	var pattern2 = /[a-zA-Z]+/;	// 문자 
	var pattern3 = /[~!@#$%^&*()_+|<>?:{}]+/;	// 특수문자 
	
//	alert("pattern1=" + pattern1.test(str));
//	alert("pattern2=" + pattern2.test(str));
//	alert("pattern3=" + pattern3.test(str));
	
	if(!pattern1.test(str) || !pattern2.test(str) || !pattern3.test(str) || str.length < 6) { 
		alert("비밀번호는 8자리 이상 문자, 숫자, 특수문자로 구성하여야 합니다."); 
		return false; 
	} 
	else { 
		return true; 
	}
}


function pwdValidation(pwd1, pwd2) {
	
	if(pwd1 == "") return false;
	
	if(pwd1.length < 6) {
		alert("비밀번호는 6자리 이상이어야 합니다.");
		return false;
	}
	
	if(pwd1 != pwd2) {
		alert("비밀번호와 확인이 일치하지 않습니다.");
		return false;
	}
	
	
	return true;
}



function string2Hex(aString, aTitle, aElement4Out) {
	var ptr=  0;
	var str = "";
	
	for(var n=0; n < aString.length; n++) {
		var c = aString.charCodeAt(n);
		
		if(c <   16) {
			str += "0" + c.toString(16) + " ";
		} else if(c <= 128) { 
			str += c.toString(16) + " ";
			
		} else if(128 < c && c < 2048 ) {
			str += ((c >> 6) | 128).toString(16) + " ";
			str += ((c & 63) | 128).toString(16) + " ";
		} else {
			str += ((c >> 12) | 224).toString(16) + " ";			
			str += (((c >> 6) & 63) | 128).toString(16) + " ";
			str += ((c & 63) | 128).toString(16) + " ";
		}
	}

	document.getElementById(aElement4Out).value = str;
}














function getBrowserType() {
	
	
	var agent = navigator.userAgent.toLowerCase();
	

	if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
	  return "msie";
	}

	// 크롬 체크

	if (agent.indexOf("chrome") != -1) {
	  return "chrome";
	}

	// 사파리나 체크
	if (agent.indexOf("safari") != -1) {
		return "safari";
	}

	// 파이어폭스 체크
	if (agent.indexOf("firefox") != -1) {
		return "firefox";
	}
	return "";
	
}


function deepCopyObject(inObject) {
	var outObject, value, key;
	if(typeof inObject !== "object" || inObject === null) {
		return inObject;
	}
	outObject = Array.isArray(inObject) ? [] : {};
	for (key in inObject) {
		value = inObject[key];
		outObject[key] = (typeof value === "object" && value !== null) ? deepCopyObject(value) : value;
	}
	return outObject;
}

