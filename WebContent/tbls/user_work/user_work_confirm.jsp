<%-- ----------------------------------------------------------------------------
DESCRIPTION : 권한자(팀장, 원장) 이  본인또는 하위 사원이 등록한 내역을 승인(confirm)한다.
   JSP-NAME : user_work-confirm.jsp
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

<log:setLogger logger="user_work-confirm.jsp"/>
<sql:setDataSource dataSource="jdbc/db" />
<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="today"/>


<log:info> user_work  confirm -----------------------------
confirm_user_id=[${sessionScope.login_user_id}] login user id
 
   user_id=[${param.user_id}]
project_id=[${param.project_id}]
   sta_ymd=[${param.sta_ymd}]
   end_ymd=[${param.end_ymd}]
----------------------------------------------------------</log:info>





<sql:transaction>

<%-- -------------------------------------------------------------------------------------- --%>
<c:set var="v_trace_msg" value="0. 승인 이력을 생성  "/>
<%-- -------------------------------------------------------------------------------------- --%>
<sql:update var="rows">
insert into confirm_history (project_id, user_id, confirm_user_id, confirm_date, mod_date)
values( 
	?			<sql:param value="${param.project_id}"/>
,	?			<sql:param value="${param.user_id}"/>
,	?			<sql:param value="${sessionScope.login_user_id}"/>
,	NOW()
,	NOW()
)
</sql:update>

<sql:query var="SQL">select last_insert_id() </sql:query>
<c:set var="confirm_history_id" value="${SQL.rowsByIndex[0][0]}"/>

<log:info>${v_trace_msg} confirm_history_id=${confirm_history_id},  rows=${rows}</log:info>

<%-- -------------------------------------------------------------------------------------- --%>
<c:set var="v_trace_msg" value="1.tmp_confirm_target clear "/>
<%-- -------------------------------------------------------------------------------------- --%>
<sql:update var="rows">
truncate table tmp_confirm_target where confirm_user_id = ? <sql:param value="${sessionScope.login_user_id}"/>
</sql:update>

<log:info>${v_trace_msg} rows=${rows}</log:info>


<%-- -------------------------------------------------------------------------------------- --%>
<c:set var="v_trace_msg" value="2.tmp_confirm_target insert"/>
<%-- -------------------------------------------------------------------------------------- --%>
<sql:update var="tmp_confirm_target_rows">
insert into tmp_confirm_target(confirm_user_id, project_id, user_id, base_ymd, reg_date)
select	?	as confirm_user_id			<sql:param value="${sessionScope.login_user_id}"/>
	,	WK.project_id
	,	WK.user_id
	,	WK.base_ymd
	,	NOW()			as reg_date

  from	user_work		WK
  join	(
			-- 내 하위 사람 + 상위결재자 
			select	M.user_id
				,	row_number() over( order by  case when M.pos_grd_nm = '원장'   then 1  else 2 end, M.team_nm,  case when M.pos_grd_nm = '팀장'   then 2  else 3 end, M.emp_nm) as rank_no
				,	case 
					when M0.pos_grd_nm = '원장'                            then 1 
					when M0.pos_grd_nm = '팀장' and M0.team_nm = M.team_nm then 1 
					when M0.user_id = M.user_id                            then 1 
					else 0 
					end  as check_flag
				,	case 
					when M.user_id  = WJ.user_id then null
					when M.pos_grd_nm = '팀장'    then WJ.user_id
					when M.pos_grd_nm not in ('원장', '팀장') then TM.user_id
					else NULL
					end	as p_user_id
			  from	user M
			  left	join
					(
						-- 팀장구하기
						select	team_nm, user_id
						  from	user T
						 where	str_to_date(? , '%Y-%m-%d')  between T.hire_ymd and IFNULL(T.retire_ymd,'2999-12-31') 		<sql:param value="${param.base_ymd}"/>
						   and	T.pos_grd_nm = '팀장'

					) TM on (TM.team_nm = M.team_nm)
			  left	join
					(
						-- 원장구하기 
						select	team_nm, user_id
						  from	user T
						 where	str_to_date(? , '%Y-%m-%d')  between T.hire_ymd and IFNULL(T.retire_ymd,'2999-12-31') 		<sql:param value="${param.base_ymd}"/>
						   and	T.pos_grd_nm = '원장'
			
					) WJ on (1=1)
			  join	(
						select	user_id, pos_grd_nm, team_nm
						  from	user
						 where	user_id = ?									<sql:param value="${sessionScope.login_user_id}"/>
					) M0 on (1=1)
			
			 where	case 
					when M0.pos_grd_nm = '원장'                            then 1 
					when M0.pos_grd_nm = '팀장' and M0.team_nm = M.team_nm then 1 
					when M0.user_id = M.user_id                            then 1 
					else 0 
					end	 = 1
			   and	not (? = WJ.user_id and M.user_id = ?  )				<sql:param value="${sessionScope.login_user_id}"/><sql:param value="${sessionScope.login_user_id}"/>

		) TD on (TD.user_id = WK.user_id)

 where	WK.project_id = ?			<sql:param value="${param.project_id}"/>
   and	WK.user_id    = ?			<sql:param value="${param.user_id}"/>
   and	WK.base_ymd between   date_add(str_to_date(? , '%Y-%m-%d'), interval -6 day) and  date_add(  str_to_date(? , '%Y-%m-%d')  , interval 7 day)		<sql:param value="${param.base_ymd}"/><sql:param value="${param.base_ymd}"/>
   and	case 
		when  WK.confirm_user_id = ?    then 1	-- 내가 승인한 상태라면 수정 가능									<sql:param value="${sessionScope.login_user_id}"/>
		when  TD.p_user_id       = ?    then 1	-- 승인한 상위 조직장이 나이면 승인 가능 								<sql:param value="${sessionScope.login_user_id}"/>
		when  WK.confirm_user_id is null and WK.user_id = ? then 1 --  승인 안된 상태 and 나의 데이터 이면   승인 가능  <sql:param value="${sessionScope.login_user_id}"/>
		else  0
		end   = 1
</sql:update>
<log:info>${v_trace_msg} rows=${tmp_confirm_target_rows}</log:info>

<%-- -------------------------------------------------------------------------------------- --%>
<c:set var="v_trace_msg" value="3. user_work update"/>
<%-- -------------------------------------------------------------------------------------- --%>
<sql:update var="user_work_update_rows">
update  user_work T 
  join	tmp_confirm_target M  ON (M.confirm_user_id  = ?  and T.project_id = M.project_id   and	   T.user_id = M.user_id   and	  T.base_ymd = M.base_ymd ) <sql:param value="${sessionScope.login_user_id}"/>
   set	T.confirm_user_id = M.confirm_user_id
   	,	T.confirm_history_id = ${confirm_history_id}
</sql:update>
<log:info>${v_trace_msg} rows=${user_work_update_rows}</log:info>

</sql:transaction>

{"code":"0", "mesg":"승인 되었습니다.", "confirm_history_id":"${confirm_history_id}", "tmp_confirm_target_rows":"${tmp_confirm_target_rows}", "user_work_update_rows":"${user_work_update_rows}", "project_id":"${param.project_id } }", "user_id":"${param.user_id}", "confirm_user_id":"${sessionScope.login_user_id}"}
