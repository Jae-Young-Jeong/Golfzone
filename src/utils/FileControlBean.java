package utils;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class FileControlBean {

	
	public void startDeleting(String path) {
        List<String> filesList = new ArrayList<String>();
        List<String> folderList = new ArrayList<String>();
        fetchCompleteList(filesList, folderList, path);
        for(String filePath : filesList) {
            File tempFile = new File(filePath);
            tempFile.delete();
        }
        for(String filePath : folderList) {
            File tempFile = new File(filePath);
            tempFile.delete();
        }
    }

	private void fetchCompleteList(List<String> filesList, List<String> folderList, String path) {
	    File file = new File(path);
	    File[] listOfFile = file.listFiles();
	    for(File tempFile : listOfFile) {
	        if(tempFile.isDirectory()) {
	            folderList.add(tempFile.getAbsolutePath());
	            fetchCompleteList(filesList, 
	                folderList, tempFile.getAbsolutePath());
	        } else {
	            filesList.add(tempFile.getAbsolutePath());
	        }
	
	    }
	
	}
}
