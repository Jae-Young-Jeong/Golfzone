<%-- ----------------------------------------------------------------------------
DESCRIPTION :
   JSP-NAME : sysCode-table-list.jsp
    VERSION :
    HISTORY :
---------------------------------------------------------------------------- --%>
<%@page import="utils.MyOptionBuilder"%>
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

<log:setLogger logger="sysCode-table-list.jsp"/>
<sql:setDataSource dataSource="jdbc/db" />
<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="today"/>



<%
MyOptionBuilder ob_yn = new MyOptionBuilder("ynType");
%>




<sql:query var="SQL">
select	CAST(M.sysCode_id as char) AS sysCode_id
	,	FORMAT(M.sysCode_id, 0)  AS str_sysCode_id
	,	M.groupCode
	,	M.groupName
	,	M.useYn
  from	sysCode M
 where	1 = 1
     <c:if test="${not empty param.aSysCode_id}">
   and	M.sysCode_id = ?									<sql:param value="${param.aSysCode_id}"/>
</c:if><c:if test="${not empty param.sysCode_id}">
   and	M.sysCode_id = ?									<sql:param value="${param.sysCode_id}"/>
</c:if>
</sql:query>

<table style="width: 100%; " ><tbody><tr>
<td>○ sysCode</td>
<td style="text-align: right;">
	<input type="button" value="수정"     class="btnModify-sysCode"/>
	<input type="button" value="추가"     class="btnAdd-sysCode"/>
</td>
</tr></tbody></table>


<table class="type3 sysCode">
	<thead>
		<tr>
			<th class="">#</th>
			<th class="groupCode">groupCode</th>
			<th class="groupName">groupName</th>
			<th class="useYn">useYn</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="p" items="${SQL.rows}" varStatus="s">
		<tr class="itemBox sysCode ${p.sysCode_id eq param.selected_sysCode_id ? ' selected' : ''}" data-action="U" data-id="sysCode_id" data-value="${p.sysCode_id}" data-groupCode="${p.groupCode}">
			<td>${s.count}</td>
			<td class="groupCode">${p.groupCode}</td>
			<td class="groupName">${p.groupName}</td>
			<td class="useYn">${p.useYn}</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
