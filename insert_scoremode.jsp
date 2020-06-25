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
		PreparedStatement stmt = null;
		Statement astmt = null;
		PreparedStatement itmt = null;
		StringBuilder sb = new StringBuilder();
		ResultSet rs = null;
		
		String username = (String)session.getAttribute("username");
		String point = request.getParameter("score");
		
		/*String SQL = sb.append("SELECT * FROM record_withouttimer" + " where")
                .append(" id = ")
                .append(userid)
                .append(";").toString();*/
		String SQL = "select * from record_withouttimer where GameUsername = '"+ username +"'";
		String driver = "com.mysql.jdbc.Driver";
		String[] temp = new String[5];
		Class.forName("com.mysql.jdbc.Driver");
		try{
			String jdbcDriver = "jdbc:mysql://webdev.iptime.org:3306/kgy?"+"useUnicode=true&characterEncoding=utf8";
			String dbUser = "kgy";
			String dbPass = "kgy1234";
			
				conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
				astmt = conn.createStatement();
				rs = astmt.executeQuery(SQL);
				while(rs.next()){
					temp[1] = rs.getString("GameUsername");
					temp[0] = rs.getString("point");
				}
				if(temp[1] == null){
					 String SQL_insert = "insert into record_withouttimer(GameUsername, point) values(?, ?)";
					 itmt = conn.prepareStatement(SQL_insert);
					 itmt.setString(1, username);
					 itmt.setString(2, point);
					 
					 itmt.executeUpdate();
					 
				}
				else{
					if(Integer.parseInt(point) > Integer.parseInt(temp[0])){
						String sql = "update record_withouttimer set point=? where GameUsername=?";
						stmt = conn.prepareStatement(sql);
						stmt.setString(2, username);
						stmt.setString(1, point);
						stmt.executeUpdate();
					}
				}
				%>
						
					<script>
						var point_r = <%=point%>;
						window.location.href="http://webdev.iptime.org:8080/kgy/Scoreend.jsp?point_r="+point_r;
					</script>
					
					
				<%
				
				
				%>
				
				<%
	}finally{
		if(pstmt != null) try{pstmt.close();}catch(Exception ex){}
		if(conn != null) try{conn.close();}catch(Exception ex){}
	}
%>
