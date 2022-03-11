<%-- ----------------------------------------------------------------------------
DESCRIPTION :
   JSP-NAME : sysCode.jsp
    VERSION :
    HISTORY :
---------------------------------------------------------------------------- --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql"        prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"       prefix="c"   %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"  %>
<%@ taglib uri="http://logging.apache.org/log4j/tld/log" prefix="log" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"        prefix="fmt" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>

<log:setLogger logger="sysCode.jsp"/>
<sql:setDataSource dataSource="jdbc/db" />
<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="today"/>



<!DOCTYPE html>
<html>
<head>
<title>sysCode</title>
<jsp:include page="/_admin/admin-jsp-header.jsp"/>

<style type="text/css">
html { width: 100%;  height: 100%; }
body { width: 100%;  height: 100%;  margin:0; padding: 4px; padding-top: 40px;  }
tr.selected * { background-color: yellow;  }
#param-bar { position: fixed; top:0; right:0; height: 40px; left:0; line-height: 40px; border-bottom : 0.1px solid black; }

table.title-sysCode { width: 100%;}
table.sysCode       { width: 100%; }
table.sysCodeDtl [name] { width: 100%; border: 0;  height: 26px; }


table.type3 { cellspacing:0; cellpadding:0;  border-spacing: 0; border-collapse: collapse;  width: 100%; }
table.type3 > thead > tr > th { height: 30px; background-color: #eaeaea; border: 0.1px solid #d0d0d0; }
table.type3 > tbody > tr > td { height: 30px; border: 0.1px solid #d0d0d0; padding-left:3px;  }


</style>


<script type="text/javascript">

/* --------------------------------------------------------------------
fn_btnQry_onclick
-------------------------------------------------------------------- */
function fn_btnMasterQry_onclick(e, groupCode) {
	var jQ = $("#param-bar");

	var        trid = "sysCode-table-list.jsp";
	var         url = "${pageContext.request.contextPath}/tbls/sysCode/" + trid;
	var v_groupCode = (groupCode == undefined ? "" :  groupCode);

	var params
	=          "sys_seqno=" + Math.round(Math.random() * 10e10)
	+    "&selected_groupCode=" + encodeURIComponent(v_groupCode)
	;

	jQ.find("[name]").each(function(){
		var jthis = $(this);
		params += "&" + jthis.attr("name") + "=" + encodeURIComponent(jthis.val());
	});

	TRANZACTION(trid, url, params , {}, function(trid, bRet, data, loopbackData){  // TRANJSON, TRANZACTION
		if(!bRet) { alertify.notify(trid + ":오류가 발생하였습니다", "ERROR"); return; }
		$("#master-area").html(data);

		if(v_groupCode != "") {
			fn_btnDetailQry_onclick(v_groupCode, "");
		}
	});
	return false;
}



function fn_btnDetailQry_onclick(grupCode, selected_detail_id) {

	var   trid = "sysCodeDtl-modify.jsp";
	var    url = "${pageContext.request.contextPath}/tbls/sysCodeDtl/" + trid;
	var params
	=           "groupCode=" + encodeURIComponent(grupCode)
	+ "&selected_sysCodeDtl_id=" + encodeURIComponent(selected_detail_id)
	;

	console.log("fn_btnDetailQry_onclick() ==> params=" + params);


	TRANZACTION(trid, url, params , {}, function(trid, bRet, data, loopbackData){  // TRANJSON, TRANZACTION
		if(!bRet) { alertify.notify(trid + ":오류가 발생하였습니다", "ERROR"); return; }

		$("#detail-area").html(data);
	});
	return false;
}






$(function(){

	/* --------------------------------------------------------------------
	--	master list 조회
	-------------------------------------------------------------------- */
	$("#param-bar .btnSearch").on("click", fn_btnMasterQry_onclick );


	/* --------------------------------------------------------------------
	--	master-tr-onclick
	-------------------------------------------------------------------- */
	$("body").on("click", "tr.itemBox.sysCode",  function(){

		console.log("tr clicked");
		$("tr.itemBox.sysCode.selected").removeClass("selected");

		$(this).addClass("selected");

		fn_btnDetailQry_onclick($(this).attr("data-groupCode"), "");
		return false;
	});



	/* --------------------------------------------------------------------------------
	Master [추가]
	-------------------------------------------------------------------------------- */
	$("body").on("click", ".btnAdd-sysCode", function(){
		var   trid = "sysCode-new.jsp";
		var    url = "${pageContext.request.contextPath}/tbls/sysCode/" + trid;
		var params = "sys_seqno=" + Math.round(Math.random() * 10e10);

		TRANZACTION(trid, url, params , {}, function(trid, bRet, data, loopbackData){  // TRANJSON, TRANZACTION
			if(!bRet) { alertify.notify(trid + ":오류가 발생하였습니다", "ERROR"); return false; }

			$("#master-area").html(data);
		});
		return false;
	});




	/* --------------------------------------------------------------------------------
	Master [수정]
	-------------------------------------------------------------------------------- */
	$("body").on("click", ".btnModify-sysCode", function(){
		var   trid = "sysCode-modify.jsp";
		var    url = "${pageContext.request.contextPath}/tbls/sysCode/" + trid;

		var jQ = $("table.sysCode tr.selected");
		if(jQ.length < 1) {
			alertify.notify("수정할 행을 선택하여 주십시요.", "INFO");
			return false;
		}

		var params = "sysCode_id=" + jQ.attr("data-value");
//console.log("Master [수정] params>" + params );
		TRANZACTION(trid, url, params , {}, function(trid, bRet, data, loopbackData){  // TRANJSON, TRANZACTION
			if(!bRet) { alertify.notify(trid + ":오류가 발생하였습니다", "ERROR"); return false; }

			$("#master-area").html(data);
		});
		return false;
	});




	/* --------------------------------------------------------------------------------
	Master [저장]
	-------------------------------------------------------------------------------- */
	$("body").on("click", ".btnSave-sysCode", function(){
		var   trid = "sysCode-upsert.jsp";
		var    url = "${pageContext.request.contextPath}/tbls/sysCode/" + trid;
		var params = "sys_seqno=" + Math.round(Math.random() * 10e10);

		var jQ = $(".sysCode");
		var p = {
			sysCode_id : (jQ.attr("data-value")     == undefined ? "" : jQ.attr("data-value")     )
			,	action : (jQ.attr("data-action") == undefined ? "" : jQ.attr("data-action") )
			,	 groupCode : jQ.find("[name=groupCode]").val().trim()
			,	 groupName : jQ.find("[name=groupName]").val().trim()
			,	     useYn : jQ.find("[name=useYn]").val().trim()
		};


		/* ---------------------------------------------------------------------
		Master [저장] : check value
		--------------------------------------------------------------------- */



		/* ---------------------------------------------------------------------
		Master [저장] : make param
		--------------------------------------------------------------------- */
		var buf = [];
		buf.push(    "action=" + encodeURIComponent(p.action));
		buf.push("sysCode_id=" + encodeURIComponent(p.sysCode_id));
		buf.push( "groupCode=" + encodeURIComponent(p.groupCode));
		buf.push( "groupName=" + encodeURIComponent(p.groupName));
		buf.push(     "useYn=" + encodeURIComponent(p.useYn));
		params = buf.join("&");

//if(confirm(params))
		TRANJSON(trid, url, params , {}, function(trid, bRet, data, loopbackData){  // TRANJSON, TRANZACTION
			if(!bRet) { alertify.notify(trid + ":오류가 발생하였습니다", "ERROR"); return false; }
//console.log(data);
			if(data == undefined || data.code == undefined) {
				alertify.notify(trid + " 리턴오류 입니다.", "ERROR");
				return false;
			}

			if(data.code == "0") {
				alertify.notify(data.mesg, "INFO");
				fn_btnMasterQry_onclick({}, data.value);
			} else {
				alertify.notify(data.mesg, "ERROR");
			}

			return false;
		});
		return false;
	});



	/* --------------------------------------------------------------------
	Detail add new
	-------------------------------------------------------------------- */
	$("body").on("click", ".btnNew-sysCodeDtl", function(){

		var   trid = "sysCodeDtl-new.jsp";
		var    url = "${pageContext.request.contextPath}/tbls/sysCodeDtl/" + trid;
		var params = "sys_seqno=" + Math.round(Math.random() * 10e10);

		var jQ = $("table.sysCodeDtl > tbody");

		TRANZACTION(trid, url, params , {}, function(trid, bRet, data, loopbackData){  // TRANJSON, TRANZACTION
			if(!bRet) { alertify.notify(trid + ":오류가 발생하였습니다", "ERROR"); return; }

			jQ.append(data);

		});
		return false;
	});




	/* --------------------------------------------------------------------
	Detail [name] change
	-------------------------------------------------------------------- */
	$("body").on("change", "table.sysCodeDtl [name]", function(){

		var jQthis = $(this);
		var jQtr   = jQthis.closest("tr");
		if(jQthis.attr("name") != "sta_ymd") { jQtr.find("[name=sta_ymd]").val("${today}"); }

		jQtr.addClass("modify");
		$(".btnSave-sysCodeDtl").show().removeClass("disabled");
	});




	/* --------------------------------------------------------------------
	Detail [name] delete check
	-------------------------------------------------------------------- */
	$("body").on("change", "table.sysCodeDtl .chkBtnDel", function(){
		var jQthis = $(this);
		var jQtr   = jQthis.closest("tr");

		jQtr.addClass("delete");
		$(".btnSave-sysCodeDtl").show().removeClass("disabled");

		if(jQtr.hasClass("addnew")) {
			if(jQthis.is(":checked")) {
				jQtr.remove();
			}else {
				//
			}
		} else {
			if(jQthis.is(":checked")) {
				jQtr.addClass("delete");
			}else {
				jQtr.removeClass("delete");
			}
		}
	});


	/* --------------------------------------------------------------------------------
	Detail [저장]
	-------------------------------------------------------------------------------- */
	$("body").on("click", ".btnSave-sysCodeDtl", function(){
		var   trid = "sysCodeDtl-upsert.jsp";
		var    url = "${pageContext.request.contextPath}/tbls/sysCodeDtl/" + trid;
		var params = "sys_seqno=" + Math.round(Math.random() * 10e10);
		var    cnt = 0;
		var errCnt = 0;

		var        jQ = $("table.sysCodeDtl");
		var groupCode = jQ.attr("data-groupCode");
		var         p = [];

//console.log("master_id=" + master_id);

		jQ.find("tr.modify,tr.delete").each(function(){
			var jQthis = $(this);
			var action = "";
//console.log("jQthis data-action=" + jQthis.attr("data-action") + ", data-id=" + jQthis.attr("data-id") + ", data-id=" + jQthis.attr("data-id"));


			if(errCnt>0) return false;

			if(jQthis.hasClass("delete")) {
				action = "D";
			} else {
				action = jQthis.attr("data-action");
			}

			var o = {      action : action
				,       groupCode : groupCode
				,	sysCodeDtl_id : (jQthis.attr("data-value") == undefined ? "" : jQthis.attr("data-value"))
				,	           cd : jQthis.find("[name=cd]").val().trim()
				,	           nm : jQthis.find("[name=nm]").val().trim()
				,	 optGroupName : jQthis.find("[name=optGroupName]").val().trim()
				,	      sta_ymd : jQthis.find("[name=sta_ymd]").val().trim()
				,	      end_ymd : jQthis.find("[name=end_ymd]").val().trim()
			};
			p.push(o);
			cnt++;
		});

		if(cnt    == 0) { alertify.notify("변경사항이 없습니다.", "WARNING"); return false; }
		if(errCnt >  0) { return false; }

//console.log("p as");
//console.log(p);

		/* ----------------------------------------------------------------------
		Detail [저장] : check validation
		---------------------------------------------------------------------- */
		for(var n=0; n<p.length; n++) {
			var o = p[n];


		}



		/* ----------------------------------------------------------------------
		Detail [저장] : make params
		---------------------------------------------------------------------- */
		var buf = [];

		for(var n=0; n<p.length; n++) {
			var o = p[n];

			buf.push(       "action=" + encodeURIComponent(o.action));
			buf.push("sysCodeDtl_id=" + encodeURIComponent(o.sysCodeDtl_id));
			buf.push(   "sysCode_id=" + encodeURIComponent(o.sysCode_id));
			buf.push(    "groupCode=" + encodeURIComponent(o.groupCode));
			buf.push(           "cd=" + encodeURIComponent(o.cd));
			buf.push(           "nm=" + encodeURIComponent(o.nm));
			buf.push( "optGroupName=" + encodeURIComponent(o.optGroupName));
			buf.push(      "sta_ymd=" + encodeURIComponent(o.sta_ymd));
			buf.push(      "end_ymd=" + encodeURIComponent(o.end_ymd));
		}

		params = buf.join("&");

//if(confirm(params))
		TRANJSON(trid, url, params , {}, function(trid, bRet, data, loopbackData){  // TRANJSON, TRANZACTION
			if(!bRet) { alertify.notify(trid + ":오류가 발생하였습니다", "ERROR"); return false; }


			if(data.code == "0") {
				alertify.notify(data.mesg, "ERROR");
				fn_btnDetailQry_onclick(groupCode, "");
			} else {
				alertify.notify(data.mesg, "ERROR");
				return false;
			}

		});
		return false;

	});


	/* --------------------------------------------------------------------------------
	end of $(function())
	-------------------------------------------------------------------------------- */
});  // end of $(function())

</script>

</head><body>

<section id="title-bar"></section>

<section id="nav-bar"></section>

<section id="param-bar">
		기준일 : <input type="text" name="base_ymd" value="${today}" class="strdate" style="width: 110px; " readonly/>
		<input type="text" name="sysCode" value=""/> <input type="button"  class="btnSearch" value="조회" />
</section>


<table style="width: 100%; height: 100%;">
<tbody>
	<tr>
		<td id="master-area" style="width: 30%; padding-right: 20px;" valign="top"></td>
		<td id="detail-area" valign="top"></td>
	</tr>
<%--
	<tr>
		<td id="param-area"></td>
	</tr>
--%>
</tbody>
</table>

<section id="data-area">
</section>


<jsp:include page="/includes/calendar.jsp">
	<jsp:param value="bongo" name="bingo"/>
</jsp:include>
</body>
</html>