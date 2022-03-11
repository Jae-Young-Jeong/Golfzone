<%-- ----------------------------------------------------------------------------
DESCRIPTION :
   JSP-NAME : sysSqlDtl-new.jsp
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

<log:setLogger logger="sysSqlDtl-new.jsp"/>
<sql:setDataSource dataSource="jdbc/db" />
<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="today"/>


<log:info> 파라미터 필수 값.
param.sysSql_id = ${param.sysSql_id}
</log:info>






<tr class="addnew" data-id="sysSqlDtl_id" data-value="" data-action="N">
	<td></td>
	<td><input type="checkbox" class="chkBtnDel"/></td>
	<td class="sysSqlDtl sysSqlDtl_id"><input type="text" name="sysSqlDtl_id" class=" sysSqlDtl_id" value="${p.sysSqlDtl_id}" maxlength=""/></td>
	<td class="sysSqlDtl sysSql_id"><input type="text" name="sysSql_id" class=" sysSql_id" value="${p.sysSql_id}" maxlength=""/></td>
	<td class="sysSqlDtl sta_ymd"><input type="text" name="sta_ymd" class=" sta_ymd" value="${p.sta_ymd}" maxlength=""/></td>
	<td class="sysSqlDtl end_ymd"><input type="text" name="end_ymd" class=" end_ymd" value="${p.end_ymd}" maxlength=""/></td>
	<td class="sysSqlDtl sqlText"><input type="text" name="sqlText" class=" sqlText" value="${p.sqlText}" maxlength="4000"/></td>
</tr>