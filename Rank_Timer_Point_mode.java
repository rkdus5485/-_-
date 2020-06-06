package sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class Rank_Timer_Point_mode {
	private Connection conn;   
    private PreparedStatement pstmt; 
    private PreparedStatement stmt; 
    private ResultSet rs;
    private ResultSet r;
    ArrayList<String> Usernamefortimer = new ArrayList<String>();
    ArrayList<String> Usernameforpoint = new ArrayList<String>();
    ArrayList<String> timer = new ArrayList<String>();
    ArrayList<String> point = new ArrayList<String>();
    public Rank_Timer_Point_mode() {
		// TODO Auto-generated constructor stub
    	String dbURL="jdbc:mysql://localhost:3306/rkdus?" + "useUnicode=true&characterEncoding=utf8";                             
	    String dbID="kgy";
	    String dbPassword="kgy1234";
	    String SQL_time = "SELECT * FROM record_withouttimer";
	    String SQL_point = "SELECT * FROM record_withouttimer";
	    String drive = "com.mysql.jdbc.Driver";
		try {
			Class.forName(drive);
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			pstmt = (PreparedStatement) conn.createStatement();
			stmt = (PreparedStatement) conn.createStatement();
			//timer 모드 
			rs = pstmt.executeQuery(SQL_time);
			while (rs.next()) { 
				String GameUsername = rs.getString("GameUsername"); 
				String time = rs.getString("time"); 
				Usernamefortimer.add(GameUsername);
				timer.add(time);
			}
			int i;
			int[] t_loc = new int[3];
			String tmp;
			tmp = "1000000";
			//fine 1st
			for(i = 0; i < timer.size(); i++) {
				if(Integer.parseInt(tmp) > Integer.parseInt(timer.get(i))) {
					tmp = timer.get(i);
					t_loc[0] = i;
				}
			}
			//find 2nd
			for(i = 0; i < timer.size(); i++) {
				if(Integer.parseInt(tmp) > Integer.parseInt(timer.get(i)) && Integer.parseInt(timer.get(i)) >= Integer.parseInt(timer.get(t_loc[0]))) {
					tmp = timer.get(i);
					t_loc[1] = i;
				}
			}
			//find 3rd
			for(i = 0; i < timer.size(); i++) {
				if(Integer.parseInt(tmp) > Integer.parseInt(timer.get(i)) && Integer.parseInt(timer.get(i)) >= Integer.parseInt(timer.get(t_loc[1]))) {
					tmp = timer.get(i);
					t_loc[2] = i;
				}
			}

			
			System.out.println("1등 : "+Usernamefortimer.get(t_loc[0]) +"점수 : "+ timer.get(t_loc[0]));
			System.out.println("2등 : "+Usernamefortimer.get(t_loc[1]) +"점수 : "+ timer.get(t_loc[1]));
			System.out.println("3등 : "+Usernamefortimer.get(t_loc[2]) +"점수 : "+ timer.get(t_loc[2]));
			
			//point 모드 
			r = stmt.executeQuery(SQL_point);
			while (rs.next()) { 
				String GameUsername = rs.getString("GameUsername"); 
				String point = rs.getString("point"); 
				Usernameforpoint.add(GameUsername);
				timer.add(point);
			}
			int[] p_loc = new int[3];
			String point1;
			point1 = "0";
			
			for(i = 0; i < point.size(); i++) {
				if(Integer.parseInt(point1) > Integer.parseInt(point.get(i))) {
					point1 = point.get(i);
					p_loc[0] = i;
				}
			}
			//find 2nd
			for(i = 0; i < point.size(); i++) {
				if(Integer.parseInt(point1) > Integer.parseInt(point.get(i)) && Integer.parseInt(point.get(i)) >= Integer.parseInt(point.get(p_loc[0]))) {
					point1 = point.get(i);
					p_loc[1] = i;
				}
			}
			//find 3rd
			for(i = 0; i < point.size(); i++) {
				if(Integer.parseInt(point1) > Integer.parseInt(point.get(i)) && Integer.parseInt(point.get(i)) >= Integer.parseInt(point.get(p_loc[1]))) {
					point1 = point.get(i);
					p_loc[2] = i;
				}
			}
			
			
			
			System.out.println("1등 : "+Usernameforpoint.get(p_loc[0]) +"점수 : "+ point.get(p_loc[0]));
			System.out.println("2등 : "+Usernameforpoint.get(p_loc[1]) +"점수 : "+ point.get(p_loc[1]));
			System.out.println("3등 : "+Usernameforpoint.get(p_loc[2]) +"점수 : "+ point.get(p_loc[2]));
			
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
			if (r != null) {
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
			if (stmt != null) {
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
    

