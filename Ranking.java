package sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Ranking {
	private Connection conn;   //데이터베이스에 접근하기 위한 객체
    private PreparedStatement pstmt;  
    private ResultSet rs;   //정보를 담을 수 있는 변수를 생성
	public Ranking() {
		// TODO Auto-generated constructor stub
		
	    
	    String dbURL="jdbc:mysql://localhost:3306/rkdus?" + "useUnicode=true&characterEncoding=utf8";                             
	    String dbID="kgy";
	    String dbPassword="kgy1234";
	    String SQL = "SELECT * FROM record_timer";
	    try {
	    	Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			pstmt = (PreparedStatement) conn.createStatement();
			rs = pstmt.executeQuery(SQL);
			while (rs.next()) { 
				String GameID = rs.getString("GameId"); 
				String time = rs.getString("time"); 
				String playtime = rs.getString("playtime"); 
			}

			
			

			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close(); 
					} 
				catch (SQLException e) {
					e.printStackTrace(); 
					} 
				} 
			if (pstmt != null) {
				try {
					pstmt.close(); 
					} 
				catch (SQLException e) {
					e.printStackTrace(); 
					} 
				} 
			if (conn != null) {
				try {
					conn.close(); 
					} 
				catch (SQLException e) {
					e.printStackTrace(); 
					} 
				} 
			} 
	    }
	    
	}
	

