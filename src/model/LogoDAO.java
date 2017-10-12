package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class LogoDAO {
	private Connection connectDB() {
		Connection conn = null;
		
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/oraDB");
			conn = ds.getConnection();
		} catch(Exception e){
			System.out.println("抗寇贸府!!");
		}
		return conn;
	}
	
	public ArrayList<LogoVO> select(){
		Connection conn = connectDB();
		ArrayList<LogoVO> result = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement("select loc, type, year, cnt from logo order by cnt desc");
			rs = pstmt.executeQuery();
			
			result = new ArrayList<LogoVO>();
			LogoVO lvo = null;
			
			while(rs.next()) {
				lvo = new LogoVO();
				
				lvo.setLoc(rs.getString(1));
				lvo.setType(rs.getString(2));
				lvo.setYear(rs.getString(3));
				lvo.setCnt(rs.getInt(4));
				
				result.add(lvo);
			}
		} catch(Exception e) {
			System.out.println("抗寇贸府!!");
		} finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public LogoVO listOne(String loc){
		Connection conn = connectDB();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		LogoVO lvo = null;
		
		try {
			pstmt = conn.prepareStatement("select loc, type, year, cnt from logo where loc=?");
			pstmt.setString(1, loc);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				lvo = new LogoVO();
				
				lvo.setLoc(rs.getString(1));
				lvo.setType(rs.getString(2));
				lvo.setYear(rs.getString(3));
				lvo.setCnt(rs.getInt(4)+1);
			}
		} catch(Exception e) {
			System.out.println("抗寇贸府!!");
		} finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return lvo;
	}
	
	
	public boolean update(LogoVO lvo) {
		Connection conn = connectDB();
		PreparedStatement pstmt = null;
		boolean result = true;
		
		try {
			pstmt = conn.prepareStatement("update logo set cnt=? where loc=?");
			pstmt.setInt(1, lvo.getCnt());
			pstmt.setString(2, lvo.getLoc());
			
			pstmt.executeUpdate();
		} catch(Exception e) {
			result = false;
			System.out.println("抗寇贸府!!");	
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (Exception e){
				e.printStackTrace();
			}
		}
		return result;
	}
}