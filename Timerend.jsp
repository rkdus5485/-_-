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
		ArrayList<String> timer = new ArrayList();
		
		String username = (String)session.getAttribute("username");
		String time_r = request.getParameter("time_r");
		String SQL_time = "SELECT * FROM record_timer";
		String jdbcDriver = "jdbc:mysql://webdev.iptime.org:3306/rkdus?"+"useUnicode=true&characterEncoding=utf8";
		String dbUser = "kgy";
		String dbPass = "kgy1234";
		
		String driver = "com.mysql.jdbc.Driver";
		Class.forName("com.mysql.jdbc.Driver");

		try{
				Class.forName(driver);
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

		
			
		
%>
<html lang="en">
 <head>
  <meta charset="UTF-8">
  <meta name="Generator" content="EditPlus®">
  <meta name="Author" content="">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
  <title>Timer Mode</title>
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
</head>
<body>
  <div class="container">
    <div class="row">
      <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
        <div class="card card-signin my-5">
          <div class="card-body">
            <h5 class="card-title text-center"></h5>
            <form class="form-signin">
              <h5 class="card-title text-center">Your Time</h5>
              <br>
			  <%
					int length = time_r.length();
					if(length == 4){
					%>
						<div id='maxtime' name='maxtime'><input type="text" style ="border: none; background: transparent; font-size:50pt;font-weight:bold;color:#0054FF;" value="  00 : <%=time_r.substring(0,2)%> : <%=time_r.substring(2,4)%> "></div><br><br>
	
					<%
					}else if(length == 5){
					%>
						<div id='maxtime' name='maxtime'><input type="text" style ="border: none; background: transparent; font-size:50pt;font-weight:bold;color:#0054FF;" value="  0<%=time_r.substring(0,1)%> : <%=time_r.substring(1,3)%> : <%=time_r.substring(3,5)%>"></div><br><br>
	
					<%
					}else if(length == 6) {
						%>
								<div id='maxtime' name='maxtime'><input type="text" style ="border: none; background: transparent; font-size:50pt;font-weight:bold;color:#0054FF;" value="  <%=time_r.substring(0,2)%> : <%=time_r.substring(2,4)%> : <%=time_r.substring(4,6)%>"></div><br><br>
						
						<%
					}else if(length == 3) {
						%>
								<div id='maxtime' name='maxtime'><input type="text" style ="border: none; background: transparent; font-size:50pt;font-weight:bold;color:#0054FF;" value="  00 : 0<%=time_r.substring(0,1)%> : <%=time_r.substring(1,3)%>"></div><br><br>

								
						<%
						}
				%>	
				  <br><br><br><br>
              <hr class="my-4">
            <h5 class="card-title text-center">Timer Ranking</h5>
 <img src = https://image.flaticon.com/icons/svg/1949/1949434.svg width="200px" >
              
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
                            <button id='scoreBtn'>2등 : <%=username_2%><%
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
                            <button id='scoreBtn'>3등 : <%=username_3%><%
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
							
							</button>
              <br><br>
              <td class='alignRight'>
                            <input type="button" onclick="location.href='http://webdev.iptime.org:8080/kgy/maingame_timer.jsp'" value="다시하기" id='scoreBtn'></td></td>
              <td class='alignRight'>
			  				<input type="button" onclick="location.href='http://webdev.iptime.org:8080/kgy/modeselect.html'" value="모드선택" id='scoreBtn'></td>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
<%
	}finally{
		if(pstmt != null) try{pstmt.close();}catch(Exception ex){}
		if(conn != null) try{conn.close();}catch(Exception ex){}
	}
%>
