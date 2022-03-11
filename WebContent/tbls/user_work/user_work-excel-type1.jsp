<%-- ----------------------------------------------------------------------------
DESCRIPTION : 권한자(팀장, 원장) 이  본인또는 하위 사원이 등록한 내역을 승인(confirm)한다.
   JSP-NAME : user_work-excel-type1.jsp
    VERSION : 
    HISTORY : 
---------------------------------------------------------------------------- --%>
<%@page import="sun.reflect.ReflectionFactory.GetReflectionFactoryAction"%>
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
/*
ArrayList<HashMap<String, String>> rows = new ArrayList<HashMap<String, String>>();
ArrayList<HashMap<String, String>> cols = new ArrayList<HashMap<String, String>>();
ArrayList<HashMap<String, String>> data = new ArrayList<HashMap<String, String>>();
HashMap<String, String> params = new HashMap<String, String>(); 
MySql1 mysql = new MySql1();


params.put("term_sta_ymd", "2022-01-01");
params.put("term_end_ymd", "2022-12-31");

rows = mysql.sqlidToList("excel-1-rows", params );
if(rows == null) {
	System.out.println("excel-1-rows is empty");
} else {
	System.out.println("rows=" + String.valueOf(rows.size()));
}



cols = mysql.sqlidToList("excel-1-cols", params );
if(cols == null) {
	System.out.println("excel-1-cols is empty");
} else {
	System.out.println("cols=" + String.valueOf(cols.size()));
}



data = mysql.sqlidToList("excel-1-data", params );
if(data == null) {
	System.out.println("excel-1-data is empty");
} else {
	System.out.println("data=" + String.valueOf(cols.size()));
}
*/




String xlsPath = application.getRealPath("/xlsx");
System.out.println(xlsPath);








%>