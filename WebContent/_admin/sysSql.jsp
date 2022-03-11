DESCRIPTION :
   JSP-NAME : sysSql.jsp
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

<log:setLogger logger="sysSql.jsp"/>
<sql:setDataSource dataSource="jdbc/db" />
<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="today"/>



<!DOCTYPE html>
<html>
<head>
<title>sysSql</title>
<meta name="ROBOTS" content="NOINDEX, NOFOLLOW, NOIMAGEINDEX"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath}/commons/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/commons/js/alertify-1.13.1/alertify.js"></script>
<script src="${pageContext.request.contextPath}/commons/js/jsCommon.js"></script>
<script src="${pageContext.request.contextPath}/commons/js/jsSVC.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/commons/js/alertify-1.13.1/css/alertify.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/commons/css/default.css"/>

<style type="text/css">
html { width: 100%;  height: 100%; }
body { width: 100%;  height: 100%;  margin:0; padding: 4px; padding-top: 40px;  }
tr.selected * { background-color: yellow;  }
#param-bar { position: fixed; top:0; right:0; height: 40px; left:0; line-height: 40px; border-bottom : 0.1px solid black; }

table.title-sysSql { width: 100%;}
table.sysSql       { width: 100%; }
table.sysSqlDtl [name] { width: 100%; border: 0;  height: 26px; }


table.type3 { cellspacing:0; cellpadding:0;  border-spacing: 0; border-collapse: collapse;  width: 100%; }
table.type3 > thead > tr > th { height: 30px; background-color: #eaeaea; border: 0.1px solid #d0d0d0; }
table.type3 > tbody > tr > td { height: 30px; border: 0.1px solid #d0d0d0; padding-left:3px;  }


</style>


<script type="text/javascript">

/* --------------------------------------------------------------------
fn_btnQry_onclick
-------------------------------------------------------------------- */
function fn_btnMasterQry_onclick(e, master_id) {
	var jQ = $("#param-bar");

	var        trid = "sysSql-table-list.jsp";
	var         url = "${pageContext.request.contextPath}/tbls/sysSql/" + trid;
	var v_master_id = (master_id == undefined ? "" :  master_id);

	var params
	=          "sys_seqno=" + Math.round(Math.random() * 10e10)
	+    "&selected_sysSql_id=" + encodeURIComponent(v_master_id)
	;

	jQ.find("[name]").each(function(){
		var jthis = $(this);
		params += "&" + jthis.attr("name") + "=" + encodeURIComponent(jthis.val());
	});

	TRANZACTION(trid, url, params , {}, function(trid, bRet, data, loopbackData){  // TRANJSON, TRANZACTION
		if(!bRet) { alertify.notify(trid + ":오류가 발생하였습니다", "ERROR"); return; }
		$("#master-area").html(data);

		if(v_master_id != "") {
			fn_btnDetailQry_onclick(v_master_id, "");
		}
	});
	return false;
}



function fn_btnDetailQry_onclick(master_id, selected_detail_id) {

	var   trid = "sysSqlDtl-modify.jsp";
	var    url = "${pageContext.request.contextPath}/tbls/sysSqlDtl/" + trid;
	var params
	=           "sysSql_id=" + encodeURIComponent(master_id)
	+ "&selected_sysSqlDtl_id=" + encodeURIComponent(selected_detail_id)
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
	$("body").on("click", "tr.itemBox.sysSql",  function(){

		console.log("tr clicked");
		$("tr.itemBox.sysSql.selected").removeClass("selected");

		$(this).addClass("selected");

		fn_btnDetailQry_onclick($(this).attr("data-value"));
		return false;
	});



	/* --------------------------------------------------------------------------------
	Master [추가]
	-------------------------------------------------------------------------------- */
	$("body").on("click", ".btnAdd-sysSql", function(){
		var   trid = "sysSql-new.jsp";
		var    url = "${pageContext.request.contextPath}/tbls/sysSql/" + trid;
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
	$("body").on("click", ".btnModify-sysSql", function(){
		var   trid = "sysSql-modify.jsp";
		var    url = "${pageContext.request.contextPath}/tbls/sysSql/" + trid;

		var jQ = $("table.sysSql tr.selected");
		if(jQ.length < 1) {
			alertify.notify("수정할 행을 선택하여 주십시요.", "INFO");
			return false;
		}

		var params = "sysSql_id=" + jQ.attr("data-value");
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
	$("body").on("click", ".btnSave-sysSql", function(){
		var   trid = "sysSql-upsert.jsp";
		var    url = "${pageContext.request.contextPath}/tbls/sysSql/" + trid;
		var params = "sys_seqno=" + Math.round(Math.random() * 10e10);

		var jQ = $(".sysSql");
		var p = {
			sysSql_id : (jQ.attr("data-value")     == undefined ? "" : jQ.attr("data-value")     )
			,	action : (jQ.attr("data-action") == undefined ? "" : jQ.attr("data-action") )
			,	    sqlid : jQ.find("[name=sqlid]").val().trim()
			,	    sqlnm : jQ.find("[name=sqlnm]").val().trim()
			,	    useYn : jQ.find("[name=useYn]").val().trim()
		};


		/* ---------------------------------------------------------------------
		Master [저장] : check value
		--------------------------------------------------------------------- */



		/* ---------------------------------------------------------------------
		Master [저장] : make param
		--------------------------------------------------------------------- */
		var buf = [];
		buf.push("action=" + encodeURIComponent(p.action));
		buf.push("sysSql_id=" + encodeURIComponent(p.sysSql_id));
		buf.push(    "sqlid=" + encodeURIComponent(p.sqlid));
		buf.push(    "sqlnm=" + encodeURIComponent(p.sqlnm));
		buf.push(    "useYn=" + encodeURIComponent(p.useYn));
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
	$("body").on("click", ".btnNew-sysSqlDtl", function(){

		var   trid = "sysSqlDtl-new.jsp";
		var    url = "${pageContext.request.contextPath}/tbls/sysSqlDtl/" + trid;
		var params = "sys_seqno=" + Math.round(Math.random() * 10e10);

		var jQ = $("table.sysSqlDtl > tbody");

		TRANZACTION(trid, url, params , {}, function(trid, bRet, data, loopbackData){  // TRANJSON, TRANZACTION
			if(!bRet) { alertify.notify(trid + ":오류가 발생하였습니다", "ERROR"); return; }

			jQ.append(data);

		});
		return false;
	});




	/* --------------------------------------------------------------------
	Detail [name] change
	-------------------------------------------------------------------- */
	$("body").on("change", "table.sysSqlDtl [name]", function(){

		var jQthis = $(this);
		var jQtr   = jQthis.closest("tr");
		if(jQthis.attr("name") != "sta_ymd") { jQtr.find("[name=sta_ymd]").val("${today}"); }

		jQtr.addClass("modify");
		$(".btnSave-sysSqlDtl").show().removeClass("disabled");
	});




	/* --------------------------------------------------------------------
	Detail [name] delete check
	-------------------------------------------------------------------- */
	$("body").on("change", "table.sysSqlDtl .chkBtnDel", function(){
		var jQthis = $(this);
		var jQtr   = jQthis.closest("tr");

		jQtr.addClass("delete");
		$(".btnSave-sysSqlDtl").show().removeClass("disabled");

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
	$("body").on("click", ".btnSave-sysSqlDtl", function(){
		var   trid = "sysSqlDtl-upsert.jsp";
		var    url = "${pageContext.request.contextPath}/tbls/sysSqlDtl/" + trid;
		var params = "sys_seqno=" + Math.round(Math.random() * 10e10);
		var    cnt = 0;
		var errCnt = 0;

		var jQ = $("table.sysSqlDtl");
		var p = { 
				  action : jQ.attr("data-action")
		,	sysSqlDtl_id : jQ.attr("data-value")
		,      sysSql_id : String(jQ.find("[name=sysSql_id]").val()).trim()
		,	     sta_ymd : String(jQ.find("[name=sta_ymd]").val()).trim()
		,	     end_ymd : String(jQ.find("[name=end_ymd]").val()).trim()
		,	     sqlText : String(jQ.find("[name=sqlText]").val()).trim()
		};


		/* ----------------------------------------------------------------------
		Detail [저장] : make params
		---------------------------------------------------------------------- */
		var buf = [];
		buf.push(      "action=" + encodeURIComponent(p.action));
		buf.push("sysSqlDtl_id=" + encodeURIComponent(p.sysSqlDtl_id));
		buf.push(   "sysSql_id=" + encodeURIComponent(p.sysSql_id));
		buf.push(     "sta_ymd=" + encodeURIComponent(p.sta_ymd));
		buf.push(     "end_ymd=" + encodeURIComponent(p.end_ymd));
		buf.push(     "sqlText=" + encodeURIComponent(p.sqlText));

		params = buf.join("&");

//if(confirm(trid + " <== " + params))
		TRANJSON(trid, url, params , {}, function(trid, bRet, data, loopbackData){  // TRANJSON, TRANZACTION
			if(!bRet) { alertify.notify(trid + ":오류가 발생하였습니다", "ERROR"); return false; }


			if(data.code == "0") {
				alertify.notify(data.mesg, "INFO");
				fn_btnDetailQry_onclick(data.value);
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
		<input type="text" name="sysSql" value=""/> <input type="button"  class="btnSearch" value="조회" />
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