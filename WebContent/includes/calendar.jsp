<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>



<div class="calendar" style="display: none; z-index:90000; background-color: white;" tabindex="0" onblur="$(this).hide();">

	<table>
		<caption style="padding-bottom: 5px; font-size: 9pt;">
			<span class="calendar-move" style="float:left;" onclick="fn_calendar_move_y(-1);">◀</span>
			<span style="float:left;">&nbsp;</span>
			<span class="calendar-move" style="float:left;" onclick="fn_calendar_move_m(-1);">◁</span>

			<input type="text" value="2019" id="id_calendar_y" onchange="fn_calendar_move_y(0);" onkeyup="if(event.keyCode == 13) $('#id_calendar_m').focus();" style="width: 45px;text-align:center;height: 22px; padding: 0; font-size: 9pt;" />
			년
			<select class="m" id="id_calendar_m"  onchange="fn_calendar_move_m(0);" style="height: 22px; padding: 0; font-size:9pt;">
				<option value="1">1 월 </option>
				<option value="2">2 월 </option>
				<option value="3">3 월 </option>
				<option value="4">4 월 </option>
				<option value="5">5 월 </option>
				<option value="6">6 월 </option>
				<option value="7">7 월 </option>
				<option value="8">8 월 </option>
				<option value="9">9 월 </option>
				<option value="10">10 월 </option>
				<option value="11">11 월 </option>
				<option value="12">12 월 </option>
			</select>
			<span class="calendar-move"  style="float:right;" onclick="fn_calendar_move_y(1);">▶</span>
			<span style="float: right;">&nbsp;</span>
			<span class="calendar-move" style="float: right;" onclick="fn_calendar_move_m(1);">▷</span>
		</caption>
		<thead><tr>
			<th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>
		</tr>
		</thead>
		<tbody class="days">
			<tr class="r0"><td class="r0 c0"></td><td class="r0 c1"></td><td class="r0 c2"></td><td class="r0 c3"></td><td class="r0 c4"></td><td class="r0 c5"></td><td class="r0 c6"></td></tr>
			<tr class="r1"><td class="r1 c0"></td><td class="r1 c1"></td><td class="r1 c2"></td><td class="r1 c3"></td><td class="r1 c4"></td><td class="r1 c5"></td><td class="r1 c6"></td></tr>
			<tr class="r2"><td class="r2 c0"></td><td class="r2 c1"></td><td class="r2 c2"></td><td class="r2 c3"></td><td class="r2 c4"></td><td class="r2 c5"></td><td class="r2 c6"></td></tr>
			<tr class="r3"><td class="r3 c0"></td><td class="r3 c1"></td><td class="r3 c2"></td><td class="r3 c3"></td><td class="r3 c4"></td><td class="r3 c5"></td><td class="r3 c6"></td></tr>
			<tr class="r4"><td class="r4 c0"></td><td class="r4 c1"></td><td class="r4 c2"></td><td class="r4 c3"></td><td class="r4 c4"></td><td class="r4 c5"></td><td class="r4 c6"></td></tr>
			<tr class="r5"><td class="r5 c0"></td><td class="r5 c1"></td><td class="r5 c2"></td><td class="r5 c3"></td><td class="r5 c4"></td><td class="r5 c5"></td><td class="r5 c6"></td></tr>
		</tbody>
	</table>
	<span class="btn btnGoSelectday" onclick="calendar_init_date(gCalendar_selectday);">선택일</span>
	<span class="btn btnGotoday"     onclick="calendar_init_date(new Date());">오늘</span>
	<span class="btn btnClear"     onclick="calendar_set_empty();">Clear</span>
	<span class="btn btnClose"       onclick="$('div.calendar').hide();">닫기</span>
</div>



<style type="text/css">
div.calendar { border: 2px solid #909090; position: absolute;  background-color: white; padding: 5px; border-radius: 5px; }
div.calendar * {
	-webkit-box-sizing: border-box;
	   -moz-box-sizing: border-box;
			box-sizing: border-box;
				margin: 0;
           font-family: "나눔고딕", "NanumGothic", "ngWeb", sans-serif;
	    vertical-align: /*middle*/ ;
}
div.calendar table { border-spacing: 0; border-collapse: collapse; margin-bottom: 5px; }

div.calendar td { text-align: center; border: 1px solid #d0d0d0; min-width: 30px; padding: 3px;  }
div.calendar th { height: 1.0rem; padding: 0; line-height: 1.0rem;  border: 1px solid #d0d0d0; padding: 3px;background-color: #f0f0f0;  }
div.calendar td:hover { background-color: black; color: white; cursor: default; }

div.calendar span.btn { border: none; border-radius: 5px; font-size: 10pt; padding: 3px; cursor: pointer; }
div.calendar span.btn.btnGoSelectday { background-color: blue;   color: white;  }
div.calendar span.btn.btnGotoday     { background-color: red;    color: white; }
div.calendar span.btn.btnClear       { background-color: black;  color: white;   }
div.calendar span.btn.btnClose       { background-color: black;  color: white; float: right;  }

div.calendar  tr > td:nth-child(1) , div.calendar  tr > td:nth-child(7) { color: red; }
div.calendar td.selectday { background-color: blue; color: white; }
div.calendar td.today     { background-color: red;  color: white; }
div.calendar span.calendar-move { cursor: pointer; }

div.calendar tbody td.other-month { font-size: 9pt; color: #909090; }

</style>




<script type="text/javascript">
var gCalendar_selectday = undefined;
var gCalendar_element  = undefined;
var targetElement  ;


$(document).on('click', 'input.date,input.strdate,input.datetime,input.date', function(e){		// return false; // onclick에는 필수
	targetElement =$(this);

	var ofs = targetElement.offset();
	var oh  = targetElement.css("height").replace(/px/gi, '');
	var top = (Math.round(ofs.top) * 1 + oh * 1);

	if(gCalendar_element == this) {
		gCalendar_element = undefined;
		$("div.calendar").hide();
	} else {
		gCalendar_element = this;
		$("div.calendar").show().css({top: top,left:ofs.left,display:'block'});
		calendar_init(this.value);
	}
	return false; // onclick에는 필수 
});



$("div.calendar tbody td").on("click", function(){
	var ymd;



	if(gCalendar_element == undefined) {

		gCalendar_element = undefined;
		gCalendar_selectday = undefined;

		$("div.calendar").hide();
		return;
	}


	ymd = $(this).attr("data-ymd");

	if(ymd == "" || ymd == undefined ) {
		return;
	}

	$(gCalendar_element).val(ymd);

	$(gCalendar_element).change();
	
	gCalendar_element = undefined;
	gCalendar_selectday = undefined;

	$("div.calendar").hide();
});

function fn_date2str(dt) {
	var y = dt.getFullYear();
	var m = dt.getMonth()+1;
	var d = dt.getDate();

	return( y + "-" + (m<10 ? "0":"") + m + "-" + (d<10 ? "0":"") + d);
}



function fn_ymd2str(y,m,d) {	// 주의 m=0..11
	var new_m = m * 1 + 1;
	var new_d = d * 1;

	return( y + "-" + (new_m < 10 ? "0":"") + new_m + "-" + (new_d < 10 ? "0":"") + new_d);
}

function calendar_init(ymdstr) {
	var regexpdate = new RegExp(/^(19[0-9]{2}|[2-9][0-9]{3})[-./\s](0[1-9]|1[0-2])[-./\s](0[1-9]|[1-2][0-9]|3[0-1])$/);

	if(regexpdate.test(ymdstr)) {
		gCalendar_selectday = new Date(ymdstr);
	} else {
		gCalendar_selectday = new Date();
	}

	calendar_init_ymd(gCalendar_selectday.getFullYear(), gCalendar_selectday.getMonth(),  gCalendar_selectday.getDate());
}

function calendar_init_date(dt) { // Date 형식에 의한 초기화
	var y = dt.getFullYear();
	var m = dt.getMonth();
	var d = dt.getDate();

	calendar_init_ymd(y, m, 1);
}



function calendar_init_ymd(y,m, d) {	// 주의 : m[0..11]
	var mv = new Date(y,m,1);
	var rowidx = 0;
	var colidx = 0;
	var jQid;

	var mv_y = 0;
	var mv_m = 0;
	var mv_d = 0;

	var today = new Date();
	var today_y = today.getFullYear();
	var today_m = today.getMonth();
	var today_d = today.getDate();

	var sel_y = gCalendar_selectday.getFullYear();
	var sel_m = gCalendar_selectday.getMonth();
	var sel_d = gCalendar_selectday.getDate();
	var n=0;

	$("div.calendar tbody td").html('').removeClass("selectday").removeClass("today").removeClass("other-month");
	var w1 = mv.getDay();

 	for(n=0,mv.setDate(mv.getDate()-w1) ;  n < w1; n++,mv.setDate(mv.getDate()+1))
	{
		mv_y = mv.getFullYear();
		mv_m = mv.getMonth();	// 0..11
		mv_d = mv.getDate();

		colidx = mv.getDay();
		rowidx = 0;
		jQid = $("div.calendar td.r" + rowidx + ".c" + colidx);
		jQid.html(mv_d).attr("data-ymd", fn_ymd2str(mv_y, mv_m, mv_d)).addClass("other-month");
	}


	for( ;  mv.getMonth() == m; mv.setDate(mv.getDate()+1)) {
		mv_y = mv.getFullYear();
		mv_m = mv.getMonth();	// 0..11
		mv_d = mv.getDate();

		colidx = mv.getDay();
		rowidx = Math.floor((w1  + mv.getDate()-1) /7);
		jQid = $("div.calendar td.r" + rowidx + ".c" + colidx);
		// console.log("mv(" + mv_y + "," + mv_m + "," + mv_d + ")     today(" + today_y + "," + today_m + "," + today_d + ")     select(" + sel_y + "," + sel_m + "," + sel_d + ")");
		if(mv_y == sel_y && mv_m == sel_m && mv_d == sel_d) {
			jQid.html(mv_d).addClass("selectday");

		} else if(mv_y == today_y && mv_m == today_m && mv_d == today_d) {
			jQid.html(mv_d).addClass("today");

		} else {
			jQid.html(mv_d);
		}
		jQid.attr("data-ymd", fn_ymd2str(mv_y, mv_m, mv_d));
	}

	for(colidx++; colidx < 7; colidx++, mv.setDate(mv.getDate()+1)) {
		mv_y = mv.getFullYear();
		mv_m = mv.getMonth();	// 0..11
		mv_d = mv.getDate();

		jQid = $("div.calendar td.r" + rowidx + ".c" + colidx);
		jQid.html(mv_d).attr("data-ymd", fn_ymd2str(mv_y, mv_m, mv_d)).addClass("other-month");
	}

	for(n=0; n <= rowidx; n++) { $("div.calendar tbody td.r" + n).show(); }
	for(   ; n <6       ; n++) { $("div.calendar tbody td.r" + n).hide(); }

	$("div.calendar #id_calendar_y").val(y).attr("placeholder", y);
	$("div.calendar #id_calendar_m").val(m+1);
}


function fn_calendar_move_y(step) {
	var jQy = $("div.calendar #id_calendar_y");
	var jQm = $("div.calendar #id_calendar_m");

	var y = 0;
	var m = 0;

	if(jQy.val().match(/^[0-9]{4}$/)) {
		y = parseInt(jQy.val()) + parseInt(step);
		m = parseInt(jQm.val()) - 1;

		if(y < 1900 || 9999 < y) {
			alert("날짜 입력 오류 1900..2999 년 사이의 년도를 입력하십시요");
			var y = jQy.attr("placeholder");
			jQy.val(y);
			return;
		}
		calendar_init_ymd(y, m, 1);
	}
	else {
		alert("날짜 입력 오류 1900..2999 년 사이의 년도를 입력하십시요");
		var y = jQy.attr("placeholder");
		jQy.val(y);
		return;
	}
}



function fn_calendar_move_m(step) {
	var jQy = $("div.calendar #id_calendar_y");
	var jQm = $("div.calendar #id_calendar_m");
	var y = parseInt(jQy.val());
	var m = parseInt(jQm.val()) - 1;
	var ym = y * 12 + m + parseInt(step);

	y = Math.trunc(ym / 12);
	m = ym % 12;

	if(y < 1900 || 9999 < y) {
		alert("날짜 입력 오류 1900..2999 년 사이의 년도를 입력하십시요");
		var y = jQy.attr("placeholder");
		jQy.val(y);
		return;
	}

	calendar_init_ymd(y, m, 1);
}



function calendar_set_empty() {

	if(gCalendar_element == undefined) {
		gCalendar_element = undefined;
		gCalendar_selectday = undefined;

		$("div.calendar").hide();
		return;
	}

	gCalendar_element.value = "";
	$(gCalendar_element).change();

	gCalendar_element = undefined;
	gCalendar_selectday = undefined;

	$("div.calendar").hide();
}
</script>
