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

	<c:set var="emptyCnt"  value="0"/>
	<c:set var="updateCnt" value="0"/>
	
	<c:forEach var="user_id" items="${paramValues.user_id}" varStatus="s">
		<c:if test="${empty paramValues.pwd[s.index]}">
			<c:set var="emptyCnt" value="${emptyCnt+1}"/>
		</c:if>
		<c:set var="updateCnt" value="${updateCnt + 1}"/>
	</c:forEach>

<c:if test="${updateCnt eq 0}">
	{"code": "1", "mesg":"수정 내역이 없습니다."}
	<%	if(true) return; %>
</c:if>


<c:if test="${emptyCnt > 0}">
	{"code": "1", "mesg":"비밀번호가 없는 경우가 있습니다."}
	<%	if(true) return; %>
</c:if>








<sql:transaction>
	<c:forEach var="user_id" items="${paramValues.user_id}" varStatus="s">

			<sql:update>
			update	user
			   set	         pwd = HEX(AES_ENCRYPT(?, ?)			<sql:param value="${paramValues.pwd[s.index]}"/><sql:param value="<%=LOCAL_CRYPT_KEY%>"/>
				,	 pwd_end_ymd = case when ? = 'Y' then DATE(NOW()) else '2999-12-31'	end    <sql:param value="${paramValues.pwd_temp_yn[s.index]}"/>
				,	 pwd_sta_ymd = date(now())		-- pwd_sta_ymd
				,	pwd_fail_cnt = 0
				,	 pwd_temp_yn = ?			<sql:param value="${paramValues.pwd_temp_yn[s.index]}"/>
			 where	     user_id = ?			<sql:param value="${paramValues.user_id[s.index]}"/>
			</sql:update>
			
			<c:set var="code"	value="0"/>
			<c:set var="mesg"	value="수정 되었습니다."/>
			<c:set var="id"		value="user_id"/>
			<c:set var="value"	value="${paramValues.user_id[s.index]}"/>
			
	</c:forEach>
</sql:transaction>
{"code":"${code}",  "mesg":"${mesg}",   "action":"",   "id":"${id}",  "value":"${value}"}
