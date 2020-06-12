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
		ArrayList<String> point = new ArrayList();

    
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

			String username_1 = Usernamefortimer.get(t_loc[0]);
			String time_1 = timer.get(t_loc[0]);
			String username_2 = Usernamefortimer.get(t_loc[1]);
			String time_2 = timer.get(t_loc[1]);
			String username_3 = Usernamefortimer.get(t_loc[2]);
			String time_3 = timer.get(t_loc[2]);

			//point 모드
			r = stmt.executeQuery(SQL_point);
			while (r.next()) {
				String GameUsername = r.getString("GameUsername");
				String point_s = r.getString("point");
				Usernameforpoint.add(GameUsername);
				point.add(point_s);
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

			String p_username_1 = Usernameforpoint.get(p_loc[0]);
			String point_1 = point.get(p_loc[0]);
			String p_username_2 = Usernameforpoint.get(p_loc[1]);
			String point_2 = point.get(p_loc[1]);
			String p_username_3 = Usernameforpoint.get(p_loc[2]);
			String point_3 = point.get(p_loc[2]);

		
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
              <h5 class="card-title text-center">1등 ★★★점</h5>
              <hr class="my-4">
              <h5 class="card-title text-center">2등 ★★★점</h5>
              <hr class="my-4">
              <h5 class="card-title text-center">3등 ★★★점</h5>
              <h5 class="card-title text-center">Score mode</h5>
              <img src = "https://data.silhouette-ac.com/data/thumbnails/a8/a89250c3a9e3e5dad77b8f52f0b9ca94_w.jpeg" width="200px" >
              <img src = "https://data.silhouette-ac.com/data/thumbnails/a8/a89250c3a9e3e5dad77b8f52f0b9ca94_w.jpeg" width="200px" >
              <img src = "https://data.silhouette-ac.com/data/thumbnails/a8/a89250c3a9e3e5dad77b8f52f0b9ca94_w.jpeg" width="200px" >
              <br>
              <td class='alignRight'>
                            <button id='scoreBtn'>3등 : <%=p_username_3%> <%=point_3%>점 </button>
              <td class='alignRight'>
                            <button id='scoreBtn'>1등 : <%=p_username_1%> <%=point_1%>점</button>
              <td class='alignRight'>
                            <button id='scoreBtn'>2등 : <%=p_username_2%> <%=point_2%>점</button></td>
              <hr class="my-4">
              <h5 class="card-title text-center">4# ○○○ ☆☆☆점</h5>
              <h5 class="card-title text-center">Timer mode</h5>
              <img src = "https://data.silhouette-ac.com/data/thumbnails/a8/a89250c3a9e3e5dad77b8f52f0b9ca94_w.jpeg" width="200px" >
              <img src = "https://data.silhouette-ac.com/data/thumbnails/a8/a89250c3a9e3e5dad77b8f52f0b9ca94_w.jpeg" width="200px" >
              <img src = "https://data.silhouette-ac.com/data/thumbnails/a8/a89250c3a9e3e5dad77b8f52f0b9ca94_w.jpeg" width="200px" >
              <br>
              <td class='alignRight'>
                            <button id='scoreBtn'>3등 : <%=username_3%> <%=time_3%></button>
              <td class='alignRight'>
                            <button id='scoreBtn'>1등 : <%=username_1%> <%=time_1%></button>
              <td class='alignRight'>
                            <button id='scoreBtn'>2등 : <%=username_2%> <%=time_2%></button></td>
			
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
