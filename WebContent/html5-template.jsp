<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql"        prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"       prefix="c"   %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"        prefix="fmt" %>



<!DOCTYPE html>
<html>
<head>
<title>html-template</title>
<jsp:include page="/includes/jsp-head.jsp"/>


<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="nowStr"/>
<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="<%=new java.util.Date()%>"  var="timeStr"/>
<sql:setDataSource dataSource="jdbc/db" />


<script type="text/javascript">

</script>
</head>
<body>


<sql:query var="RS">
select version() as ver from dual
</sql:query>

MySQL Version 
<c:forEach var="p" items="${RS.rows}" varStatus="s">
	${p.ver}
</c:forEach>



</body>
</html>