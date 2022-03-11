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


<c:if test="${not empty param.login_user_id}">
	<c:set var="login_user_id" value="${param.login_user_id}" scope="session"/>
</c:if>

<form method="post"  >
login_user_id = <input type="text" name="login_user_id" value="${sessionScope.login_user_id}"/>
<br/><br/>
<input type="submit" value="submit"/>
</form>

</body>
</html>