<!--회원가입 시 입력된 아이디와 비밀번호와 닉네임을 디비에 저장 후 회원가입이 완료되면 로그인 페이지로 이동시켜주는 jsp파일입니다. -->
<%@ page contentType = "text/html; charset=utf-8" %>

<%@ page import = "java.sql.DriverManager"%>
<%@ page import = "java.sql.Connection"%>
<%@ page import = "java.sql.PreparedStatement"%>
<%@ page import = "java.sql.SQLException"%>
<%@ page import = "java.io.PrintWriter" %>

<%
	request.setCharacterEncoding("utf-8"); // 앞단에서 넘겨준 값을 UTF-8로 캐릭터 인코딩을 하면 데이터베이스에 깨지지 않고 저장됩니다
	
	String UserID = request.getParameter("userid");
	String UserPW = request.getParameter("userpw");
	String Username = request.getParameter("username");

	Connection conn = null;
	PreparedStatement pstmt = null;

	try{
		String jdbcDriver = "jdbc:mysql://webdev.iptime.org:3306/rkdus?"+"useUnicode=true&characterEncoding=utf8";
		String dbUser = "kgy";
		String dbPass = "kgy1234";
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		pstmt = conn.prepareStatement("insert into login_game(GameID, GamePW, GameUsername) values(?,?,?)");

		pstmt.setString(1, UserID);
		pstmt.setString(2, UserPW);
		pstmt.setString(3, Username);
        
		pstmt.executeUpdate();
		PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('회원가입 되었습니다. 로그인 페이지로 이동합니다.')");
				script.println("</script>");
				%>
				<script>
				window.location.href="http://webdev.iptime.org:8080/kgy/maingame.html";
				</script>
				<%
		

	}finally{
		if(pstmt != null) try{pstmt.close();}catch(Exception ex){}
		if(conn != null) try{conn.close();}catch(Exception ex){}
	}
%>
