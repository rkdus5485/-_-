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

		ArrayList<String> Usernamefortimer = new ArrayList();
		ArrayList<String> Usernameforpoint = new ArrayList();
		ArrayList<String> timer = new ArrayList();
		ArrayList<String> pointer = new ArrayList();



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
				Usernamefortimer.add(GameUsername);
				timer.add(time);
			}
			int i;

			String[] t_loc = new String[3];
			String[] uname = new String[3];
			int[] count = new int[3];
			String tmp;
			tmp = "10000000";

			//find 1st
			for(i = 0; i < timer.size(); i++) {
				if(Integer.parseInt(tmp) > Integer.parseInt(timer.get(i))) {
					tmp = timer.get(i);
					uname[0] = Usernamefortimer.get(i);
					t_loc[0] = tmp;
					count[0]=i;
				}
			}
			Usernamefortimer.remove(count[0]);
			timer.remove(count[0]);

			//find 2nd
			String temp = "1000000";
			for(i = 0; i < timer.size(); i++) {
			if(Integer.parseInt(temp) > Integer.parseInt(timer.get(i))) {
					temp = timer.get(i);
					t_loc[1] = temp;
					uname[1] = Usernamefortimer.get(i);
					count[1] = i;
				}
			}
			Usernamefortimer.remove(count[1]);
			timer.remove(count[1]);

			//find 3rd
			String temp_="1000000";
			for(i = 0; i < timer.size(); i++) {
				if(Integer.parseInt(temp_) > Integer.parseInt(timer.get(i))) {
					temp_ = timer.get(i);
					t_loc[2] = temp_;
					uname[2] = Usernamefortimer.get(i);
					count[2] = i;
				}
			}
			Usernamefortimer.remove(count[0]);
			timer.remove(count[0]);

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
				String point = r.getString("point");
				Usernameforpoint.add(GameUsername);
				pointer.add(point);
			}
			String[] puname = new String[3];
			String[] p_loc = new String[3];
			int[] count_p = new int[3];
			String point1;
			point1 = "0";

			//find 1st
			for(i = 0; i <pointer.size(); i++) {
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
			String point_2="0";
			for(i = 0; i < pointer.size(); i++) {
				if(Integer.parseInt(point_2) < Integer.parseInt(pointer.get(i))) {
					point_2 = pointer.get(i);
					p_loc[1] = point_2;
					puname[1] = Usernameforpoint.get(i);
					count_p[1] = i;
				}
			}
			Usernameforpoint.remove(count_p[1]);
			pointer.remove(count_p[1]);

			//find 3rd
			String point3="0";
			for(i = 0; i <pointer.size(); i++) {
				if(Integer.parseInt(point3) < Integer.parseInt(pointer.get(i))) {
					point3 = pointer.get(i);
					p_loc[2] = point3;
					puname[2] = Usernameforpoint.get(i);
					count_p[2] = i;
				}
			}
			Usernameforpoint.remove(count_p[2]);
			pointer.remove(count_p[2]);



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
  <title>Ranking</title>
<style>
:root {
  --input-padding-x: 1.5rem;
  --input-padding-y: .75rem;
}
body {
  background: #007bff;
  background: linear-gradient(to right, #0062E6, #33AEFF);
}
#scoreBtn2{
  border: 0;
  border-radius: 1rem;
  color: white;
  font-size:15px;
   background-color: #999999;
  width: 40%;
  padding: 5px;
  font-weight: bold;
  border-collapse: collapse;
  display: inline-block;
}

#scoreBtn{
  border: 0;
  border-radius: 1rem;
  color: white;
  font-size:15px;
  background-color: #42423E;
  width: 40%;
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
  margin-bottom: 1rem;
  font-weight: 100%;
  font-size: 1.5rem;
  font-size:25px;
}
.card-signin .card-body {
  padding: 1rem;
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
            <form class="form-signin"><input type="button" onclick="location.href='http://webdev.iptime.org:8080/kgy/modeselect.html'" value="종료하기" id=scoreBtn style="background-color:red; float:right;"></button><br><br>
              <span class="card-title text-center">Score Ranking</span>
 <img src = https://image.flaticon.com/icons/svg/1949/1949434.svg height="175px" width="80%" >

              <br>
              <td class='alignRight'>
                            <button id='scoreBtn'>1등 : <%=p_username_1%><br><%=points_1%>점 </button>
							<br><br>
              <td class='alignRight'>
							<button id='scoreBtn2'>2등 : <%=p_username_2%><br><%=points_2%>점 </button>
              <td class='alignRight'>
                            <button id='scoreBtn2'>3등 : <%=p_username_3%><br><%=points_3%>점 </button>
              <br>
          <hr class="my-4">
              <div class="card-title text-center">Timer Ranking</div>
 <img src = https://image.flaticon.com/icons/svg/1949/1949434.svg height="175px" width="80%" >
              <br>
                               <td class='alignRight'>
                            <button id='scoreBtn'>1등 : <%=username_1%><%
					int length_1 = time_1.length();
					if(length_1 == 4) {
					%>
						<div id='maxtime' name='maxtime'>00 : <%=time_1.substring(0,2)%> : <%=time_1.substring(2,4)%> </div>

					<%
					}else if(length_1 == 5){
						%>
								<div id='maxtime' name='maxtime'>0<%=time_1.substring(0,1)%> : <%=time_1.substring(1,3)%> : <%=time_1.substring(3,5)%></div>

						<%
					}
					else if(length_1 == 6) {
						%>
							<div id='maxtime' name='maxtime'><%=time_1.substring(0,2)%> : <%=time_1.substring(2,4)%> : <%=time_1.substring(4,6)%></div>
						<%
					}else if(length_1 == 3){
						%>
							<div id='maxtime' name='maxtime'>00 : 0<%=time_1.substring(0,1)%> : <%=time_1.substring(1,3)%></div>
						<%
					}
			  %>
							</button>
                              <br><br>

              <td class='alignRight'>
                            <button id='scoreBtn2'>2등 : <%=username_2%><%
					int length_2 = time_2.length();
					if(length_2 == 4) {
					%>
						<div id='maxtime' name='maxtime'>00 : <%=time_2.substring(0,2)%> : <%=time_2.substring(2,4)%> </div>

					<%
					}else if(length_2 == 5){
						%>
								<div id='maxtime' name='maxtime'>0<%=time_2.substring(0,1)%> : <%=time_2.substring(1,3)%> : <%=time_2.substring(3,5)%></div>

						<%
					}
					else if(length_2 == 6) {
						%>
							<div id='maxtime' name='maxtime'><%=time_2.substring(0,2)%> : <%=time_2.substring(2,4)%> : <%=time_2.substring(4,6)%></div>
						<%
					}else if(length_2 == 3){
						%>
							<div id='maxtime' name='maxtime'>00 : 0<%=time_2.substring(0,1)%> : <%=time_2.substring(1,3)%></div>
						<%
					}
			  %></button>
                              <td class='alignRight'>
                            <button id='scoreBtn2'>3등 : <%=username_3%><%
					int length_3 = time_3.length();
					if(length_3 == 4) {
					%>
						<div id='maxtime' name='maxtime'>00 : <%=time_3.substring(0,2)%> : <%=time_3.substring(2,4)%> </div>

					<%
					}else if(length_3 == 5){
						%>
								<div id='maxtime' name='maxtime'>0<%=time_3.substring(0,1)%> : <%=time_3.substring(1,3)%> : <%=time_3.substring(3,5)%></div>

						<%
					}
					else if(length_3 == 6) {
						%>
							<div id='maxtime' name='maxtime'><%=time_3.substring(0,2)%> : <%=time_3.substring(2,4)%> : <%=time_3.substring(4,6)%></div>
						<%
					}else if(length_3 == 3){
						%>
							<div id='maxtime' name='maxtime'>00 : 0<%=time_3.substring(0,1)%> : <%=time_3.substring(1,3)%></div>
						<%
					}
			  %>

							</button></td>
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
