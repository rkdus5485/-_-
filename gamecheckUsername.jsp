<%@ page language="java" contentType="text/html; charset=utf-8"%>


<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import = "java.sql.Connection"%>
<%@ page import = "java.sql.PreparedStatement"%>
<%@ page import = "java.sql.SQLException"%>
<%@ page import = "java.io.PrintWriter" %>

<!DOCTYPE html>
<html lang="ko">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>이메일 중복확인</title>

<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	String username = request.getParameter("username");

	try{
		String jdbcDriver = "jdbc:mysql://webdev.iptime.org:3306/rkdus?"+"useUnicode=true&characterEncoding=utf8";
		String dbUser = "kgy";
			String dbPass = "kgy1234";

		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		pstmt = conn.prepareStatement("select GameUsername from login_game where GameUsername=?");
		pstmt.setString(1, username);
		rs=pstmt.executeQuery();
	}
	finally{
	}
		
%>

	<script>

		
	
		function btnClose(){
			var semail=document.checkform;
			opener.document.signupform.username.value="<%=username%>";
			window.close();
	};
	</script>
</head>
<body>
	<form action="gamecheckUsername.jsp" id="checkform">
		<%
		try{
			if(rs.next()){
			%>
				현재 <%=username%>은 사용 중입니다.<br><br>
				닉네임 : <input type="text" name="username"></input>
				<input type="submit" value="중복확인"></input>
				<%
			}
			else
		{
			%>
			<%=username%>은 사용 가능합니다.
			<input type="button" value="사용하기" onClick="btnClose('<?=$username?>')">
			<%
		}
	}catch(SQLException e){e.printStackTrace();}
	finally{
		if(pstmt != null) try{pstmt.close();}catch(Exception ex){}
		if(conn != null) try{conn.close();}catch(Exception ex){}
		if(rs != null) try{rs.close();}catch(Exception ex){}
		}%>
	</form>
</body>

</html>