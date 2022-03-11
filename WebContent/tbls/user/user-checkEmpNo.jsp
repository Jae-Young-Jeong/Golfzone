<%-- ----------------------------------------------------------------------------
DESCRIPTION : 
   JSP-NAME : user-upsert.jsp
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

<log:setLogger logger="user-upsert.jsp"/>
<sql:setDataSource dataSource="jdbc/db" />
<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="today"/>

<log:info>emp_no=[${param.emp_no}]</log:info>


<sql:query var="RS">
select	user_id, emp_nm
  from	user
 where	emp_no = ?		<sql:param value="${param.emp_no}"/>
</sql:query>

<c:choose>
	<c:when test="${RS.rowCount > 0 }">
		{ "id": "user_id", "value": "${RS.rowsByIndex[0][0]}", "emp_no":"${param.emp_no}",  "emp_nm": "${RS.rowsByIndex[0][1]}"}
	</c:when><c:otherwise>
		{ "id": "", "value": ""}
	</c:otherwise>
</c:choose>
