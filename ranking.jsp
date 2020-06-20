<%@ page language="java" contentType ="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement"%>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.util.ArrayList" %>

<%
		request.setCharacterEncoding("utf-8"); // 앞단에서 넘겨준 값을 UTF-8로 캐릭터 인코딩을 하면 데이터베이스에 깨지지 않고 저장됩니다

		Connection conn = null;
    Statement pstmt =null;
    Statement stmt = null;
    ResultSet rs = null;
    ResultSet r = null;

		ArrayList<String> Usernamefortimer_1 = new ArrayList();
		ArrayList<String> Usernamefortimer_2 = new ArrayList();
		ArrayList<String> Usernamefortimer_3 = new ArrayList();
		ArrayList<String> Usernameforpoint_1 = new ArrayList();
		ArrayList<String> Usernameforpoint_2 = new ArrayList();
		ArrayList<String> Usernameforpoint_3 = new ArrayList();
		ArrayList<String> timer_1 = new ArrayList();
		ArrayList<String> timer_2 = new ArrayList();
		ArrayList<String> timer_3 = new ArrayList();
		ArrayList<String> point_1 = new ArrayList();
		ArrayList<String> point_2 = new ArrayList();
		ArrayList<String> point_3 = new ArrayList();
 
    
		// TODO Auto-generated constructor stub
		String jdbcDriver = "jdbc:mysql://webdev.iptime.org:3306/rkdus?"+"useUnicode=true&characterEncoding=utf8";
		String dbUser = "kgy";
		String dbPass = "kgy1234";

	    String SQL_time = "SELECT * FROM record_timer";
	    String SQL_point = "SELECT * FROM record_withouttimer";
	    String drive = "com.mysql.jdbc.Driver";

		try {
			Class.forName(drive);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			pstmt =  conn.createStatement();
			stmt =  conn.createStatement();
			//timer 모드
			rs = pstmt.executeQuery(SQL_time);
			while (rs.next()) {
				String GameUsername = rs.getString("GameUsername");
				String time = rs.getString("time");
				Usernamefortimer_1.add(GameUsername);
				timer_1.add(time);
			}
			int i;
		
			String[] t_loc = new String[3];
			String[] uname = new String[3];
			String tmp;
			tmp = "10000000";
			
			//find 1st
			for(i = 0; i < timer_1.size(); i++) {
				if(Integer.parseInt(tmp) > Integer.parseInt(timer_1.get(i))) {
					tmp = timer_1.get(i);
					uname[0] = Usernamefortimer_1.get(i);
					t_loc[0] = tmp;
				}
			}

			for(i = 0; i <timer_1.size(); i++) {
				if(t_loc[0] == timer_1.get(i)) {
					if(uname[0] == timer_1.get(i)) {
						//nothing
					}
				}
				else {
					timer_2.add(timer_1.get(i));
				}
			}

			for(i = 0; i <Usernamefortimer_1.size(); i++) {
				if(t_loc[0] == timer_1.get(i)) {
					if(uname[0] == Usernamefortimer_1.get(i)) {
						//nothing
					}
				}
				else {
					Usernamefortimer_2.add(Usernamefortimer_1.get(i));
				}
			}

			//find 2nd
			for(i = 0; i < timer_2.size(); i++) {
				if(Integer.parseInt(tmp) > Integer.parseInt(timer_2.get(i)) && Integer.parseInt(timer_2.get(i)) >= Integer.parseInt(t_loc[0])) {
					tmp = timer_2.get(i);
					uname[1] = Usernamefortimer_2.get(i);
					t_loc[1] = tmp;
				}
			}

			for(i = 0; i <timer_2.size(); i++) {
				if(t_loc[1] == timer_2.get(i)) {
					if(uname[1] == Usernamefortimer_2.get(i)) {
						//nothing
					}
				}
				else {
					timer_3.add(timer_2.get(i));
				}
			}

			for(i = 0; i <Usernamefortimer_2.size(); i++) {
				if(t_loc[1] == timer_2.get(i)) {
					if(uname[1] == Usernamefortimer_2.get(i)) {
						//nothing
					}
				}
				else {
					Usernamefortimer_3.add(Usernamefortimer_2.get(i));
				}
			}

			//find 3rd
			for(i = 0; i < timer_3.size(); i++) {
				if(Integer.parseInt(tmp) > Integer.parseInt(timer_3.get(i)) && Integer.parseInt(timer_3.get(i)) >= Integer.parseInt(t_loc[1])) {
					tmp = timer_3.get(i);
					uname[2] = Usernamefortimer_3.get(i);
					t_loc[2] = tmp;
				}
			}

			String username_1 = uname[0];
			String time_1 = t_loc[0];
			String username_2 = uname[1];
			String time_2 = t_loc[1];
			String username_3 = uname[2];
			String time_3 = t_loc[2];

			//point 모드
			r = stmt.executeQuery(SQL_point);
			while (r.next()) {
				String GameUsername = r.getString("GameUsername");
				String point_s = r.getString("point");
				Usernameforpoint_1.add(GameUsername);
				point_1.add(point_s);
			}
			String[] puname = new String[3];
			String[] p_loc = new String[3];
			String point1;
			point1 = "0";

			//find 1st
			for(i = 0; i < point_1.size(); i++) {
				if(Integer.parseInt(point1) < Integer.parseInt(point_1.get(i))) {
					point1 = point_1.get(i);
					p_loc[0] = point1;
					puname[0] = Usernameforpoint_1.get(i);

				}
			}

			for(i = 0; i <point_1.size(); i++) {
				if(p_loc[0] == point_1.get(i)) {
					if(puname[0] == point_1.get(i)) {
						//nothing
					}
				}
				else {
					point_2.add(point_1.get(i));
				}
			}

			for(i = 0; i <Usernameforpoint_1.size(); i++) {
				if(p_loc[0] == point_1.get(i)) {
					if(uname[0] == Usernameforpoint_1.get(i)) {
						//nothing
					}
				}
				else {
					Usernameforpoint_2.add(Usernameforpoint_1.get(i));
				}
			}
			//find 2nd
			for(i = 0; i < point_2.size(); i++) {
				if(Integer.parseInt(point1) < Integer.parseInt(point_2.get(i)) && Integer.parseInt(point_2.get(i)) <= Integer.parseInt(p_loc[0])) {
					point1 = point_2.get(i);
					p_loc[1] = point1;
					puname[1] = Usernameforpoint_2.get(i);
				}
			}

			for(i = 0; i <point_2.size(); i++) {
				if(p_loc[1] == point_2.get(i)) {
					if(puname[1] == Usernameforpoint_2.get(i)) {
						//nothing
					}
				}
				else {
					point_3.add(point_2.get(i));
				}
			}

			for(i = 0; i <Usernameforpoint_2.size(); i++) {
				if(p_loc[1] == point_2.get(i)) {
					if(uname[1] == Usernameforpoint_2.get(i)) {
						//nothing
					}
				}
				else {
					Usernameforpoint_3.add(Usernameforpoint_2.get(i));
				}
			}

			//find 3rd
			for(i = 0; i < point_3.size(); i++) {
				if(Integer.parseInt(point1) < Integer.parseInt(point_3.get(i)) && Integer.parseInt(point_3.get(i)) <= Integer.parseInt(p_loc[1])) {
					point1 = point_3.get(i);
					p_loc[2] = point1;
					puname[2] = Usernameforpoint_3.get(i);
				}
			}


			String p_username_1 = puname[0];
			String points_1 = p_loc[0];
			String p_username_2 = puname[1];
			String points_2 = p_loc[1];
			String p_username_3 = puname[2];
			String points_3 = p_loc[2];

		
		%>
<html lang="en">
 <head>
  <meta charset="UTF-8">
  <meta name="Generator" content="EditPlus®">
  <meta name="Author" content="">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
  <title>Document</title>
<style>
:root {
  --input-padding-x: 1.5rem;
  --input-padding-y: .75rem;
}
body {
  background: #007bff;
  background: linear-gradient(to right, #0062E6, #33AEFF);
}

#scoreBtn{
  border: 0;
  border-radius: 1rem;
  color: white;
  background-color: #42423E;
  width: 180px;
  padding: 5px;
  font-weight: bold;
  border-collapse: collapse;
  display: inline-block;
}

.card-signin {
  border: 0;
  border-radius: 1rem;
    background: #fff;
  text-align: center;
  box-shadow: 0 0.5rem 1rem 0 rgba(0, 0, 0, 0.1);
}
.card-signin .card-title {
  margin-bottom: 2rem;
  font-weight: 300;
  font-size: 1.5rem;
}
.card-signin .card-body {
  padding: 2rem;
}
.form-signin {
  width: 100%;
}
</style>
<body>
  <div class="container">
    <div class="row">
      <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
        <div class="card card-signin my-5">
          <div class="card-body">
            <h5 class="card-title text-center">Ranking</h5>
            <form class="form-signin">
            <hr class="my-4">
              <h5 class="card-title text-center">Score mode</h5>

			  <img src = https://image.flaticon.com/icons/svg/1949/1949434.svg width="200px" >
              
              <br>
              <td class='alignRight'>
                            <button id='scoreBtn'>3등 : <%=p_username_3%> <%=points_3%>점 </button>
              <td class='alignRight'>
                             <button id='scoreBtn'>1등 : <%=p_username_1%> <%=points_1%>점</button>
              <td class='alignRight'>
                            <button id='scoreBtn'>2등 : <%=p_username_2%> <%=points_2%>점</button></td>
              <br><br>
        
              <h5 class="card-title text-center">Timer mode</h5>
               <img src = https://image.flaticon.com/icons/svg/1949/1949434.svg width="200px" >
              
              <br>
              <td class='alignRight'>
                            <button id='scoreBtn'>3등 : <%=username_3%> <%=time_3%></button>
              <td class='alignRight'>
                           <button id='scoreBtn'>1등 : <%=username_1%> <%=time_1%></button>
              <td class='alignRight'>
                            <button id='scoreBtn'>2등 : <%=username_2%> <%=time_2%></button></td>
              <br><br>
			<input type="button" onclick="location.href='http://webdev.iptime.org:8080/kgy/modeselect.html'" value="종료하기" id=scoreBtn style="background-color:red"></button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
<%
		}catch (SQLException e) {
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
					stmt.close();
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

    
    
%>
