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

			<sql:update>
			insert	into project (project_cd, project_nm, sta_ymd, end_ymd, use_yn, tech_note, memo_note, mod_date)
			values
			(
				?			<sql:param value="${param.project_cd}"/>
			,	?			<sql:param value="${param.project_nm}"/>
			,	STR_TO_DATE(? , '%Y-%m-%d %T')		<sql:param value="${empty param.sta_ymd ? today        : param.sta_ymd}"/>
			,	STR_TO_DATE(? , '%Y-%m-%d %T')		<sql:param value="${empty param.end_ymd ? '2999-12-31' : param.end_ymd}"/>
			,	?			<sql:param value="${empty param.use_yn ? 'Y' : param.use_yn}"/>
			,	?			<sql:param value="${param.tech_note}"/>
			,	?			<sql:param value="${param.memo_note}"/>
			,	NOW()
			)
			ON DUPLICATE KEY UPDATE
				project_nm = ?			<sql:param value="${param.project_nm}"/>
			,	   sta_ymd = STR_TO_DATE(? , '%Y-%m-%d %T')		<sql:param value="${empty param.sta_ymd ? today        : param.sta_ymd}"/>
			,	   end_ymd = STR_TO_DATE(? , '%Y-%m-%d %T')		<sql:param value="${empty param.end_ymd ? '2999-12-31' : param.end_ymd}"/>
			,	    use_yn = ?			<sql:param value="${empty param.use_yn ? 'Y' : param.use_yn}"/>
			,	 tech_note = ?			<sql:param value="${param.tech_note}"/>
			,	 memo_note = ?			<sql:param value="${param.memo_note}"/>
			</sql:update>

			<c:set var="code"	value="0"/>
			<c:set var="mesg"	value="수정 되었습니다."/>
			<c:set var="id"		value="project_cd"/>
			<c:set var="value"	value="${paramValues.project_cd[s.index]}"/>


			<sql:update var="rows">
			delete from user_project where project_cd = ?			<sql:param value="${param.project_cd}"/>
			</sql:update>
			
			
			<c:forEach var="user_id" items="${paramValues.user_id}" varStatus="s">
				<sql:update>
				insert into user_project(project_cd, user_id, sta_ymd, end_ymd, mod_date) 
				values(
					?								<sql:param value="${param.project_cd}"/>
				,	?								<sql:param value="${user_id}"/>
				,	str_to_date(?, '%Y-%m-%d')  	<sql:param value="${empty paramValues.sta_ymd[s.index] ? today : paramValues.sta_ymd[s.index]}"/>
				,	str_to_date(?, '%Y-%m-%d')  	<sql:param value="${empty paramValues.end_ymd[s.index] ? today : paramValues.end_ymd[s.index]}"/>
				,	NOW()
				)
				</sql:update>
				 
			</c:forEach>

</sql:transaction>
{"code":"0",  "mesg":"저장 되었습니다.", "project_cd":"${param.project_cd}"}
