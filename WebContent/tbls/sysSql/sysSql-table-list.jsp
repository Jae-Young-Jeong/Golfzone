<%-- ----------------------------------------------------------------------------
DESCRIPTION :
   JSP-NAME : sysSql-table-list.jsp
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

<log:setLogger logger="sysSql-table-list.jsp"/>
<sql:setDataSource dataSource="jdbc/db" />
<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="today"/>



<%
MyOptionBuilder ob_useYn = new MyOptionBuilder("useYn");
%>




<sql:query var="SQL">
select	CAST(M.sysSql_id as char) AS sysSql_id
	,	FORMAT(M.sysSql_id, 0)  AS str_sysSql_id
	,	M.sqlid
	,	M.sqlnm
	,	M.useYn
  from	sysSql M
 where	1 = 1
     <c:if test="${not empty param.aSysSql_id}">
   and	M.sysSql_id = ?									<sql:param value="${param.aSysSql_id}"/>
</c:if><c:if test="${not empty param.sysSql_id}">
   and	M.sysSql_id = ?									<sql:param value="${param.sysSql_id}"/>
</c:if>
</sql:query>

<table style="width: 100%; " ><tbody><tr>
<td>○ sysSql</td>
<td style="text-align: right;">
	<input type="button" value="수정"     class="btnModify-sysSql"/>
	<input type="button" value="추가"     class="btnAdd-sysSql"/>
</td>
</tr></tbody></table>


<table class="type3 sysSql">
	<thead>
		<tr>
			<th class="">#</th>
			<th class="sysSql_id">sysSql_id</th>
			<th class="sqlid">sqlid</th>
			<th class="sqlnm">sqlnm</th>
			<th class="useYn">useYn</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="p" items="${SQL.rows}" varStatus="s">
		<tr class="itemBox sysSql ${p.sysSql_id eq param.selected_sysSql_id ? ' selected' : ''}" data-action="U" data-id="sysSql_id" data-value="${p.sysSql_id}">
			<td>${s.count}</td>
			<td class="sysSql_id">${p.sysSql_id}</td>
			<td class="sqlid">${p.sqlid}</td>
			<td class="sqlnm">${p.sqlnm}</td>
			<td class="useYn">${p.useYn}</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
