package Rproject;

import org.rosuda.REngine.Rserve.RConnection;


public class Rgraph {
	public byte[] rsummercost(){
		RConnection r = null;
		byte retImg[] = null;
		try{
			r = new RConnection();
			//r.eval("png('C:/project/Rstudy/test1.png')");
			r.eval("source('C:/project/Rstudy/summercosttest.R')");
			r.eval("ggsave('C:/project/Rstudy/test1.png',dpi=600)");
			//r.eval("dev.off()");
			r.eval("r=readBin('C:/project/Rstudy/test1.png','raw',1024*1024)");
			//r.eval("unlink('C:/project/Rstudy/test.png')");
			retImg = r.eval("r").asBytes();
			
		} catch (Exception e){
			System.out.println("summercost 불러오기 실패");
			e.printStackTrace();
		} finally{
			r.close();
		}
		return retImg;
	}
	public String rtop5summer(){
		RConnection r = null;
		String retStr = "";
		try{
			r=new RConnection();
			r.eval("source('C:/project/Rstudy/top5ofsummer.R')");
			r.eval("out <- capture.output(n2$show('inline'))");
			r.eval("str <- ''");
			r.eval("for(i in 1:length(out)){str<-paste(str,out[i],'\n');}");
			return r.eval("str").asString();
		}catch(Exception e){
			System.out.println(e);
			e.printStackTrace();
		}finally{
			r.close();
		}
		return retStr;
		
	}
	public byte[] rworldmap1(){
		RConnection r = null;
		byte retImg[] = null;
		try{
			r = new RConnection();
			r.eval("png('C:/project/Rstudy/summerworld.png',res=100)");
			r.eval("source('C:/project/Rstudy/worldmapsummer.R')");
			r.eval("dev.off()");
			r.eval("r=readBin('C:/project/Rstudy/summerworld.png','raw',1024*1024)");
			r.eval("unlink('C:/project/Rstudy/summerworld.png')");
			retImg = r.eval("r").asBytes();
		} catch(Exception e){
			System.out.println(e);
			e.printStackTrace();
		} finally{
			r.close();
		}
		return retImg;
	}
}