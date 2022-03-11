<%-- ----------------------------------------------------------------------------
DESCRIPTION :
   JSP-NAME : sysCode-modify.jsp
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

<log:setLogger logger="sysCode-modify.jsp"/>
<sql:setDataSource dataSource="jdbc/db" />
<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="today"/>

<%
MyOptionBuilder ob_yn = new MyOptionBuilder("ynType");
%>




<sql:query var="SQL">
select	CAST(M.sysCode_id as char) AS sysCode_id
	,	FORMAT(M.sysCode_id, 0)  AS str_sysCode_id
	,	M.groupCode
	,	M.groupName
	,	M.useYn
  from	sysCode M
 where	1 = 1
     <c:if test="${not empty param.aSysCode_id}">
   and	M.sysCode_id = ?									<sql:param value="${param.aSysCode_id}"/>
</c:if><c:if test="${not empty param.sysCode_id}">
   and	M.sysCode_id = ?									<sql:param value="${param.sysCode_id}"/>
</c:if>
</sql:query>



<table style="width: 100%; " ><tbody><tr>
<td>○ sysCode</td>
<td style="text-align: right;">
</td>
</tr></tbody></table>



	<c:forEach var="p" items="${SQL.rows}" varStatus="s">
		<table class="sysCode" data-id="sysCode_id"  data-value="${p.sysCode_id}" data-action="U" style="width: 100%;">
			<tbody>
				<tr>
				<td>groupCode</td>
				<td><input type="text" name="groupCode" class=" groupCode" value="${p.groupCode}" maxlength="20"/></td>
				</tr>
				<tr>
				<td>groupName</td>
				<td><input type="text" name="groupName" class=" groupName" value="${p.groupName}" maxlength="50"/></td>
				</tr>
				<tr>
				<td>useYn</td>
				<td><select name="useYn" class="sysCode useYn yn"><c:set var="tmp" value="${p.useYn}"/><%= ob_yn.getHtmlCombo((String) pageContext.getAttribute("tmp"), 0) %></select></td>
				</tr>
				<tr>
				<td></td>
				<td><input type="button" value="저장"  class="btnSave-sysCode"/></td>
				</tr>
			</tbody>
		</table>
	</c:forEach>
