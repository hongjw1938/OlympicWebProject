package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class NewsDAO {
  private Connection connectDB(){
	  Connection conn = null;
	  try{
		  Context context = new InitialContext();
		   DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/oraDB");
		   conn = ds.getConnection();
	  }  catch (Exception e) {
		 System.out.println("예외발생---"+e);  
	   }
	   return conn;
  }
	
  public boolean insert(NewsVO vo){
	   boolean result = true;
	   Connection conn = connectDB();
	   PreparedStatement stmt = null;
	   try {
	       stmt = conn.prepareStatement("insert into news values(news_seq.nextval,?,?,?,sysdate,0)");
	       stmt.setString(1,vo.getWriter());
	       stmt.setString(2,vo.getTitle());
	       stmt.setString(3,vo.getContent());
	       stmt.executeUpdate();
	   } catch (Exception e) {
		   result = false;
		   System.out.println("예외발생---"+e);  
	   }finally {
		   try {
		   stmt.close();
		   conn.close();
		   } catch (Exception e) {
			   e.printStackTrace();
		   }
		  }
	   return result;
  }
  
  public boolean update(NewsVO vo){
		Connection conn = connectDB();
		PreparedStatement stmt = null;
		boolean result = true;
		
		try{stmt = conn.prepareStatement("update news set writer=?, title=?, content=?, cnt=? where id=?");
			
			stmt.setString(1, vo.getWriter());
			stmt.setString(2, vo.getTitle());
			stmt.setString(3, vo.getContent());
			stmt.setInt(4, vo.getCnt());
			stmt.setInt(5, vo.getId());
			
			stmt.executeUpdate();
		} catch(Exception e){
			result = false;
			System.out.println("예외발생---- " + e);
		} finally{
			try{stmt.close();
				conn.close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
		return result;
	}
  
  public ArrayList<NewsVO> listAll(){
	   ArrayList<NewsVO> result = null;
	   Connection conn = connectDB();
	   PreparedStatement stmt = null;
	   ResultSet rs = null;
	   try {
		   stmt=conn.prepareStatement("select id, writer, title, content, to_char(writedate,'yyyy-mm-dd'), cnt from news");
		   rs = stmt.executeQuery();
	       result = new ArrayList<NewsVO>();
	       NewsVO vo = null;
	    while(rs.next()){
	    	vo = new NewsVO();
	    	vo.setId(rs.getInt(1));
	    	vo.setWriter(rs.getString(2));
	    	vo.setTitle(rs.getString(3));
	    	vo.setContent(rs.getString(4));
	    	vo.setWritedate(rs.getString(5));
	    	vo.setCnt(rs.getInt(6)); 
	    	result.add(vo);
	    }
	   } catch (Exception e) {
		   System.out.println("예외발생---"+e);  
	   }finally {
		   try {
		   rs.close();
		   stmt.close();
		   conn.close();
		   } catch (Exception e) {
			   e.printStackTrace();
		   }
		  }
	   return result; 
  }
  
  public NewsVO listOne(int id){
	   Connection conn = connectDB();
	   PreparedStatement stmt = null;
	   ResultSet rs = null;
	   NewsVO vo = null;
	   try {
		   stmt = conn.prepareStatement("select id, writer, title, content, to_char(writedate,'yyyy-mm-dd'), cnt from news where id=?");
		   stmt.setInt(1,id);
		   rs = stmt.executeQuery();
		   
	       while(rs.next()){
	       vo = new NewsVO();
	       vo.setId(rs.getInt(1)); 
	       vo.setWriter(rs.getString(2));
	       vo.setTitle(rs.getString(3));
	       vo.setContent(rs.getString(4));
	       vo.setWritedate(rs.getString(5));
	       vo.setCnt(rs.getInt(6)+1); 
	    }
	   } catch (Exception e) {
		   System.out.println("예외발생---"+e);  
	   }finally {
		   try {
		   rs.close();
		   stmt.close();
		   conn.close();
		   } catch (Exception e) {
			   e.printStackTrace();
		   }
		  }
	   return vo; 
  }
  
  public boolean delete(int id){
	   Connection conn = connectDB();
	   boolean result = true;
	   PreparedStatement stmt = null;
	   try {
	       stmt = conn.prepareStatement("delete from news where id=?");
	       stmt.setInt(1,id);
	       stmt.executeUpdate();
	   } catch (Exception e) {
		   result = false;
		   System.out.println("예외발생---"+e);  
	   }finally {
		   try {
		   stmt.close();
		   conn.close();
		   } catch (Exception e) {
			   e.printStackTrace();
		   }
		}
	   return result;
  }
 }