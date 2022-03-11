<%-- ----------------------------------------------------------------------------
DESCRIPTION :
   JSP-NAME : sysSql-upsert.jsp
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

<log:setLogger logger="sysSql-upsert.jsp"/>
<sql:setDataSource dataSource="jdbc/db" />
<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="today"/>


<log:info><c:forEach var="action" items="${paramValues.action}" varStatus="s">
[${s.index}][${paramValues.action[s.index]}]------------------------------------------------------
sysSql_id=${paramValues.sysSql_id[s.index]}
    sqlid=${paramValues.sqlid[s.index]}
    sqlnm=${paramValues.sqlnm[s.index]}
    useYn=${paramValues.useYn[s.index]}
</c:forEach>------------------------------------------------------</log:info>


<c:set var="code"  value="0"/>
<sql:transaction>
	<c:forEach var="action" items="${paramValues.action}" varStatus="s">
	<c:choose>
	<c:when test="${action eq 'N' or action eq 'C'}">
<sql:update>
insert	into sysSql (sqlid, sqlnm, useYn)
values
(
		?			<sql:param value="${paramValues.sqlid[s.index]}"/>
	,	?			<sql:param value="${paramValues.sqlnm[s.index]}"/>
	,	?			<sql:param value="${paramValues.useYn[s.index]}"/>
)
ON DUPLICATE KEY UPDATE
		    sqlid = ?			<sql:param value="${paramValues.sqlid[s.index]}"/>
	,	    sqlnm = ?			<sql:param value="${paramValues.sqlnm[s.index]}"/>
	,	    useYn = ?			<sql:param value="${paramValues.useYn[s.index]}"/>
</sql:update>
		<sql:query var="SQL">select last_insert_id() </sql:query>

		<c:set var="id"    value="sysSql_id"/>
		<c:set var="value" value="${SQL.rowsByIndex[0][0]}"/>



	</c:when><c:when test="${action eq 'U' }">
<sql:update>
update	sysSql
   set	    sqlid = ?			<sql:param value="${paramValues.sqlid[s.index]}"/>
	,	    sqlnm = ?			<sql:param value="${paramValues.sqlnm[s.index]}"/>
	,	    useYn = ?			<sql:param value="${paramValues.useYn[s.index]}"/>
 where	sysSql_id = ?				<sql:param value="${paramValues.sysSql_id[s.index]}"/>
</sql:update>

		<c:set var="id"    value="sysSql_id"/>
		<c:set var="value" value="${paramValues.sysSql_id[s.index]}"/>



	</c:when><c:when test="${action eq 'D'}">
<sql:update>
delete	from sysSql
 where	sysSql_id = ?		<sql:param value="${paramValues.sysSql_id[s.index]}"/>
</sql:update>

		<c:set var="id"    value="sysSql_id"/>
		<c:set var="value" value="${paramValues.sysSql_id[s.index]}"/>


	</c:when><c:otherwise>
		<log:info>알수없는 action[${action}] 유형입니다.</log:info>
		<c:set var="id"    value="sysSql_id"/>
		<c:set var="value" value="${paramValues.sysSql_id[s.index]}"/>
		<c:set var="code"  value="1"/>
		<c:set var="mesg"  value="${mesg}[${s.count}]알수없는 action[${action}] 유형입니다."/>


	</c:otherwise>
	</c:choose>
	</c:forEach>
</sql:transaction>


{ "code": "${code}", "mesg":"${empty mesg ? '적용 되었습니다' : mesg}", "id":"${id}", "value":"${value}"}