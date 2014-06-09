package kkweb.common;

import java.io.IOException;

public class C_FileExecution {
		public void main(String args) throws IOException {
		String cmd = args;
		Runtime.getRuntime().exec(cmd);
		}

}
