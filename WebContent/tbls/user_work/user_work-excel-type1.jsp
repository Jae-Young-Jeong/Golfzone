<%-- ----------------------------------------------------------------------------
DESCRIPTION : 권한자(팀장, 원장) 이  본인또는 하위 사원이 등록한 내역을 승인(confirm)한다.
   JSP-NAME : user_work-excel-type1.jsp
    VERSION : 
    HISTORY : 
---------------------------------------------------------------------------- --%>
<%@page import="utils.MySql1"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
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

<log:setLogger logger="user_work-excel-type1.jsp"/>
<sql:setDataSource dataSource="jdbc/db" />
<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="today"/>

<%
ArrayList<HashMap<String, String>> rs = new ArrayList<HashMap<String, String>>();
HashMap<String, String> params = new HashMap<String, String>(); 
MySql1 mysql = new MySql1();

rs = mysql.sqlidToList("excel-1-rows", params );


%>