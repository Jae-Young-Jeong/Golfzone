<%-- ----------------------------------------------------------------------------
DESCRIPTION :
   JSP-NAME : sysSqlDtl-modify.jsp
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

<log:setLogger logger="sysSqlDtl-modify.jsp"/>
<sql:setDataSource dataSource="jdbc/db" />
<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="today"/>


<log:info>필수파라미터
param.sysSqlDtl_id=[${param.sysSqlDtl_id}]
</log:info>




<sql:query var="SQL">
select	CAST(M.sysSqlDtl_id as char) AS sysSqlDtl_id
	,	FORMAT(M.sysSqlDtl_id, 0)  AS str_sysSqlDtl_id
	,	CAST(M.sysSql_id as char) AS sysSql_id
	,	FORMAT(M.sysSql_id, 0)  AS str_sysSql_id
	,	DATE_FORMAT(M.sta_ymd, '%Y-%m-%d') AS sta_ymd
	,	DATE_FORMAT(M.end_ymd, '%Y-%m-%d') AS end_ymd
	,	M.sqlText
  from	sysSqlDtl M
 where	date(now()) between M.sta_ymd and M.end_ymd
     <c:if test="${not empty param.sysSql_id}">
   and	M.sysSql_id = ?									<sql:param value="${param.sysSql_id}"/>
</c:if>
</sql:query>



<%--
		<input type="button" class="btnNew-sysSqlDtl" value="추가"/>
--%>






<c:choose>
<c:when test="${SQL.rowCount > 0}">
	<c:forEach var="p" items="${SQL.rows}" varStatus="s">
		<table class="sysSqlDtl" data-id="sysSqlDtl_id" data-value="${param.sysSqlDtl_id}" data-action="U"  style="width: 100%; height: 100%;">
		<tbody>
			<tr style="height: 30px">
				<td> ▶sysSqlDtl</td>
				<td class="tar">
					<input type="button" class="btnSave-sysSqlDtl" value="저장"/>
				</td>

			</tr><tr style="height: 30px;">
				<td colspan="2">
					sysSql_id=${p.sysSql_id}, sysSqlDtl_id=${p.sysSqlDtl_id}, ${p.sta_ymd} ~ ${p.end_ymd}
					<input type="hidden" name="sysSql_id" value="${p.sysSql_id}"/>
					<input type="hidden" name="sta_ymd"    value="${today}"/>
					<input type="hidden" name="end_ymd"    value="2999-12-31"/>
				</td>
			</tr><tr>
				<td colspan="2"><textarea name="sqlText" style="width: 100%; height: 100%; border: 0.1px solid black;" >${p.sqlText}</textarea></td>
			</tr>
		</tbody></table>
	</c:forEach>


</c:when><c:otherwise>
		<table class="sysSqlDtl" data-id="sysSqlDtl_id" data-value="" data-action="N"  style="width: 100%; height: 100%;">
		<tbody>
			<tr style="height: 30px">
				<td> ▶sysSqlDtl</td>
				<td class="tar">
					<input type="button" class="btnSave-sysSqlDtl" value="저장"/>
				</td>

			</tr><tr style="height: 30px;">
				<td colspan="2">
					sysSql_id=${param.sysSql_id}, new
					<input type="hidden" name="sysSql_id" value="${param.sysSql_id}"/>
					<input type="hidden" name="sta_ymd"    value="${today}"/>
					<input type="hidden" name="end_ymd"    value="2999-12-31"/>
					
				</td>
			</tr><tr>
				<td colspan="2"><textarea name="sqlText" style="width: 100%; height: 100%; border: 0.1px solid black;" >${p.sqlText}</textarea></td>
			</tr>
		</tbody>
		</table>


</c:otherwise>
</c:choose>

