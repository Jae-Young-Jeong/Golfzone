<%-- ----------------------------------------------------------------------------
DESCRIPTION :
   JSP-NAME : sysCodeDtl-upsert.jsp
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

<log:setLogger logger="sysCodeDtl-upsert.jsp"/>
<sql:setDataSource dataSource="jdbc/db" />
<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="today"/>


<log:info><c:forEach var="action" items="${paramValues.action}" varStatus="s">
[${s.index}][${paramValues.action[s.index]}]------------------------------------------------------
sysCodeDtl_id=${paramValues.sysCodeDtl_id[s.index]}
    groupCode=${paramValues.groupCode[s.index]}
           cd=${paramValues.cd[s.index]}
           nm=${paramValues.nm[s.index]}
 optGroupName=${paramValues.optGroupName[s.index]}
      sta_ymd=${paramValues.sta_ymd[s.index]}
      end_ymd=${paramValues.end_ymd[s.index]}
</c:forEach>------------------------------------------------------</log:info>


<c:set var="code"  value="0"/>
<sql:transaction>
	<c:forEach var="action" items="${paramValues.action}" varStatus="s">
	<c:choose>
	<c:when test="${action eq 'N' or action eq 'C'}">
		<sql:update>
		insert	into sysCodeDtl (groupCode, cd, nm, optGroupName, sta_ymd, end_ymd)
		values
		(
				?			<sql:param value="${paramValues.groupCode[s.index]}"/>
			,	?			<sql:param value="${paramValues.cd[s.index]}"/>
			,	?			<sql:param value="${paramValues.nm[s.index]}"/>
			,	?			<sql:param value="${paramValues.optGroupName[s.index]}"/>
			,	STR_TO_DATE(? , '%Y-%m-%d %T')		<sql:param value="${empty paramValues.sta_ymd[s.index] ? today : paramValues.sta_ymd[s.index]}"/>
			,	STR_TO_DATE(? , '%Y-%m-%d %T')		<sql:param value="${empty paramValues.end_ymd[s.index] ? '2999-12-31' : paramValues.end_ymd[s.index]}"/>
		)
		</sql:update>
		<sql:query var="SQL">select last_insert_id() </sql:query>

		<c:set var="id"    value="sysCodeDtl_id"/>
		<c:set var="value" value="${SQL.rowsByIndex[0][0]}"/>



	</c:when><c:when test="${action eq 'U' }">
<%--
<sql:update>
update	sysCodeDtl
   set	   groupCode = ?			<sql:param value="${paramValues.groupCode[s.index]}"/>
	,	           cd = ?			<sql:param value="${paramValues.cd[s.index]}"/>
	,	           nm = ?			<sql:param value="${paramValues.nm[s.index]}"/>
	,	 optGroupName = ?			<sql:param value="${paramValues.optGroupName[s.index]}"/>
	,	      sta_ymd = STR_TO_DATE(? , '%Y-%m-%d %T')		<sql:param value="${empty paramValues.sta_ymd[s.index] ? today : paramValues.sta_ymd[s.index]}"/>
	,	      end_ymd = STR_TO_DATE(? , '%Y-%m-%d %T')		<sql:param value="${empty paramValues.end_ymd[s.index] ? '2999-12-31' : paramValues.end_ymd[s.index]}"/>
 where	sysCodeDtl_id = ?				<sql:param value="${paramValues.sysCodeDtl_id[s.index]}"/>
</sql:update>
--%>

		<sql:update>
		update	sysCodeDtl
		   set	end_ymd = date_add(date(now()), interval -1 day)
		 where	groupCode 	= ?			<sql:param value="${paramValues.groupCode[s.index]}"/>
		   and	date(now()) between sta_ymd and end_ymd
		   and	cd 			= ?			<sql:param value="${paramValues.cd[s.index]}"/>
		   and	sta_ymd     < date(now())
		</sql:update>


		<sql:update>
		delete	from sysCodeDtl
		 where	groupCode 	= ?			<sql:param value="${paramValues.groupCode[s.index]}"/>
		   and	date(now()) between sta_ymd and end_ymd
		   and	cd 			= ?			<sql:param value="${paramValues.cd[s.index]}"/>
		   and	sta_ymd     = date(now())
		</sql:update>


		<sql:update>
		insert	into sysCodeDtl (groupCode, cd, nm, optGroupName, sta_ymd, end_ymd)
		values
		(		?			<sql:param value="${paramValues.groupCode[s.index]}"/>
			,	?			<sql:param value="${paramValues.cd[s.index]}"/>
			,	?			<sql:param value="${paramValues.nm[s.index]}"/>
			,	?			<sql:param value="${paramValues.optGroupName[s.index]}"/>
			,	STR_TO_DATE(? , '%Y-%m-%d %T')		<sql:param value="${empty paramValues.sta_ymd[s.index] ? today : paramValues.sta_ymd[s.index]}"/>
			,	STR_TO_DATE(? , '%Y-%m-%d %T')		<sql:param value="${empty paramValues.end_ymd[s.index] ? '2999-12-31' : paramValues.end_ymd[s.index]}"/>
		)
		</sql:update>


		<sql:query var="SQL">select last_insert_id() </sql:query>
		<c:set var="id"    value="sysCodeDtl_id"/>
		<c:set var="value" value="${SQL.rowsByIndex[0][0]}"/>


		<sql:query var="SQL">
		select	sysCodeDtl_id
			,	date_format(sta_ymd, '%Y-%m-%d') AS sta_ymd
		  from	sysCodeDtl
		 where	groupCode = ?			<sql:param value="${paramValues.groupCode[s.index]}"/>
		   and	cd         = ?			<sql:param value="${paramValues.cd[s.index]}"/>
		 order	by sta_ymd desc
		</sql:query>
		<c:forEach var="p" items="${SQL.rows}" varStatus="s">
			<c:if test="${s.first}">
				<c:set var="old_sta_ymd" value="${p.sta_ymd}"/>
			</c:if><c:if test="${not s.first}">
				<sql:update>
				update	sysCodeDtl
				   set	end_ymd = date_add(str_to_date(?, '%Y-%m-%d'), interval -1 day ) 	<sql:param value="${old_sta_ymd}"/>
				 where	sysCodeDtl_id = ${p.sysCodeDtl_id}
				</sql:update>
				<c:set var="old_sta_ymd" value="${p.sta_ymd}"/>
			</c:if>
		</c:forEach>








	</c:when><c:when test="${action eq 'D'}">
		<sql:update>
		delete	from sysCodeDtl
		 where	sysCodeDtl_id = ?		<sql:param value="${paramValues.sysCodeDtl_id[s.index]}"/>
		</sql:update>

		<c:set var="id"    value="sysCodeDtl_id"/>
		<c:set var="value" value="${paramValues.sysCodeDtl_id[s.index]}"/>


	</c:when><c:otherwise>
		<log:info>알수없는 action[${action}] 유형입니다.</log:info>
		<c:set var="id"    value="sysCodeDtl_id"/>
		<c:set var="value" value="${paramValues.sysCodeDtl_id[s.index]}"/>
		<c:set var="code"  value="1"/>
		<c:set var="mesg"  value="${mesg}[${s.count}]알수없는 action[${action}] 유형입니다."/>


	</c:otherwise>
	</c:choose>
	</c:forEach>
</sql:transaction>


{ "code": "${code}", "mesg":"${empty mesg ? '적용 되었습니다' : mesg}", "id":"${id}", "value":"${value}"}