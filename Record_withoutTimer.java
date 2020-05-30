package sql;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class Record_withoutTimer {
	private Connection conn;   //데이터베이스에 접근하기 위한 객체
    private PreparedStatement pstmt;  

	public Record_withoutTimer() {
	// TODO Auto-generated constructor stub
		String dbURL="jdbc:mysql://localhost:3306/rkdus?" + "useUnicode=true&characterEncoding=utf8";                             
	    String dbID="kgy";
	    String dbPassword="kgy1234";
	    String SQL = "insert into record_withouttimer(GameUsername, point, playtime) values(?, ?, NOW())";
	    
	    try {
	    	Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			pstmt = conn.prepareStatement(SQL);

			
			
			pstmt.setString(1, "PETER");
    		pstmt.setInt(2, 10);
    		pstmt.setInt(3, 1);
			
			int r = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally { //사용순서와 반대로 close 함 
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

