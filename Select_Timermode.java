package sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.io.PrintWriter;
import java.sql.Statement;

public class Select_Timermode {
	private Connection conn;   
    private PreparedStatement pstmt;  
    private ResultSet rs;
	
	public Select_Timermode() {
		// TODO Auto-generated constructor stub
		String dbURL="jdbc:mysql://localhost:3306/rkdus?" + "useUnicode=true&characterEncoding=utf8";                             
	    String dbID="kgy";
	    String dbPassword="kgy1234";
	    StringBuilder sb = new StringBuilder();
	    StringBuilder del = new StringBuilder();
	    String SQL = sb.append("SELECT * FROM record_timer" ).append(";").toString();
	    

	    ArrayList<String> Username = new ArrayList<String>();
	    ArrayList<String> timer = new ArrayList<String>();
	    int loc = 0; // 원래 자기 위치 
	    int count = 1; // 등수계산 
	    boolean flag = false;
	    try {
	    	Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			pstmt = (PreparedStatement) conn.createStatement();
			rs = pstmt.executeQuery(SQL);
			while (rs.next()) { 
				String GameID = rs.getString("GameID"); 
				String time = rs.getString("time"); 
				Username.add(GameID);
				timer.add(time);
			}
			
			for(String s: Username) { //자신의 기존데이터 위치 찾기 
				if(Username.get(Username.size()-1) == s) {
					break;
				}
				else {
					loc++;
				}
			}
			
			if(Username.size() != 0) {
				for(String i : timer) {
					if(Integer.parseInt(timer.get(loc)) > Integer.parseInt(timer.get(timer.size()-1))) {
						count--; //기존데이터보다 현재 점수가 낮은 경우 
						flag = true;
					}
					if(Integer.parseInt(timer.get(timer.size()-1)) < Integer.parseInt(i)) {
						count++;
					}
				}
			}
			else count = 1;
			//현재등수 
			String printgrade = "My rank : " + count + "Username : " + Username.get(loc);
			
			//넣어줘야할 점수를 변수에 저장.
			String id = Username.get(Username.size()-1);
			String valueloc = timer.get(loc);
			String value = timer.get(timer.size()-1);
			
			
			//중복데이터 삭제
			String sql = del.append("delete from record_timer where id = ")
	                .append(id)
	                .append(";")
	                .toString();
			pstmt.executeUpdate(sql);
			
			//다시 데이터 입력
			String sql_ins = "insert into record_timer(GameUsername, time) values(?, ?)";
			pstmt.executeUpdate(sql_ins);
			pstmt.setString(1, id);
			if(flag) {
				pstmt.setString(2, valueloc); //기존데이터값이 새로들어온 데이터 값이 큰 경
			}
			else {
				pstmt.setString(2, value); //반대의 경우 
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
