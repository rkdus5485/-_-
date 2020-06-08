<!--로그인 창에 입력된 아이디와 비밀번호를 디비에 저장된 데이터와 비교하여 맞으면 게임페이지로, 틀리면 아이디 또는 비밀번호가
잘못되었다고 알려주는 jsp파일입니다.-->
<%@ page contentType="text/html; charset=utf-8" %>

<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.io.PrintWriter" %>

<%
	//username 한글일 경우도 가능
	request.setCharacterEncoding("utf-8");
	
	String userid = request.getParameter("userid");
	String userpw = request.getParameter("userpw");

%>

<html>
	<head>
		<title>
			login
		</title>
	</head>
<body>
	<%
		Class.forName("com.mysql.jdbc.Driver");

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;


		try{
			String jdbcDriver = "jdbc:mysql://webdev.iptime.org:3306/rkdus?"+"useUnicode=true&characterEncoding=utf8";
			String dbUser = "kgy";
			String dbPass = "kgy1234";

			String query ="select GameId, GamePW from login_game where GameID='"+userid+"' and GamePW='"+userpw+"'";

			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);

			if(rs.next()){
				PrintWriter script = response.getWriter();
				session.setAttribute("userid",userid);
				script.println("<script>");
				script.println("alert('로그인 되었습니다')");
				script.println("</script>");
				%>
				<script>
				window.location.href="http://webdev.iptime.org:8080/kgy/maingame.html";
				</script>
<%


			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('아이디/비밀번호 를 확인해 주세요')");
				script.println("</script>");
				%>
					<script>
					window.location.href="http://webdev.iptime.org:8080/kgy/gamesignin.html"
					</script>
					<%
			}



		}catch(Exception ex){

		}finally{
		if(rs != null) try{rs.close();}catch(SQLException ex){}
		if(stmt != null) try{stmt.close();} catch(SQLException ex){}
		if(conn != null) try{conn.close();} catch(SQLException ex){}
		}
	%>
</body>
</html>
