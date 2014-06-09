package kkweb.common;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;


public class C_FileCopy {

	public void copy(String genpon, String gocopy)
	    throws IOException {

	    FileChannel srcChannel = new
	        FileInputStream(genpon).getChannel();
	    FileChannel destChannel = new
	        FileOutputStream(gocopy).getChannel();
	    try {
	        srcChannel.transferTo(0, srcChannel.size(), destChannel);
	    } finally {
	        srcChannel.close();
	        destChannel.close();
	    }
	}}



