<%-- ----------------------------------------------------------------------------
DESCRIPTION : 
   JSP-NAME : user-upsert.jsp
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

String LOCAL_CRYPT_KEY = application.getInitParameter("LOCAL_CRYPT_KEY");
%>

<log:setLogger logger="user-upsert.jsp"/>
<sql:setDataSource dataSource="jdbc/db" />
<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="today"/>




<log:info><c:forEach var="action" items="${paramValues.action}" varStatus="s">
[${s.index}][${paramValues.action[s.index]}]------------------------------------------------------
aUser_id=[${paramValues.aUser_id[s.index]}]
	     user_id=[${paramValues.user_id[s.index]}]
	      emp_no=[${paramValues.emp_no[s.index]}]
	      emp_nm=[${paramValues.emp_nm[s.index]}]
	     team_nm=[${paramValues.team_nm[s.index]}]
	  pos_grd_nm=[${paramValues.pos_grd_nm[s.index]}]
	       phone=[${paramValues.phone[s.index]}]
	       email=[${paramValues.email[s.index]}]
	    hire_ymd=[${paramValues.hire_ymd[s.index]}]
	  retire_ymd=[${paramValues.retire_ymd[s.index]}]
	emp_state_cd=[${paramValues.emp_state_cd[s.index]}]
	        note=[${paramValues.note[s.index]}]
	      use_yn=[${paramValues.use_yn[s.index]}]
	         pwd=[${paramValues.pwd[s.index]}]
	 pwd_end_ymd=[${paramValues.pwd_end_ymd[s.index]}]
	 pwd_sta_ymd=[${paramValues.pwd_sta_ymd[s.index]}]
	pwd_fail_cnt=[${paramValues.pwd_fail_cnt[s.index]}]
	 pwd_temp_yn=[${paramValues.pwd_temp_yn[s.index]}]
</c:forEach>------------------------------------------------------</log:info>

<sql:transaction>
	<c:forEach var="action" items="${paramValues.action}" varStatus="s">
	<c:choose>
	<c:when test="${action eq 'N' or action eq 'C'}">
	
	
	

	<c:choose><c:when test="${not empty paramValues.pwd[s.index]}"> 
		<sql:update>
		insert	into user (emp_no, emp_nm, team_nm, pos_grd_nm, phone, email, hire_ymd, retire_ymd, emp_state_cd, note, use_yn, pwd, pwd_end_ymd, pwd_sta_ymd, pwd_fail_cnt, pwd_temp_yn)
		values
		(
				?			<sql:param value="${paramValues.emp_no[s.index]}"/>
			,	?			<sql:param value="${paramValues.emp_nm[s.index]}"/>
			,	?			<sql:param value="${paramValues.team_nm[s.index]}"/>
			,	?			<sql:param value="${paramValues.pos_grd_nm[s.index]}"/>
			,	?			<sql:param value="${paramValues.phone[s.index]}"/>
			,	?			<sql:param value="${paramValues.email[s.index]}"/>
			,	STR_TO_DATE(? , '%Y-%m-%d %T')		<sql:param value="${empty paramValues.hire_ymd[s.index] ? today : paramValues.hire_ymd[s.index]}"/>
			,	STR_TO_DATE(? , '%Y-%m-%d %T')		<sql:param value="${empty paramValues.retire_ymd[s.index] ? '2999-12-31' : paramValues.retire_ymd[s.index]}"/>
			,	?			<sql:param value="${paramValues.emp_state_cd[s.index]}"/>
			,	?			<sql:param value="${paramValues.note[s.index]}"/>
			,	?			<sql:param value="${paramValues.use_yn[s.index]}"/>
		
			,	HEX(AES_ENCRYPT(?, ?)			<sql:param value="${paramValues.pwd[s.index]}"/><sql:param value="<%=LOCAL_CRYPT_KEY%>"/>
			,	'2999-12-31'	-- pwd_end_ymd
			,	date(now())		-- pwd_sta_ymd
			,	0				-- pwd_fail_cnt
			,	'N'				-- pwd_temp_yn
		)
		</sql:update>

	</c:when><c:otherwise>
		<sql:update>
		insert	into user (emp_no, emp_nm, team_nm, pos_grd_nm, phone, email, hire_ymd, retire_ymd, emp_state_cd, note, use_yn, pwd, pwd_end_ymd, pwd_sta_ymd, pwd_fail_cnt, pwd_temp_yn)
		values
		(
				?			<sql:param value="${paramValues.emp_no[s.index]}"/>
			,	?			<sql:param value="${paramValues.emp_nm[s.index]}"/>
			,	?			<sql:param value="${paramValues.team_nm[s.index]}"/>
			,	?			<sql:param value="${paramValues.pos_grd_nm[s.index]}"/>
			,	?			<sql:param value="${paramValues.phone[s.index]}"/>
			,	?			<sql:param value="${paramValues.email[s.index]}"/>
			,	STR_TO_DATE(? , '%Y-%m-%d %T')		<sql:param value="${empty paramValues.hire_ymd[s.index] ? today : paramValues.hire_ymd[s.index]}"/>
			,	STR_TO_DATE(? , '%Y-%m-%d %T')		<sql:param value="${empty paramValues.retire_ymd[s.index] ? '2999-12-31' : paramValues.retire_ymd[s.index]}"/>
			,	?			<sql:param value="${paramValues.emp_state_cd[s.index]}"/>
			,	?			<sql:param value="${paramValues.note[s.index]}"/>
			,	?			<sql:param value="${paramValues.use_yn[s.index]}"/>
		
			,	null
			,	DATE_ADD(DATE(NOW()), interval -1 day) -- pwd_end_ymd
			,	DATE_ADD(DATE(NOW()), interval -1 day) -- pwd_sta_ymd
			,	0										-- pwd_fail_cnt
			,	'Y'										-- pwd_temp_yn
		)
		</sql:update>
	</c:otherwise>
	</c:choose>	
		


		<sql:query var="SQL">select last_insert_id() </sql:query>

		<c:set var="code"	value="0"/>
		<c:set var="mesg"	value="등록 되었습니다."/>
		<c:set var="id"		value="user_id"/>
		<c:set var="value"	value="${SQL.rowsByIndex[0][0]}"/>


	</c:when><c:when test="${action eq 'U'}">
			<sql:update>
			update	user
			   set	      emp_no = ?			<sql:param value="${paramValues.emp_no[s.index]}"/>
				,	      emp_nm = ?			<sql:param value="${paramValues.emp_nm[s.index]}"/>
				,	     team_nm = ?			<sql:param value="${paramValues.team_nm[s.index]}"/>
				,	  pos_grd_nm = ?			<sql:param value="${paramValues.pos_grd_nm[s.index]}"/>
				,	       phone = ?			<sql:param value="${paramValues.phone[s.index]}"/>
				,	       email = ?			<sql:param value="${paramValues.email[s.index]}"/>
				,	    hire_ymd = STR_TO_DATE(? , '%Y-%m-%d %T')		<sql:param value="${empty paramValues.hire_ymd[s.index] ? today : paramValues.hire_ymd[s.index]}"/>
				,	  retire_ymd = STR_TO_DATE(? , '%Y-%m-%d %T')		<sql:param value="${empty paramValues.retire_ymd[s.index] ? today : paramValues.retire_ymd[s.index]}"/>
				,	emp_state_cd = ?			<sql:param value="${paramValues.emp_state_cd[s.index]}"/>
				,	        note = ?			<sql:param value="${paramValues.note[s.index]}"/>
				,	      use_yn = ?			<sql:param value="${paramValues.use_yn[s.index]}"/>
			 where	     user_id = ?				<sql:param value="${paramValues.user_id[s.index]}"/>
			</sql:update>
			
			
			<c:if test="${not empty paramValues.pwd[s.index]}">
				<sql:update>
				update	user
				   set	         pwd = HEX(AES_ENCRYPT(?, ?)			<sql:param value="${paramValues.pwd[s.index]}"/><sql:param value="<%=LOCAL_CRYPT_KEY%>"/>
					,	 pwd_end_ymd = case when ? = 'Y' then DATE(NOW()) else '2999-12-31'	end    <sql:param value="${paramValues.pwd_temp_yn[s.index]}"/>
					,	 pwd_sta_ymd = date(now())		-- pwd_sta_ymd
					,	pwd_fail_cnt = 0
					,	 pwd_temp_yn = ?			<sql:param value="${paramValues.pwd_temp_yn[s.index]}"/>
				 where	     user_id = ?			<sql:param value="${paramValues.user_id[s.index]}"/>
				</sql:update>
			</c:if> 
			
			
			<c:set var="code"	value="0"/>
			<c:set var="mesg"	value="수정 되었습니다."/>
			<c:set var="id"		value="user_id"/>
			<c:set var="value"	value="${paramValues.user_id[s.index]}"/>


	</c:when><c:when test="${action eq 'D'}">
			<sql:update>
			delete	from user
			 where	user_id = ?		<sql:param value="${paramValues.user_id[s.index]}"/>
			</sql:update>
		
			<c:set var="code"	value="0"/>
			<c:set var="mesg"	value="삭제 되었습니다."/>
			<c:set var="id"		value="user_id"/>
			<c:set var="value"	value="${paramValues.user_id[s.index]}"/>


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
{"code":"${code}",  "mesg":"${mesg}",   "action":"",   "id":"${id}",  "value":"${value}"}
