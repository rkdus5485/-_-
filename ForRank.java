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
    ArrayList<String> Usernamefortimer_second = new ArrayList<String>();
    ArrayList<String> Usernamefortimer_third = new ArrayList<String>();
    ArrayList<String> Usernameforpoint = new ArrayList<String>();
    ArrayList<String> Usernameforpoint_second = new ArrayList<String>();
    ArrayList<String> Usernameforpoint_third = new ArrayList<String>();
    ArrayList<String> timerfirst = new ArrayList<String>();
    ArrayList<String> timersecond = new ArrayList<String>();
    ArrayList<String> timerthird = new ArrayList<String>();
    ArrayList<String> pointfirst = new ArrayList<String>();
    ArrayList<String> point_second = new ArrayList<String>();
    ArrayList<String> point_third = new ArrayList<String>();
    
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
				timerfirst.add(time);
			}
			int i;
			String[] t_loc = new String[3];
			String[] uname = new String[3];
			String tmp;
			tmp = "10000000000";
			//fine 1st
			for(i = 0; i < timerfirst.size(); i++) {
				if(Integer.parseInt(tmp) > Integer.parseInt(timerfirst.get(i))) {
					tmp = timerfirst.get(i);
					uname[0] = Usernamefortimer.get(i);
					t_loc[0] = tmp;
				}
			}
			for(i = 0; i <timerfirst.size(); i++) {
				if(t_loc[0] == timerfirst.get(i)) {
					if(uname[0] == timerfirst.get(i)) {
						//nothing
					}
				}
				else {
					timersecond.add(timerfirst.get(i));
				}
			}
			
			for(i = 0; i <Usernamefortimer.size(); i++) {
				if(t_loc[0] == timerfirst.get(i)) {
					if(uname[0] == Usernamefortimer.get(i)) {
						//nothing
					}
				}
				else {
					Usernamefortimer_second.add(Usernamefortimer.get(i));
				}
			}
			
			//find 2nd
			for(i = 0; i < timersecond.size(); i++) {
				if(Integer.parseInt(tmp) > Integer.parseInt(timersecond.get(i)) && Integer.parseInt(timersecond.get(i)) >= Integer.parseInt(t_loc[0])) {
					tmp = timersecond.get(i);
					t_loc[1] = tmp;
					uname[1] = Usernamefortimer_second.get(i);
				}
			}
			for(i = 0; i <timersecond.size(); i++) {
				if(t_loc[1] == timersecond.get(i)) {
					if(uname[1] == Usernamefortimer_second.get(i)) {
						//nothing
					}
				}
				else {
					timerthird.add(timersecond.get(i));
				}
			}
			for(i = 0; i <Usernamefortimer_second.size(); i++) {
				if(t_loc[1] == timersecond.get(i)) {
					if(uname[1] == Usernamefortimer_second.get(i)) {
						//nothing
					}
				}
				else {
					Usernamefortimer_third.add(Usernamefortimer_second.get(i));
				}
			}
			
			
			//find 3rd
			for(i = 0; i < timerthird.size(); i++) {
				if(Integer.parseInt(tmp) > Integer.parseInt(timerthird.get(i)) && Integer.parseInt(timerthird.get(i)) >= Integer.parseInt(t_loc[1])) {
					tmp = timerthird.get(i);
					t_loc[2] = tmp;
					uname[2]= Usernamefortimer_third.get(i);
				}
			}

			
			System.out.println("1등 : "+uname[0] +"점수 : "+ t_loc[0]);
			System.out.println("2등 : "+uname[1] +"점수 : "+ t_loc[1]);
			System.out.println("3등 : "+uname[2] +"점수 : "+ t_loc[2]);
			
			//point 모드 
			r = stmt.executeQuery(SQL_point);
			while (rs.next()) { 
				String GameUsername = rs.getString("GameUsername"); 
				String point = rs.getString("point"); 
				Usernameforpoint.add(GameUsername);
				pointfirst.add(point);
			}
			String[] puname = new String[3];
			String[] p_loc = new String[3];
			String point1;
			point1 = "0";
			
			for(i = 0; i < pointfirst.size(); i++) {
				if(Integer.parseInt(point1) < Integer.parseInt(pointfirst.get(i))) {
					point1 = pointfirst.get(i);
					p_loc[0] = point1;
					puname[0]=Usernameforpoint.get(i);
					
				}
			}
			for(i = 0; i <pointfirst.size(); i++) {
				if(t_loc[0] == pointfirst.get(i)) {
					if(uname[0] == pointfirst.get(i)) {
						//nothing
					}
				}
				else {
					timersecond.add(pointfirst.get(i));
				}
			}
			
			for(i = 0; i <Usernameforpoint.size(); i++) {
				if(t_loc[0] == pointfirst.get(i)) {
					if(uname[0] == Usernameforpoint.get(i)) {
						//nothing
					}
				}
				else {
					Usernameforpoint_second.add(Usernameforpoint.get(i));
				}
			}
			//find 2nd
			for(i = 0; i < point_second.size(); i++) {
				if(Integer.parseInt(point1) < Integer.parseInt(point_second.get(i)) && Integer.parseInt(point_second.get(i)) <= Integer.parseInt(p_loc[0])) {
					point1 = point_second.get(i);
					p_loc[1] = point1;
					puname[1] = Usernameforpoint_second.get(i);
				}
			}
			for(i = 0; i <point_second.size(); i++) {
				if(t_loc[1] == point_second.get(i)) {
					if(uname[1] == Usernameforpoint_second.get(i)) {
						//nothing
					}
				}
				else {
					point_third.add(point_second.get(i));
				}
			}
			for(i = 0; i <Usernameforpoint_second.size(); i++) {
				if(t_loc[1] == point_second.get(i)) {
					if(uname[1] == Usernameforpoint_second.get(i)) {
						//nothing
					}
				}
				else {
					Usernameforpoint_third.add(Usernameforpoint_second.get(i));
				}
			}
			//find 3rd
			for(i = 0; i < point_third.size(); i++) {
				if(Integer.parseInt(point1) < Integer.parseInt(point_third.get(i)) && Integer.parseInt(point_third.get(i)) <= Integer.parseInt(p_loc[1])) {
					point1 = point_third.get(i);
					p_loc[2] = point1;
					puname[2] = Usernameforpoint_third.get(i);
				}
			}
			
			
			
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
    

