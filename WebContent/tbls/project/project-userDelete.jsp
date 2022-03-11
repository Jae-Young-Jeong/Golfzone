<%-- ----------------------------------------------------------------------------
DESCRIPTION : 
   JSP-NAME : project-userDelete.jsp
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

<log:setLogger logger="project-userDelete.jsp"/>
<sql:setDataSource dataSource="jdbc/db" />
<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="today"/>


<log:info><c:forEach var="action" items="${paramValues.action}" varStatus="s">
[${s.index}][${paramValues.action[s.index]}]------------------------------------------------------
	project_cd=[${paramValues.project_cd[s.index]}]
	project_nm=[${paramValues.project_nm[s.index]}]
	   sta_ymd=[${paramValues.sta_ymd[s.index]}]
	   end_ymd=[${paramValues.end_ymd[s.index]}]
	    use_yn=[${paramValues.use_yn[s.index]}]
	 tech_note=[${paramValues.tech_note[s.index]}]
	 memo_note=[${paramValues.memo_note[s.index]}]
	  mod_date=[${paramValues.mod_date[s.index]}]
</c:forEach>------------------------------------------------------</log:info>


<sql:transaction>

	<sql:update var="rows">
	delete	from user_project 
	 where	project_cd = ?				<sql:param value="${param.project_cd}"/>
	   and	user_id    = ?				<sql:param value="${param.user_id}"/>
	</sql:update>

</sql:transaction>

{"code": "0", "mesg":"삭제 되었습니다.", "rows":"${rows}"}
