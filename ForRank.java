package sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class ForRank {
	private Connection conn;   
    private PreparedStatement pstmt; 
    private PreparedStatement stmt; 
    private ResultSet rs;
    private ResultSet r;
    
    ArrayList<String> Usernamefortimer = new ArrayList<String>();
    ArrayList<String> Usernameforpoint = new ArrayList<String>();

    ArrayList<String> timer = new ArrayList<String>();
    ArrayList<String> pointer = new ArrayList<String>();
     
    public ForRank() {
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
			String[] t_loc = new String[3];
			String[] uname = new String[3];
			int[] count = new int[3];
			
			String tmp = "100000000";
			//fine 1st
			for(int i = 0; i <timer.size(); i++) {
				if(Integer.parseInt(tmp) > Integer.parseInt(timer.get(i))) {
					tmp = timer.get(i);
					t_loc[0] = tmp;
					uname[0] = Usernamefortimer.get(i);
					count[0] = i;
				}
			}
			Usernamefortimer.remove(count[0]);
			timer.remove(count[0]);

			
			//find 2nd
			String temp = "100000000";
			for(int i = 0; i<timer.size(); i++) {
				if(Integer.parseInt(temp) > Integer.parseInt(timer.get(i))) {
					temp = timer.get(i);
					t_loc[1] = temp;
					uname[1] = Usernamefortimer.get(i);
					count[1] = i;
				}
			};
			Usernamefortimer.remove(count[1]);
			timer.remove(count[1]);
			
			//find 3rd
			String temp_ = "100000000";
			for(int i = 0; i<timer.size(); i++) {
				if(Integer.parseInt(temp_) > Integer.parseInt(timer.get(i))) {
					temp_ = timer.get(i);
					t_loc[2] = temp_;
					uname[2] = Usernamefortimer.get(i);
					count[2] = i;
				}
			}
			Usernamefortimer.remove(count[2]);
			timer.remove(count[2]);
			

			
			System.out.println("1등 : "+uname[0] +" 점수 : "+ t_loc[0]);
			System.out.println("2등 : "+uname[1] +" 점수 : "+ t_loc[1]);
			System.out.println("3등 : "+uname[2] +" 점수 : "+ t_loc[2]);
			
			//point 모드 
			r = stmt.executeQuery(SQL_point);
			while (rs.next()) { 
				String GameUsername = rs.getString("GameUsername"); 
				String point = rs.getString("point"); 
				Usernameforpoint.add(GameUsername);
				pointer.add(point);
			}
			String[] puname = new String[3];
			String[] p_loc = new String[3];
			int[] count_p = new int[1];
			String point1;
			point1 = "0";
			
			for(int i = 0; i <pointer.size(); i++) {
				if(Integer.parseInt(point1) < Integer.parseInt(pointer.get(i))) {
					point1 = pointer.get(i);
					p_loc[0] = point1;
					puname[0] = Usernameforpoint.get(i);
					count_p[0] = i;
				}
			}
			Usernameforpoint.remove(count_p[0]);
			pointer.remove(count_p[0]);
			
			//find 2nd
			String point_2 = "0";
			for(int i = 0; i <pointer.size(); i++) {
				if(Integer.parseInt(point_2) < Integer.parseInt(pointer.get(i))) {
					point_2 = pointer.get(i);
					p_loc[1] = point_2;
					puname[1] = Usernameforpoint.get(i);
					count_p[0] = i;
				}
			}
			Usernameforpoint.remove(count_p[0]);
			pointer.remove(count_p[0]);
			
			//find 3rd
			String point3 = "0";
			for(int i = 0; i <pointer.size(); i++) {
				if(Integer.parseInt(point3) < Integer.parseInt(pointer.get(i))) {
					point3 = pointer.get(i);
					p_loc[2] = point3;
					puname[2] = Usernameforpoint.get(i);
					count_p[0] = i;
				}
			}
			Usernameforpoint.remove(count_p[0]);
			pointer.remove(count_p[0]);
			
			
			
			
			
			System.out.println("1등 : "+puname[0] +"점수 : "+ p_loc[0]);
			System.out.println("2등 : "+puname[1] +"점수 : "+ p_loc[1]);
			System.out.println("3등 : "+puname[2] +"점수 : "+ p_loc[2]);
			
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
    

