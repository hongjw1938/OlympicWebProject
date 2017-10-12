package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MascotDAO {
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
	
	public ArrayList<MascotVO> select(){
		Connection conn = connectDB();
		ArrayList<MascotVO> result = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement("select mas, type, year, cnt from mascot order by cnt desc");
			rs = pstmt.executeQuery();
			
			result = new ArrayList<MascotVO>();
			MascotVO mvo = null;
			
			while(rs.next()) {
				mvo = new MascotVO();
				
				mvo.setMas(rs.getString(1));
				mvo.setType(rs.getString(2));
				mvo.setYear(rs.getString(3));
				mvo.setCnt(rs.getInt(4));
				
				result.add(mvo);
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
	
	public MascotVO listOne(String mas){
		Connection conn = connectDB();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MascotVO mvo = null;
		
		try {
			pstmt = conn.prepareStatement("select mas, type, year, cnt from mascot where mas=?");
			pstmt.setString(1, mas);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				mvo = new MascotVO();
				
				mvo.setMas(rs.getString(1));
				mvo.setType(rs.getString(2));
				mvo.setYear(rs.getString(3));
				mvo.setCnt(rs.getInt(4)+1);
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
		return mvo;
	}
	
	public boolean update(MascotVO mvo) {
		Connection conn = connectDB();
		PreparedStatement pstmt = null;
		boolean result = true;
		
		try {
			pstmt = conn.prepareStatement("update mascot set cnt=? where mas=?");
			pstmt.setInt(1, mvo.getCnt());
			pstmt.setString(2, mvo.getMas());
			
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