<%-- ----------------------------------------------------------------------------
DESCRIPTION : 권한자(팀장, 원장) 이  본인또는 하위 사원이 등록한 내역을 승인(confirm)한다.
   JSP-NAME : user_work-excel-type1.jsp
    VERSION : 
    HISTORY :
http://localhost:8080/tbls/user_work/user_work-excel-type1.jsp
---------------------------------------------------------------------------- --%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="org.apache.poi.ss.usermodel.Cell"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%>
<%@page import="java.nio.file.StandardCopyOption"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import="sun.reflect.ReflectionFactory.GetReflectionFactoryAction"%>
<%@page import="utils.MySql1"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>



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

<log:setLogger logger="user_work-excel-type1.jsp"/>
<sql:setDataSource dataSource="jdbc/db" />
<fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date()%>"  var="today"/>
<fmt:formatDate pattern="yyyy-MM-dd-hh-mm-ss" value="<%=new java.util.Date()%>"  var="time"/>

<%
ArrayList<HashMap<String, String>> rows = new ArrayList<HashMap<String, String>>();
ArrayList<HashMap<String, String>> cols = new ArrayList<HashMap<String, String>>();
ArrayList<HashMap<String, String>> data = new ArrayList<HashMap<String, String>>();
HashMap<String, String> params = new HashMap<String, String>(); 
MySql1 mysql = new MySql1();


params.put("term_sta_ymd", "2022-01-01");
params.put("term_end_ymd", "2022-12-31");

rows = mysql.sqlidToList("excel-1-rows", params );
if(rows == null) {
	System.out.println("excel-1-rows is empty");
} else {
	System.out.println("rows=" + String.valueOf(rows.size()));
}



cols = mysql.sqlidToList("excel-1-cols", params );
if(cols == null) {
	System.out.println("excel-1-cols is empty");
} else {
	System.out.println("cols=" + String.valueOf(cols.size()));
}



data = mysql.sqlidToList("excel-1-data", params );
if(data == null) {
	System.out.println("excel-1-data is empty");
} else {
	System.out.println("data=" + String.valueOf(cols.size()));
}




String excel_save_path = application.getInitParameter("excel_save_path");
if(excel_save_path == null || excel_save_path.equals("")) {
	excel_save_path = "";
}
String xlsPath = application.getRealPath("/xlsx");
System.out.println(xlsPath);

String xlsfile = xlsPath + "/1.월별참여율.xlsx";


String excel_save_file = excel_save_path + "/1.월별참여율-" + (String)session.getAttribute("login_user_id") + "-" + (String)pageContext.getAttribute("time") + ".xlsx";



FileInputStream fis = new FileInputStream(xlsfile);
XSSFWorkbook workbook = new XSSFWorkbook(fis);
XSSFSheet    sheet    = workbook.getSheetAt(0); // 해당 엑셀파일의 시트(Sheet) 수

Cell c = null;
int colidx = 0;
int rowidx = 0;
int base_row = 1;
int base_col = 4;
Row xlrow = null;
HashMap<String, String> m = null;


xlrow = sheet.getRow(0); if(xlrow == null) xlrow = sheet.createRow(0); 
for (colidx = 0; colidx < cols.size(); colidx++) {
	c = xlrow.getCell( base_col + colidx );  if(c == null) c = xlrow.createCell(base_col + colidx);
	c.setCellValue( cols.get(colidx).get("ymstr"));
}


 
for (rowidx = 0; rowidx < rows.size(); rowidx++) {
	xlrow = sheet.getRow(base_row + rowidx); if(xlrow == null) xlrow = sheet.createRow(base_row + rowidx);
	m = rows.get(rowidx);
	
	colidx = 0;  c = xlrow.getCell( colidx );  if(c == null) c = xlrow.createCell(colidx);	c.setCellValue( m.get("emp_no") );
	colidx = 1;  c = xlrow.getCell( colidx );  if(c == null) c = xlrow.createCell(colidx);	c.setCellValue( m.get("emp_nm") );
	colidx = 2;  c = xlrow.getCell( colidx );  if(c == null) c = xlrow.createCell(colidx);	c.setCellValue( m.get("tech_note") );
	colidx = 3;  c = xlrow.getCell( colidx );  if(c == null) c = xlrow.createCell(colidx);	c.setCellValue( m.get("memo_note") );
}


base_col = 4;
base_row = 1;
double  ratio = 0;

for (int didx = 0; didx < data.size(); didx++) {
	m = data.get(didx);
	rowidx = Integer.parseInt(m.get("user_seqno"));
	colidx = Integer.parseInt(m.get("ym_seq"));
	ratio  = Double.parseDouble(m.get("tot_radio"));

	xlrow = sheet.getRow(base_row + rowidx);  		if(xlrow == null) xlrow = sheet.createRow(base_row + rowidx);
	c     = xlrow.getCell(base_col + colidx); 		if(c     == null) c     = xlrow.createCell(base_col + colidx);
	
	c.setCellValue(ratio);
}


FileOutputStream fos = null;
try{
	fos = new FileOutputStream(excel_save_file);
	workbook.write(fos);
} catch (Exception e) {
	System.out.println( e.getMessage() );
}

if(fos != null) { fos.close(); }
if(workbook != null) workbook.close();
if(fis != null) fis.close();

%>