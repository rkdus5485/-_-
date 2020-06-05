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

		StringBuilder sb = new StringBuilder();
		


		String userid = (String)session.getAttribute("userid");
		String point = request.getParameter("point");
		
		String SQL = sb.append("SELECT * FROM record_withouttimer" + " where")
                .append(" id = ")
                .append(userid)
                .append(";").toString();
		String driver = "com.mysql.jdbc.Driver";
		String[] temp = new String[5];

		try{
			String jdbcDriver = "jdbc:mysql://webdev.iptime.org:3306/rkdus?"+"useUnicode=true&characterEncoding=utf8";
			String dbUser = "kgy";
			String dbPass = "kgy1234";
			Class.forName(driver);
				conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
				ResultSet rs = pstmt.executeQuery(SQL);
				while(rs.next()){
					String name = rs.getString("GameUsername");
					temp[0] = rs.getString("point");
				}
				
				if(Integer.parseInt(point) > Integer.parseInt(temp[0])){
					String sql = "update record_withouttimer set time=? where id=?";
					stmt = conn.prepareStatement(sql);
					stmt.setString(1, userid);
					stmt.setString(2, point);

					stmt.executeUpdate();
				}
				

				%>
				
				<%
	}finally{
		if(pstmt != null) try{pstmt.close();}catch(Exception ex){}
		if(conn != null) try{conn.close();}catch(Exception ex){}
	}
%>