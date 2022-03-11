<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql"        prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"       prefix="c"   %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"        prefix="fmt" %>






<!DOCTYPE html>
<html>
<head>
<title>golfzone</title>
<jsp:include page="/includes/jsp-head.jsp"/>


<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="nowStr"/>
<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="<%=new java.util.Date()%>"  var="timeStr"/>

<sql:setDataSource dataSource="jdbc/db" />

<script type="text/javascript">

</script>
</head>
<body>


system time : <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="<%=new java.util.Date()%>" /><br/><br/>


<sql:query var="RS">
select version() as ver, date_format(NOW(), '%Y-%m-%d %T') as dbtime from dual
</sql:query>

MySQL  
<c:forEach var="p" items="${RS.rows}" varStatus="s">
	${p.ver} , dbtime : ${p.dbtime}
</c:forEach>
<br/><br/>


<table>
	<tbody>
		<tr><td>getServerInfo</td><td><%= application.getServerInfo() %></td></tr>
		<tr><td>servlet info      </td><td><%= application.getMajorVersion() %>.<%= application.getMinorVersion() %>       </td></tr>
		<tr><td>jsp info       </td><td> <%= JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %>      </td></tr>
		<tr><td>java version </td><td> <%= System.getProperty("java.version") %>      </td></tr>
		
		<tr><td>getAuthType               </td><td><%= request.getAuthType()            %></td></tr>
		<tr><td>getCharacterEncoding      </td><td><%= request.getCharacterEncoding()   %></td></tr>
		<tr><td>getContentType            </td><td><%= request.getContentType()         %></td></tr>
		<tr><td>getContextPath            </td><td><%= request.getContextPath()         %></td></tr>
		<tr><td>getPathInfo               </td><td><%= request.getPathInfo()            %></td></tr>
		<tr><td>getPathTranslated         </td><td><%= request.getPathTranslated()      %></td></tr>
		<tr><td>getProtocol               </td><td><%= request.getProtocol()            %></td></tr>
		<tr><td>getScheme                 </td><td><%= request.getScheme()              %></td></tr>
		<tr><td>getServerName             </td><td><%= request.getServerName()          %></td></tr>
		<tr><td>getServletPath            </td><td><%= request.getServletPath()         %></td></tr>
		<tr><td>getRequestURL             </td><td><%= request.getRequestURL()          %></td></tr>
		<tr><td>getRequestURI             </td><td><%= request.getRequestURI()          %></td></tr>
		<tr><td>getRemoteHost             </td><td><%= request.getRemoteHost()          %></td></tr>
		<tr><td>getRemoteAddr             </td><td><%= request.getRemoteAddr()          %></td></tr>
		<tr><td>localaddress              </td><td><%= application.getRealPath(request.getContextPath()) %></td></tr>
		
		<tr><td>timeout                   </td><td><%= request.getSession().getMaxInactiveInterval() * 1000 %></td></tr>

	</tbody>
	</tbody>
</table>
</body>
</html>