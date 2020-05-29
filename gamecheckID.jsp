<!--회원가입 시 입력한 아이디가 기존에 다른 사용자가 사용하는 아이디와 중복되는지 확인하고 중복이 되지않으면 
사용할 수 있도록 하고, 중복이 되면 사용할 수 없도록 하는 아이디 중복확인 jsp파일입니다.-->
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
	<title>아이디 중복확인</title>

<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	String userid = request.getParameter("userid");

	try{
		String jdbcDriver = "jdbc:mysql://webdev.iptime.org:3306/rkdus?"+"useUnicode=true&characterEncoding=utf8";
		String dbUser = "kgy";
			String dbPass = "kgy1234";

		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		pstmt = conn.prepareStatement("select GameID from login_game where GameID=?");
		pstmt.setString(1, userid);
		rs=pstmt.executeQuery();
	}
	finally{
	}
		
%>

	<script>

		
	
		function btnClose(){
			var sid=document.checkform;
			opener.document.signupform.userid.value="<%=userid%>";
			window.close();
	};
	</script>
</head>
<body>
	<form action="gamecheckID.jsp" id="checkform">
		<%
		try{
			if(rs.next()){
			%>
				현재 <%=userid%> 는 사용 불가입니다 <br><br>
				ID : <input type="text" name="userid"></input>
				<input type="submit" value="중복 확인"></input>
				<%
			}
			else
		{
			%>
			<%=userid%> 는 사용 가능 합니다
			<input type="button" value="사용하기" onClick="btnClose('<?=$userid?>')">
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
