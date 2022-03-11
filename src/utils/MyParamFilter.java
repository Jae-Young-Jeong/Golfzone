package utils;

import java.util.regex.Pattern;

//import org.apache.logging.log4j.LogManager;
//import org.apache.logging.log4j.Logger;



public class MyParamFilter {

//	private static final Logger logger = LogManager.getLogger(MyParamFilter.class.getClass());
//	Pattern evilChars  = Pattern.compile("[<&>\\"\\'%]");
	

	public String filter(String str) {
		return textfilter(str);
	}
	
	public String filter(String str, int maxlen) {
		return textfilter(str).substring(0, maxlen);
	}
	
	public String sqlfilter(String str, int maxlen) {
		return sqlfilter(str).substring(0, maxlen);
	}

	public String textfilter(String str, int maxlen) {
		return textfilter(str).substring(0, maxlen);
	}

	
	
	
	
	public String sqlfilter(String str) {

		String ret;

		if(str == null) {
			ret = "";
		} else {

			ret  = str
					.replaceAll(";", " ").replaceAll("--", " ").replaceAll("[<>]",  " ")
					.replaceAll("/[*]", " ").replaceAll("[*]/", " ")
//					.replaceAll("[']", "&quot;")
					.replaceAll("(?i)select", "sel2ct")
					.replaceAll("(?i)update", "updat2")
					.replaceAll("(?i)delete", "delet2")
					.replaceAll("(?i)truncate", "truncat2")
					.replaceAll("(?i)drop", "dr0p")
					.replaceAll("(?i)script", "skript")
					
			;
			//ret = evilChars.matcher(str).replaceAll(" ");
		}
		return ret.trim();
	}




	public String textfilter(String str) {

		String ret;

		if(str == null) {
			ret = "";
		} else {

			ret  = str
					.replaceAll(";", "&#59;").replaceAll("--", " ")
					.replaceAll("/[*]", " ").replaceAll("[*]/", " ")
					.replaceAll("[']", "&quot;")
					.replaceAll("[<]", "&lt;")
					.replaceAll("[>]", "&gt;")
					.replaceAll("[?]", "&#63;")
					.replaceAll("[']", "&#39;")
					.replaceAll("\"", "&quot;")
					.replaceAll("(?i)select", "sel2ct")
					.replaceAll("(?i)update", "updat2")
					.replaceAll("(?i)delete", "delet2")
					.replaceAll("(?i)truncate", "truncat2")
					.replaceAll("(?i)drop", "dr0p")
					.replaceAll("(?i)script", "sKript")
			;
		}
		return ret.trim();
	}
}
