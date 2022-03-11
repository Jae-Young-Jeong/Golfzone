<%-- ----------------------------------------------------------------------------
DESCRIPTION :
   JSP-NAME : sysCodeDtl-modify.jsp
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

<log:setLogger logger="sysCodeDtl-modify.jsp"/>
<sql:setDataSource dataSource="jdbc/db" />
<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="today"/>


<log:info>필수파라미터
param.groupCode=[${param.groupCode}]
</log:info>




<sql:query var="SQL">
select	CAST(M.sysCodeDtl_id as char) AS sysCodeDtl_id
	,	FORMAT(M.sysCodeDtl_id, 0)  AS str_sysCodeDtl_id
	,	CAST(M.groupCode as char) AS groupCode
	,	FORMAT(M.groupCode, 0)  AS str_groupCode
	,	M.cd
	,	M.nm
	,	M.optGroupName
	,	DATE_FORMAT(M.sta_ymd, '%Y-%m-%d') AS sta_ymd
	,	DATE_FORMAT(M.end_ymd, '%Y-%m-%d') AS end_ymd
  from	sysCodeDtl M
 where	DATE(NOW()) between M.sta_ymd and M.end_ymd
     <c:if test="${not empty param.groupCode}">
   and	M.groupCode = ?									<sql:param value="${param.groupCode}"/>
</c:if><c:if test="${not empty param.aSysCodeDtl_id}">
   and	M.sysCodeDtl_id = ?									<sql:param value="${param.aSysCodeDtl_id}"/>
</c:if><c:if test="${not empty param.sysCodeDtl_id}">
   and	M.sysCodeDtl_id = ?									<sql:param value="${param.sysCodeDtl_id}"/>
</c:if>
</sql:query>


<table  style="width: 100%;"><tbody><tr>
	<td> ▶sysCodeDtl</td>
	<td class="tar">
		<input type="button" class="btnNew-sysCodeDtl" value="추가"/>
		<input type="button" class="btnSave-sysCodeDtl" value="저장"/>
	</td>
</tr></tbody></table>
<c:choose>
<c:when test="${SQL.rowCount > 0}">
	<table class="type3 sysCodeDtl" data-id="groupCode" data-value="${param.groupCode}"  data-groupCode="${param.groupCode}" data-bingo="A"  style="width: 100%;">
	<thead><tr>
		<th>#</th>
		<th>Del</th>
		<th>code</th>
		<th>name</th>
		<th>optGroupName</th>
		<th>sta_ymd</th>
		<th>end_ymd</th>
	</tr></thead>
	<tbody>
	<c:forEach var="p" items="${SQL.rows}" varStatus="s">
		<tr data-id="sysCodeDtl_id" data-value="${p.sysCodeDtl_id}" data-action="U">
			<td>${s.count}</td>
			<td><input type="checkbox" class="chkBtnDel"/></td>
<td class="sysCodeDtl cd"><input type="text" name="cd" class=" cd" value="${p.cd}" maxlength="12"/></td>
<td class="sysCodeDtl nm"><input type="text" name="nm" class=" nm" value="${p.nm}" maxlength="50"/></td>
<td class="sysCodeDtl optGroupName"><input type="text" name="optGroupName" class=" optGroupName" value="${p.optGroupName}" maxlength="150"/></td>
<td class="sysCodeDtl sta_ymd"><input type="text" name="sta_ymd" class="strdate sta_ymd" value="${p.sta_ymd}" maxlength="10" readonly/></td>
<td class="sysCodeDtl end_ymd"><input type="text" name="end_ymd" class="strdate end_ymd" value="${p.end_ymd}" maxlength="10" readonly/></td>
		</tr>
	</c:forEach>
	</tbody></table>

</c:when><c:otherwise>
	<table class="type3 sysCodeDtl" data-id="groupCode" data-value="${param.groupCode}"  data-groupCode="${param.groupCode}"  data-bingo="B" style="width: 100%;">
	<thead><tr>
		<th>#</th>
		<th>Del</th>
		<th>code</th>
		<th>name</th>
		<th>optGroupName</th>
		<th>sta_ymd</th>
		<th>end_ymd</th>
	</tr></thead>
	<tbody>
	</tbody>
	</table>

</c:otherwise>
</c:choose>

