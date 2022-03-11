<%-- ----------------------------------------------------------------------------
DESCRIPTION :
   JSP-NAME : sysSql-new.jsp
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

<log:setLogger logger="sysSql-table-list.jsp"/>
<sql:setDataSource dataSource="jdbc/db" />
<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="today"/>



<%
MyOptionBuilder ob_useYn = new MyOptionBuilder("ynType");
%>


<table style="width: 100%; " ><tbody><tr>
<td>○ sysSql</td>
<td style="text-align: right;">
</td>
</tr></tbody></table>


		<table class="type3 sysSql" data-id="sysSql_id" data-value="" data-action="N" style="width: 100%;">
			<tbody>
				<tr>
				<td>sqlid</td>
				<td><input type="text" name="sqlid" class=" sqlid" value="${p.sqlid}" maxlength="50"/></td>
				</tr>
				<tr>
				<td>sqlnm</td>
				<td><input type="text" name="sqlnm" class=" sqlnm" value="${p.sqlnm}" maxlength="150"/></td>
				</tr>
				<tr>
				<td>useYn</td>
				<td><select name="useYn" class="sysSql useYn "><c:set var="tmp" value="${p.useYn}"/><%= ob_useYn.getHtmlCombo((String) pageContext.getAttribute("tmp"), 0) %></select></td>
				</tr>
				<tr>
				<td></td>
				<td><input type="button" value="저장"  class="btnSave-sysSql"/></td>
				</tr>
			</tbody>
		</table>