<%-- ----------------------------------------------------------------------------
DESCRIPTION :
   JSP-NAME : sysCodeDtl-new.jsp
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

<log:setLogger logger="sysCodeDtl-new.jsp"/>
<sql:setDataSource dataSource="jdbc/db" />
<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="today"/>


<log:info>  
param.groupCode = ${param.groupCode}
</log:info>


<%
%>



<tr class="addnew" data-id="sysCodeDtl_id" data-value="" data-action="N" data-groupCode="${param.groupCode}">
	<td></td>
	<td><input type="checkbox" class="chkBtnDel"/></td>
	<td class="sysCodeDtl cd"><input type="text" name="cd" class=" cd" value="${p.cd}" maxlength="12"/></td>
	<td class="sysCodeDtl nm"><input type="text" name="nm" class=" nm" value="${p.nm}" maxlength="50"/></td>
	<td class="sysCodeDtl optGroupName"><input type="text" name="optGroupName" class=" optGroupName" value="${p.optGroupName}" maxlength="150"/></td>
	<td class="sysCodeDtl sta_ymd"><input type="text" name="sta_ymd" class=" sta_ymd" value="${p.sta_ymd}" maxlength=""/></td>
	<td class="sysCodeDtl end_ymd"><input type="text" name="end_ymd" class=" end_ymd" value="${p.end_ymd}" maxlength=""/></td>
</tr>