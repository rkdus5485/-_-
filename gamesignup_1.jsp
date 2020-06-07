<%@ page language="java" contentType="text/html; charset=utf-8"%>


<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import = "java.sql.Connection"%>
<%@ page import = "java.sql.PreparedStatement"%>
<%@ page import = "java.sql.SQLException"%>
<%@ page import = "java.io.PrintWriter" %>

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
<html>
<head>
	<meta charset="utf-8" />
	 <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <style type="text/css">
        :root {
  --input-padding-x: 1.5rem;
  --input-padding-y: .75rem;
}



body {
  background: #007bff;
  background: linear-gradient(to right, #0062E6, #33AEFF);
}

.card-signin {
  border: 0;
  border-radius: 1rem;
  background: #fff;
  text-align : center;
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

.form-signin .btn {
  font-size: 80%;
  border-radius: 5rem;
  letter-spacing: .1rem;
  font-weight: bold;
  padding: 1rem;
  transition: all 0.2s;
}
         </style>

	 <script>
	 function signup(){
		var sUser=document.signupform;
		
	if(!sUser.userpw.value){
			//alert("비밀번호를 입력하세요");
			
		}
		else{
			//alert("가입");
			window.location.href="http://webdev.iptime.org:8080/kgy/gamesignup.jsp";
		}
	}

	function checkUsername(){

		var sUser= document.signupform; // sid = 폼 자체를 변수로 선언
		if(!sUser.username.value){ // 만약 입력한 값이 없으면
			alert("닉네임을 입력해주세요");
			sUser.username.focus(); // 아이디에 포커스
		}else{
		var joinusername = sUser.username.value;
		var url = "./gamecheckUsername.jsp?username="+joinusername;
		//window.open(url,"","width=400, height=150, resizable=no, scrollbars=no");
		window.location.href="http://webdev.iptime.org:8080/kgy/gamecheckUsername.jsp?username="+joinusername;

	}};


  </script>
	<title>회원가입</title>
</head>
<body>
	<form method="post" action="gamesignup.jsp" id="signupform" name="signupform">
		<div class="card card-signin my-5">
          		<h2>회원가입</h2>
           <form class="form-signin">
				<table>
				<tr>
					<div class="form-label-group">
					<label for="inputEmail">Username</label>
					<input type="text" name="username" id="username" class="username" value="<%=username%>" placeholder="닉네임" readOnly />
					<input type="button" value="중복확인" id="check" onClick="javascript:checkUsername()">
					</div>
					<div class="form-label-group">
					<label for="inputPassword">Password</label>
					<input type="password" id="userpw" name="userpw" class="userpw" placeholder="비밀번호" required>
					</div>
					<br>
				</tr>
				</table>
			<input type="submit" value="가입하기" onClick="javascript:signup()" />
			<input type="reset" value="다시쓰기" />
        <br>
        <br>
     </form>
  </div>
  </form>
</body>
</html>
