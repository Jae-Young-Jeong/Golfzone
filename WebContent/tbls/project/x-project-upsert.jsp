<%-- ----------------------------------------------------------------------------
DESCRIPTION : 
   JSP-NAME : project-upsert.jsp
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

<log:setLogger logger="project-upsert.jsp"/>
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
	<c:forEach var="action" items="${paramValues.action}" varStatus="s">
	<c:choose>
	<c:when test="${action eq 'N' or action eq 'C'}">
			<sql:update>
			insert	into project (project_cd, project_nm, sta_ymd, end_ymd, use_yn, tech_note, memo_note, mod_date)
			values
			(
					?			<sql:param value="${paramValues.project_cd[s.index]}"/>
				,	?			<sql:param value="${paramValues.project_nm[s.index]}"/>
				,	STR_TO_DATE(? , '%Y-%m-%d %T')		<sql:param value="${empty paramValues.sta_ymd[s.index] ? today : paramValues.sta_ymd[s.index]}"/>
				,	STR_TO_DATE(? , '%Y-%m-%d %T')		<sql:param value="${empty paramValues.end_ymd[s.index] ? '2999-12-31' : paramValues.end_ymd[s.index]}"/>
				,	?			<sql:param value="${empty paramValues.use_yn[s.index] ? 'Y' : paramValues.use_yn[s.index]}"/>
				,	?			<sql:param value="${paramValues.tech_note[s.index]}"/>
				,	?			<sql:param value="${paramValues.memo_note[s.index]}"/>
				,	NOW()
			)
			</sql:update>

			<sql:query var="SQL">select last_insert_id() </sql:query>
	
			<c:set var="code"	value="0"/>
			<c:set var="mesg"	value="등록 되었습니다."/>
			<c:set var="id"		value="project_cd"/>
			<c:set var="value"	value="${paramValues.project_cd[s.index]}"/>


	</c:when><c:when test="${action eq 'U'}">
			<sql:update>
			update	project
			   set	  mod_date = NOW()
				,	project_nm = ?			<sql:param value="${paramValues.project_nm[s.index]}"/>
				,	   sta_ymd = STR_TO_DATE(? , '%Y-%m-%d %T')		<sql:param value="${empty paramValues.sta_ymd[s.index] ? today : paramValues.sta_ymd[s.index]}"/>
				,	   end_ymd = STR_TO_DATE(? , '%Y-%m-%d %T')		<sql:param value="${empty paramValues.end_ymd[s.index] ? '2999-12-31' : paramValues.end_ymd[s.index]}"/>
				,	    use_yn = ?			<sql:param value="${paramValues.use_yn[s.index]}"/>
				,	 tech_note = ?			<sql:param value="${paramValues.tech_note[s.index]}"/>
				,	 memo_note = ?			<sql:param value="${paramValues.memo_note[s.index]}"/>
			 where	project_cd = ?			<sql:param value="${paramValues.project_cd[s.index]}"/>
			</sql:update>

			<c:set var="code"	value="0"/>
			<c:set var="mesg"	value="수정 되었습니다."/>
			<c:set var="id"		value="project_cd"/>
			<c:set var="value"	value="${paramValues.project_cd[s.index]}"/>


	</c:when><c:when test="${action eq 'D'}">
			<sql:update>
			delete	from project
			 where	project_cd = ?		<sql:param value="${paramValues.project_cd[s.index]}"/>
			</sql:update>
			<c:set var="code"	value="0"/>
			<c:set var="mesg"	value="삭제 되었습니다."/>
			<c:set var="id"		value="project_cd"/>
			<c:set var="value"	value="${paramValues.project_cd[s.index]}"/>


	</c:when><c:otherwise>
			<c:set var="code"	value="1"/>
			<c:set var="mesg"	value="알수없는 action[${action}] 유형입니다."/>
			<c:set var="id"		value="user_id"/>
			<c:set var="value"	value="${paramValues.user_id[s.index]}"/>
			<log:info>${mesg}</log:info>
			{"code":"${code}",  "mesg":"${mesg}",   "action":"",   "id":"${id}",  "value":"${value}"}
			<%
				if(true) return;
			%>

	</c:otherwise>
	</c:choose>
	</c:forEach>
</sql:transaction>
