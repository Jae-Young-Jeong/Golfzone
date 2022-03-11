<%-- ----------------------------------------------------------------------------
DESCRIPTION : 
   JSP-NAME : project-tr-nor.jsp
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

<log:setLogger logger="project-tr-nor.jsp"/>
<sql:setDataSource dataSource="jdbc/db" />
<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="today"/>



<%
MyOptionBuilder ob_yn = new MyOptionBuilder("ynType");
%>

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



<%-- ------------------------------------------------------------------------------------------------
한 프로젝트 + 참여인원 
------------------------------------------------------------------------------------------------ --%>
<sql:query var="SQL">
select	P.project_cd
	,	P.project_nm
	,	date_format(P.sta_ymd, '%Y-%m-%d') as sta_ymd
	,	date_format(P.end_ymd, '%Y-%m-%d') as end_ymd
	,	TRIM(UL.user_ids) AS user_ids
  from	project		P
  left	join 
		(
			select	project_cd, GROUP_CONCAT( userItem order by rn SEPARATOR '<br/>') AS user_ids
			  from	(
						select	UP.project_cd
							,	UP.user_id
							,	UP.sta_ymd
							,	US.emp_no
							,	US.emp_nm
							,	US.phone
							,	row_number()over(partition by UP.project_cd order by UP.sta_ymd)  as rn
							,	CONCAT( CAST(row_number()over(partition by UP.project_cd order by UP.sta_ymd) AS CHAR), '. ',  emp_nm, '(', phone, ') <span class="btnDel" data-user_id="', UP.user_id , '" ></span>') as userItem
						  from	user_project	UP
						  join	user			US ON (US.user_id = UP.user_id  and UP.sta_ymd <= US.retire_ymd and US.hire_ymd <= UP.end_ymd) 
						 where	DATE(NOW()) between UP.sta_ymd and UP.end_ymd

					) D
			 group	by project_cd
		) UL ON (UL.project_cd = P.project_cd)

 where	str_to_date(:base_ymd, '%Y-%m-%d') between P.sta_ymd and P.end_ymd 
   and	P.project_cd = :project_cd
</sql:query>

<c:forEach var="p" items="${SQL.rows}" varStatus="s">
	<td class="btnDelMasking"><input type="checkbox" class="btnDelMasking"/></td>
	<td class="project_cd">${p.project_cd}</td>
	<td class="project_nm">${p.project_nm}</td>
	<td class="sta_ymd">${p.sta_ymd}</td>
	<td class="end_ymd">${p.end_ymd}</td>

	<td class="tech_note">${p.tech_note}</td>
	<td class="memo_note">${p.memo_note}</td>
	<td class="btnBox"><input type="button" class="btnItemMod" value="M"/> <input type="button" class="btnItemDel" value="D"/></td>
</c:forEach>