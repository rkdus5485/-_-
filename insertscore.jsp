
<%@ page language="java" contentType ="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement"%>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%		
		request.setCharacterEncoding("utf-8"); // 앞단에서 넘겨준 값을 UTF-8로 캐릭터 인코딩을 하면 데이터베이스에 깨지지 않고 저장됩니다
	
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String userid = (String)session.getAttribute("userid");
		String score = request.getParameter("score");
		try{
			String jdbcDriver = "jdbc:mysql://webdev.iptime.org:3306/rkdus?"+"useUnicode=true&characterEncoding=utf8";
			String dbUser = "kgy";
			String dbPass = "kgy1234";

			

				conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);


		
				pstmt = conn.prepareStatement("insert into record_withouttimer(GameUsername, point) values (?,?)");
		
				pstmt.setString(1, userid);
				pstmt.setString(2, score);

				pstmt.executeUpdate();
			
				%>
					<!--정보 저장 후 이동할 페이지-->
				<script>
				window.location.href="http://webdev.iptime.org:8080/kgy/gamesignin.html";
				</script>
				<%

	}finally{
		if(pstmt != null) try{pstmt.close();}catch(Exception ex){}
		if(conn != null) try{conn.close();}catch(Exception ex){}
	}
%>
