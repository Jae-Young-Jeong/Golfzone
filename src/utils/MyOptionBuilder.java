// charse=UTF-8
package utils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;



//import org.apache.logging.log4j.LogManager;
//import org.apache.logging.log4j.Logger;



public class MyOptionBuilder {
	private LinkedHashMap<String,CodeBase>  items = new LinkedHashMap<String,CodeBase>();

//	private static final Logger logger = LogManager.getLogger(MyOptionBuilder.class.getClass());
	private String groupCode = "";
	private String tableName = "";

	public MyOptionBuilder() {
		this.tableName = "sysCodeBase";
	}

	public MyOptionBuilder(String groupCode) {
		this.tableName = "sysCodeBase";
		this.setGroupCode( groupCode);

	}

	
	public MyOptionBuilder(String groupCode, String tableName ) {
		this.setGroupCode(groupCode);
		
		if(tableName == null || tableName.equals("") ) {
			this.tableName = "sysCodeBase";
		} else {
			this.tableName = tableName;
		}
		
	}





	public void setBySQL(String sql) {

		if(sql==null || sql.equals("") ) return;

		items.clear();
		this.groupCode = sql;



		try (Connection cn =  MyDBConnection.getConnection(); Statement st = cn.createStatement(); ResultSet rs = st.executeQuery(sql ); ) {

			while(rs.next()) {
				//items.put( rs.getString("code"), rs.getString("codeName"));
				String code = rs.getString("code");
				CodeBase c = new CodeBase(code, rs.getString("codeName"), rs.getString("optGroupName"));
				items.put(code, c);
			}

		} catch(Exception e) {
			System.out.println( "exception.message=" + e.getMessage());
		}
	}

	public void clear() {
		this.groupCode = "";
		this.items.clear();
	}

	public void setGroupCode(String groupCode ) {
		String sql = "";

		if(groupCode==null || groupCode.equals("")) {
			return ;
		}

		if( this.groupCode == groupCode ) {
			return ;
		}

		items.clear();
		this.groupCode = groupCode;

		if(groupCode.toLowerCase().equals("yntype") || groupCode.toLowerCase().equals("yn")) {
			this.addItem("N",  "No", "");
			this.addItem("Y",  "Yes", "");
			return;
		}
		else if(groupCode.toLowerCase().equals("sextype")) {
			this.addItem("남", "남", "");
			this.addItem("여", "여", "");
			return;
		}
		else if(groupCode.toLowerCase().equals("solluntype")) {
			this.addItem("S", "양", "");
			this.addItem("L", "음", "");
			return;
		}



		sql =
		"select  code, `name` AS codeName,  ifnull(optGroupName,'') as optGroupName " +
		"  from  " + this.tableName +
		" where groupCode = '" + this.groupCode + "'  order by optGroupName, seqno, `name`";

//System.out.println(sql);
		
		try( Connection cn = MyDBConnection.getConnection(); Statement st = cn.createStatement(); ResultSet rs = st.executeQuery(sql ); )
		{

			while(rs.next()) {
				CodeBase c = new CodeBase(rs.getString("code"), rs.getString("codeName"), rs.getString("optGroupName"));
				items.put(rs.getString("code"),  c);
			}

		} catch(Exception e) {
			System.out.println( "exception.message=" + e.getMessage());
		}
	}

	/**
	 * setItem
	 * @param selectValue
	 * @return
	 */
	public String  getHtmlCombo(String selectValue ) {
		StringBuffer tmpstr =  new StringBuffer();
		String oldOptGroupName	= "";
		String optgroupEndingStr = "";

		if(items.isEmpty()) {
			tmpstr.append("<option value=\"\"> </option>");
			return tmpstr.toString();
		}


		tmpstr.append("<option value=\"\"></option>");


		for (Map.Entry<String,CodeBase> entry : items.entrySet()) {
			CodeBase c =  entry.getValue();

			if(! oldOptGroupName.equals(c.getOptGroupName())) {
				tmpstr.append(optgroupEndingStr);
				tmpstr.append("<optgroup label=\"" + c.getOptGroupName() + "\">");
				oldOptGroupName = c.getOptGroupName();
				optgroupEndingStr = "</optgroup>";
			}

			if(selectValue != null && selectValue.equals( c.getCode() ) ) {
				tmpstr.append("<option class=\"option-selected\" "  + " selected=\"selected\" value=\"" + c.getCode() + "\">");
				tmpstr.append( c.getCodeName()) ;
				tmpstr.append("</option>");

			} else {
				tmpstr.append("<option value=\"" + c.getCode() + "\">");
				tmpstr.append( c.getCodeName()) ;
				tmpstr.append("</option>");
			}

		}
		tmpstr.append(optgroupEndingStr);
		return tmpstr.toString();
	}

	public String  getHtmlCombo(String selectValue , int aType) {
		StringBuffer tmpstr =  new StringBuffer();
		String oldOptGroupName	= "";
		String optgroupEndingStr = "";
		String emptyOpt = "";

		if(aType == 0) {
			return getHtmlCombo(selectValue);
		}


		if(aType == 0) {
			emptyOpt = "";
		}
		else if(aType == 1) {
			emptyOpt ="<option value=\"\">선택</option>";
		}
		else if(aType == 2) {
			emptyOpt = "";
		}


		if(items.isEmpty()) {
			tmpstr.append("<option value=\"\"></option>");
			return tmpstr.toString();
		}


//		tmpstr.append(emptyOpt);


		for (Map.Entry<String,CodeBase> entry : items.entrySet()) {
			CodeBase c =  entry.getValue();

			if(! oldOptGroupName.equals(c.getOptGroupName())) {
				tmpstr.append(optgroupEndingStr);
				tmpstr.append("<optgroup label=\"" + c.getOptGroupName() + "\">");
				oldOptGroupName = c.getOptGroupName();
				optgroupEndingStr = "</optgroup>";
			}

			if(selectValue != null && selectValue.equals( c.getCode() ) ) {
				tmpstr.append("<option class=\"option-selected\" "  + " selected=\"selected\" value=\"" + c.getCode() + "\">");
				tmpstr.append( c.getCodeName()) ;
				tmpstr.append("</option>");

			} else {
				tmpstr.append("<option value=\"" + c.getCode() + "\">");
				tmpstr.append( c.getCodeName()) ;
				tmpstr.append("</option>");
			}

		}
		tmpstr.append(optgroupEndingStr);
		return tmpstr.toString();
	}

	
	
	/**
	 * getHtmlCheck :
	 * @param multiValue
	 * @return
	public String getHtmlCheck(Map<String,String> multiValue, String tagName) {
		StringBuffer tmpstr=  new StringBuffer();
		int idx=0;
		String type="";
		String name = "";
		String value = "";
		String data_code = "";
		String checked = "";
		String id = "";

		if(items.isEmpty()) return tmpstr.toString();

		for (Map.Entry<String,CodeBase> entry : items.entrySet()) {
			CodeBase c = entry.getValue();

			type = "type=\"checkbox\" ";
			name = "name=\"" + tagName + "\" ";
			  id = "  id=\"" + tagName + String.valueOf(idx) +  "\" ";
			data_code = "data-code=\"" + c.getCode() + "\" ";
			value = "value=\"" + c.getCodeName() + "\" ";

			if( multiValue.get( entry.getKey()) != null ) {
				checked = "checked ";
			} else {
				checked = "";
			}

			tmpstr.append("<input " + type + name + id + data_code + value + checked + "/>");
			idx++;
		}

		return tmpstr.toString();

	}




	public String getHtmlCheck(String[] multiValue, String tagName) {
		StringBuffer tmpstr=  new StringBuffer();
		String type="";
		String name = "";
		String value = "";
		String data_code = "";
		String checked = "";
		String id = "";

		if(items.isEmpty()) return tmpstr.toString();

		for (Map.Entry<String, CodeBase> entry : items.entrySet()) {

			CodeBase c = entry.getValue();

			type = "type=\"checkbox\" ";
			name = "name=\"" + tagName + "\" ";
			  id = "  id=\"" + tagName + "-" + c.getCode() +  "\" ";
			data_code = "data-code=\"" + c.getCode() + "\" ";
			value = "value=\"" + c.getCode() + "\" ";

			checked = "";
			if(multiValue != null ) {
				for(int n=0; n<multiValue.length; n++) {
					if( multiValue[n].equals(entry.getKey()) ) {
						checked= " checked ";
						break;
					}
				}
			}

			tmpstr.append("<label><input " + type + name + id + data_code + value  + checked + "/>" + c.getCodeName()  + "</label>&nbsp;&nbsp;");
		}

		return tmpstr.toString();
	}
	 */

	
	
	public String getHtmlCheck(String checkedValuesDelimiterByPipe, String attr_name, String attr_classes) {
		
		StringBuffer tmpstr=  new StringBuffer();

		if(items.isEmpty()) return tmpstr.toString();
		if(checkedValuesDelimiterByPipe == null) checkedValuesDelimiterByPipe = "";
		List<String> smv = Arrays.asList(checkedValuesDelimiterByPipe.split("\\|"));

//		String toks[] = checkedValuesDelimiterByPipe.split("\\|");
//		System.out.println("checkedValuesDelimiterByPipe=" + checkedValuesDelimiterByPipe + ", toks.length=" + String.valueOf(toks.length));
		

		for (Map.Entry<String, CodeBase> entry : items.entrySet()) {
			CodeBase c = entry.getValue();

			tmpstr.append( "<label class='" + attr_name + "'><input") ;
			tmpstr.append( " type=\"checkbox\"");
			tmpstr.append( " name=\"" + attr_name + "\"");
			tmpstr.append( " id=\"" + attr_name + "-" + c.getCode() +  "\"");
			tmpstr.append( " data-code=\"" + c.getCode() + "\"");
			tmpstr.append( " value=\"" + c.getCode() + "\"");
			tmpstr.append( " class=\"" + attr_classes + "\"");
			tmpstr.append( smv.contains(c.getCode()) ? " checked" : "" );
			tmpstr.append("/>");
			tmpstr.append(c.getCodeName());
			tmpstr.append("</label>");

		}
		
		return tmpstr.toString();
	}
	
	
	
	
	
	
	
	
	/**
	 * getHtmlCheck :
	 * @param multiValue
	 * @return
	 */
	public String getHtmlRadio(String selecdValue, String attr_name) {
			
		return getHtmlRadio(selecdValue, attr_name, "");
	}

	public String getHtmlRadio(String selecdValue, String attr_name, String attr_classes) {
		StringBuffer tmpstr=  new StringBuffer();

//		System.out.println( "getHtmlRadio() selecdValue=" + selecdValue);
		
		if(items.isEmpty()) return tmpstr.toString();
		if(selecdValue == null) selecdValue = "";

		for (Map.Entry<String, CodeBase> entry : items.entrySet()) {
			CodeBase c = entry.getValue();

			tmpstr.append( "<label class='" + attr_name + "'><input") ;
			tmpstr.append( " type=\"radio\"");
			tmpstr.append( " name=\"" + attr_name + "\"");
			tmpstr.append( " id=\"" + attr_name + "-" + c.getCode() +  "\"");
			tmpstr.append( " class=\"" + attr_classes + "\"");
			tmpstr.append( " data-code=\"" + c.getCode() + "\"");
			tmpstr.append( " value=\"" + c.getCode() + "\"");
			tmpstr.append( selecdValue.equals(c.getCode()) ? " checked" : "" );
			tmpstr.append("/>");
			tmpstr.append(c.getCodeName());
			tmpstr.append("</label>");

		}
		
		return tmpstr.toString();

	}

	
	public String getValueByKey(String aKey ) {
		if(aKey == null) return "";
		CodeBase cb = items.get(aKey);
		if(cb == null) return "";
		return cb.getCodeName();
	}


	public void addItem( String code, String name,   String optGroup) {
		CodeBase c = new CodeBase(code, name, optGroup);
		this.items.put(code, c);
	}




	public boolean loadBranchs() {
		String SQL;

		items.clear();
		this.groupCode = "branchcode";

		SQL =
"SELECT	1 		AS part " +
"	,	''		AS optGroupName  " +
"	,	orgid 	AS code	 " +
"	,	orgName	AS codeName " +
"	,	'Y'		AS isLivedYn " +
"	,	CASE WHEN OG.orgid = '${param.aBranchcode}' THEN 'Y' ELSE 'N' END AS isSelectedYn " +
"  FROM	orgs OG " +
" where	OG.orgid between '400000' AND '400099' " +
" UNION	ALL  " +
"SELECT	2 as part " +
"	,	CASE " +
"		when orgName rlike '^(ㄱ|ㄲ)' OR ( orgName >= '가' AND orgName < '나' ) then 'ㄱ'  " +
"		when orgName rlike '^ㄴ' OR ( orgName >= '나' AND orgName < '다' ) then 'ㄴ'        " +
"		when orgName rlike '^(ㄷ|ㄸ)' OR ( orgName >= '다' AND orgName < '라' ) then 'ㄷ'    " +
"		when orgName rlike '^ㄹ' OR ( orgName >= '라' AND orgName < '마' ) then 'ㄹ'  " +
"		when orgName rlike '^ㅁ' OR ( orgName >= '마' AND orgName < '바' ) then 'ㅁ'  " +
"		when orgName rlike '^ㅂ' OR ( orgName >= '바' AND orgName < '사' ) then 'ㅂ'  " +
"		when orgName rlike '^(ㅅ|ㅆ)' OR ( orgName >= '사' AND orgName < '아' ) then 'ㅅ'  " +
"		when orgName rlike '^ㅇ' OR ( orgName >= '아' AND orgName < '자' ) then 'ㅇ'  " +
"		when orgName rlike '^(ㅈ|ㅉ)' OR ( orgName >= '자' AND orgName < '차' ) then 'ㅈ' " +
"		when orgName rlike '^ㅊ' OR ( orgName >= '차' AND orgName < '카' ) then 'ㅊ'  " +
"		when orgName rlike '^ㅋ' OR ( orgName >= '카' AND orgName < '타' ) then 'ㅋ'  " +
"		when orgName rlike '^ㅌ' OR ( orgName >= '타' AND orgName < '파' ) then 'ㅌ'  " +
"		when orgName rlike '^ㅍ' OR ( orgName >= '파' AND orgName < '하' ) then 'ㅍ'  " +
"		when orgName rlike '^ㅎ' OR ( orgName >= '하' AND orgName <= '핳' ) then 'ㅎ'  " +
"		else substr(orgName,1,1) end AS optGroupName " +
"	,	TRIM(OG.orgid) as code " +
"	,	TRIM(OG.orgName) AS codeName " +
"	,	CASE WHEN OG.useYn = 'Y' AND DATE_FORMAT(NOW(), '%Y-%m-%d') <= OG.tdate THEN 'Y' ELSE 'N' END AS isLivedYn " +
"	,	CASE WHEN OG.orgid = '${param.aOrgid}' THEN 'Y' ELSE 'N' END AS isSelectedYn " +
"  from	orgs  OG " +
" where	OG.obType = 'B' " +
"   and  OG.orgid >= '400100'  " +
"   and	 (OG.useYn = 'Y' AND DATE_FORMAT(NOW(), '%Y-%m-%d') <= OG.tdate)  /* 살아있는거/죽은거 toggle */ " +
" order	by part, optGroupName, codeName "
;
//System.out.println(SQL);

		try( Connection cn = MyDBConnection.getConnection(); Statement st = cn.createStatement(); ResultSet rs = st.executeQuery(SQL); )
		{
			while(rs.next()) {
				CodeBase c = new CodeBase(rs.getString("code"), rs.getString("codeName"), rs.getString("optGroupName"));
//System.out.println(c.toString());
				items.put(rs.getString("code"),  c);
			}

		} catch(Exception e) {
			System.out.println( "exception.message=" + e.getMessage());
			return false;
		}

		return true;

	}


	/*
	 * 기관목록을 로드한다.
	 */
	public boolean loadOrgs() {
		String SQL;

		items.clear();
		this.groupCode = "orgs";

		SQL =
		"select	n.orgid as code " +
		"	,	TRIM(p.orgName) as optGroupName " +
		"	,	n.orgName as codeName " +
		"	,	n.useYn " +
		"	,	n.fdate " +
		"	,	n.tdate " +
		"  from	orgs n " +
		"  left	outer join orgs p on (n.pOrgid = p.orgid and p.useYn = 'Y' and  DATE_FORMAT(NOW(), '%Y-%m-%d') <= p.tdate) " +
		" where	n.obtype = 'O' " +
		"   and	ifnull(n.pOrgid , '') <> '' " +
		"   and	n.useYn = 'Y' " +
		"   and  DATE_FORMAT(NOW(), '%Y-%m-%d') <= n.tdate " +
		" order	by p.orgName, n.orgName "
		;

		try( Connection cn = MyDBConnection.getConnection(); Statement st = cn.createStatement(); ResultSet rs = st.executeQuery(SQL); )
		{
			while(rs.next()) {
				items.put(rs.getString("code"),  new CodeBase(rs.getString("code"), rs.getString("codeName"), rs.getString("optGroupName")));
			}

		} catch(Exception e) {
			System.out.println( "exception.message=" + e.getMessage());
			return false;
		}

		return true;

	}

	/*
	 *  기관코드를 받어서 부서리스트를 로드 한다.
	 */

	public boolean loadDivisions(String orgid) {

		String SQL;

		items.clear();
		this.groupCode = orgid;


		SQL =
		"select divid as code, divName as codeName,  '' as optGroupName " +
		"  from org_divisions " +
		" where orgid = '" + orgid +
		"   and useYn = 'Y' " +
		"   and DATE_FORMAT(NOW(), '%y-%m-%d') <= tdate " +
		" order by divName";

		try( Connection cn = MyDBConnection.getConnection(); Statement st = cn.createStatement(); ResultSet rs = st.executeQuery(SQL); )
		{
			while(rs.next()) {
				items.put(rs.getString("code"),  new CodeBase(rs.getString("code"), rs.getString("codeName"), rs.getString("optGroupName")));
			}

		} catch(Exception e) {
			System.out.println( "exception.message=" + e.getMessage());
			return false;
		}

		return true;
	}




	public boolean loadAccounts() {
		return loadAccounts("");
	}
	public boolean loadAccounts(String acType) {

		String SQL;

		items.clear();
		this.groupCode = acType;

		if(acType == null || "".equals(acType)) {
			SQL =
			"select CAST(A.acid AS CHAR) AS code" +
			"	,	A.acName	AS codeName " +
			"	,	B.korName 	AS optGroupName " +
			"  from	ac3accounts A " +
			"	,	ac3acdp     B " +
			" where	A.actype = B.actype" +
			" order by B.korName, A.acName";
		} else {
			SQL =
			"select CAST(A.acid AS CHAR) AS code" +
			"	,	A.acName	AS codeName " +
			"	,	B.korName 	AS optGroupName " +
			"  from	ac3accounts A " +
			"	,	ac3acdp     B " +
			" where	A.actype = B.actype" +
			"   and A.actype = '" + acType + "'" +
			" order by B.korName, A.acName";
		}

		try( Connection cn = MyDBConnection.getConnection(); Statement st = cn.createStatement(); ResultSet rs = st.executeQuery(SQL); )
		{
			while(rs.next()) {
				items.put(rs.getString("code"),  new CodeBase(rs.getString("code"), rs.getString("codeName"), rs.getString("optGroupName")));
			}

		} catch(Exception e) {
			System.out.println( "exception.message=" + e.getMessage());
			return false;
		}

		return true;
	}

}
