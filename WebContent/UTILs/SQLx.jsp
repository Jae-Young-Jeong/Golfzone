<%-- ----------------------------------------------------------------------------
DESCRIPTION : 
   JSP-NAME	: 
    VERSION : 1.0.1
    HISTORY : 
---------------------------------------------------------------------------- --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql"        prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"       prefix="c"   %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"  %>
<%@ taglib uri="http://logging.apache.org/log4j/tld/log" prefix="log" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"        prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>SQL-SELECT</title>
<jsp:include page="/includes/jsp-head.jsp"/>


<style type="text/css">
table.data td ,
table.data th { border: 1px solid #d0d0d0; }
textarea { margin-top: 10px; margin-bottom: 10px;}
</style>
</head>

<body>




<form method="post" >
	<textarea name="SQLs" style="width: 100%; height: 100px; margin-bottom: 10px;">${param.SQLs}</textarea>
	<input type="text" name="bingo" value=""/>
	<input type="submit" value="execute"/>
</form>
<br/>
<c:if test="${not empty param.SQLs and param.bingo eq 'q1w2e3r4!00'}">
	<sql:setDataSource dataSource="jdbc/db" />

		<sql:query var="SQL">
			${param.SQLs}
		</sql:query>

		<table class="data">
			<thead>
			<tr>
	
				<c:forEach var="col" items="${SQL.columnNames}">
					<th>${col}</th> 
				</c:forEach>
			</tr>
			</thead>
			<tbody>
				<c:forEach var="p" items="${SQL.rows}" varStatus="s">
					<tr>
						<c:forEach var="col" items="${SQL.columnNames}">
							<td>${p[col]}</td> 
						</c:forEach>
					</tr>
				</c:forEach>
			</tbody>
		</table>

</c:if>

</body>
</html>
