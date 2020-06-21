<%@ page language="java" contentType ="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement"%>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.util.ArrayList"%>
<%		
		request.setCharacterEncoding("utf-8"); // 앞단에서 넘겨준 값을 UTF-8로 캐릭터 인코딩을 하면 데이터베이스에 깨지지 않고 저장됩니다
	
		Connection conn = null;
    Statement pstmt =null;
    Statement stmt = null;
    ResultSet rs = null;
    ResultSet r = null;

		ArrayList<String> Usernameforpoint = new ArrayList();
		ArrayList<String> pointer = new ArrayList();
		
		String username = (String)session.getAttribute("username");
		String point_r = request.getParameter("point_r");

		
	    String SQL_point = "SELECT * FROM record_withouttimer";
	    

		String jdbcDriver = "jdbc:mysql://webdev.iptime.org:3306/rkdus?"+"useUnicode=true&characterEncoding=utf8";
		String dbUser = "kgy";
		String dbPass = "kgy1234";
		
		String driver = "com.mysql.jdbc.Driver";
		Class.forName("com.mysql.jdbc.Driver");

		try{
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			pstmt =  conn.createStatement();
			stmt =  conn.createStatement();
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
			int i;

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
  <meta name="Generator" content="EditPlus®">
  <meta name="Author" content="">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
  <title>Score Mode</title>
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
              <h5 class="card-title text-center">Your Score</h5>
              <br>
			<input type="text" style ="border: none; background: transparent; font-size:50pt;font-weight:bold;color:#0054FF;" value="	<%=point_r%>점">	
				  <br><br><br><br>
              <hr class="my-4">
            <h5 class="card-title text-center">Score Ranking</h5>
 <img src = https://image.flaticon.com/icons/svg/1949/1949434.svg width="200px" >
              
              <br>
              <td class='alignRight'>
                            <button id='scoreBtn'>3등 : <%=p_username_3%> <%=points_3%>점 </button>
              <td class='alignRight'>
                            <button id='scoreBtn'>1등 : <%=p_username_1%> <%=points_1%>점 </button>
              <td class='alignRight'>
                            <button id='scoreBtn'>2등 : <%=p_username_2%> <%=points_2%>점 </button>
              <br><br>
			<td class='alignRight'>
                            <input type="button" onclick="location.href='http://webdev.iptime.org:8080/kgy/maingame_score.jsp'" value="다시하기" id='scoreBtn'></td></td>
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
