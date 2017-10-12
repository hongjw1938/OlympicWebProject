package rtest;

import org.rosuda.REngine.Rserve.RConnection;

public class RJavaGraph {
	public byte[] logoRImg() {
		RConnection r = null;
		byte retImg[] = null;
		
		try {
			r = new RConnection();
			
			r.eval("source('C:/RProject/logo.R')");
			r.eval("ggsave(file='C:/RProject/test.png')");
			r.eval("r <- readBin('C:/RProject/test.png', 'raw', 1024*1024)");
			
			retImg = r.eval("r").asBytes();
		} catch(Exception e) {
			System.out.println(e);
			e.printStackTrace();
		}
		return retImg;
	}
	
	public byte[] mascotRImg() {
		RConnection r = null;
		byte retImg[] = null;
		
		try {
			r = new RConnection();
			
			r.eval("source('C:/RProject/mascot.R')");
			r.eval("ggsave(file='C:/RProject/test.png')");
			r.eval("r <- readBin('C:/RProject/test.png', 'raw', 1024*1024)");
			
			retImg = r.eval("r").asBytes();
		} catch(Exception e) {
			System.out.println(e);
			e.printStackTrace();
		}
		return retImg;
	}
}