package utils;

public class CodeBase {
	String code = "";
	String codeName = "";
	String optGroupName = "";
	String groupcode = "";

	
	public CodeBase(String code, String codeName, String optGroupName) {
		this.code = code;
		this.codeName = codeName;
		this.optGroupName = (optGroupName == null) ? "" : optGroupName;
	}

	public CodeBase(String groupcode, String code, String codeName, String optGroupName) {
		this.code = code;
		this.codeName = codeName;
		this.optGroupName = (optGroupName == null) ? "" : optGroupName;
		this.groupcode = groupcode;
	}
	

	public String getGroupcode() { return groupcode;}

	public void setGroupcode(String groupcode) { this.groupcode = groupcode; }

	
	public void setCode(String code) { if(code != null) this.code = code; }
	public void setCodeName(String codeName) { if(codeName != null) this.codeName = codeName; }
	public void setOptGroupName(String optGroupName) { if(optGroupName != null) this.optGroupName = optGroupName; }
	
	public String getCode() { return this.code; }
	public String getCodeName() { return this.codeName; }
	public String getOptGroupName() { return this.optGroupName; }

	public String toString() {
		return "{groupcode:\""  + groupcode + "\",code:\"" + code + "\",codeName:\"" + codeName + "\",optGroupName:\"" + optGroupName + "\"}";
	}
}
