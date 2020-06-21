
<%@ page language="java" contentType ="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.PreparedStatement"%>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.io.PrintWriter" %>
<%		Class.forName("com.mysql.jdbc.Driver");

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		PreparedStatement ps = null;

		try{
			String jdbcDriver = "jdbc:mysql://webdev.iptime.org:3306/rkdus?"+"useUnicode=true&characterEncoding=utf8";
			String dbUser = "kgy";
			String dbPass = "kgy1234";



			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

			String username = (String)session.getAttribute("username");

			stmt = conn.createStatement();

			String query = "select time from record_timer where GameUsername = '"+ username +"'";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();


		if(username == null){
		%>
				<script>
				alert('로그인 되지 않았습니다. 로그인 페이지로 이동합니다.');
				window.location.href="http://webdev.iptime.org:8080/kgy/gamesignin.html";
				</script>
<%
}
%>


<html lang="en">
 <head>
  <meta charset="UTF-8">
  <title>같은 그림 찾기</title>
  <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <style type="text/css">
		body{background: #007bff; background: linear-gradient(to right, #0062E6, #33AEFF); text-align: center;}
        .width500px{width: 400px;  display: inline-block; text-align: center;}
        .center{text-align: center;}
		#cardTable{border-collapse: collapse; width:100%}
        #cardTable td{border: 1px solid #42423E; width: 25%; height: 121px; text-align: center; cursor: pointer;}
        #cardTable td img{width: 100%;}
        #cardTable td span{font-size: 25pt; font-weight: bold; color: #42423E; display: none;}
	    #username{background-color: #42423E; color: white; font-size: 12pt; width: 30%; border-radius: 1rem; float:left;}

		#maxtime{background-color: #42423E; color: white; font-size: 12pt; width: 40%; border-radius: 1rem; float:left;}

		#countDown{background-color: #42423E; color: white; font-size: 20pt; width: 90%; height: 40px; border-radius: 1rem; float:left;}
    	#exit{background-color:red; color: white; font-size: 20pt; width: 10%; border-radius: 1rem; float:left;}
		#countupbar{background-color: #42423E; color: white; font-size: 22pt; width: 100%; border-radius: 1rem; text-align: center;}
        #info{width: 100%; height: 300px; border-radius: 1rem; background-color: #DDDDDD; color: black; padding-top: 250px;}

#startBtn{
	font-size : 12pt;
  border: 0;
  border-radius: 1rem;
  color: white;
  background-color: #42423E;
  width: 30%;
  cursor: pointer;
  border-collapse: collapse;
  display: inline-block;
}


.card-signin {
  background: #FFFFFF;
  border: 0;
  border-radius: 1.5rem;
  box-shadow: 0 0.5rem 1rem 0 rgba(0, 0, 0, 0.1);
}

.card-signin .card-body {
  padding: 2rem;
}
        </style>


  <SCRIPT LANGUAGE="Javascript1.2">

        var currentsec=0;
        var currentmin=0;
        var currentmil=0;
        var keepgoin=false;

        function timer(){
        if(keepgoin){
          currentmil+=1;
           if (currentmil==10){
            currentmil=0;
            currentsec+=1;
           }
           if (currentsec==60){
            currentsec=0;
            currentmin+=1;
           }
          Strsec=""+currentsec;
          Strmin=""+currentmin;
          Strmil=""+currentmil;
           if (Strsec.length!=2){
            Strsec="0"+currentsec;
           }
           if (Strmin.length!=2){
            Strmin="0"+currentmin;
           }
          document.display.seconds.value=Strsec
          document.display.minutes.value=Strmin;
          document.display.milsecs.value=Strmil;
          setTimeout("timer()", 100);
        }
        }
        function startover(){
        keepgoin=false;
        currentsec=0;
        currentmin=0;
        currentmil=0;
        Strsec="00";
        Strmin="00";
        Strmil="00";
        }




	// 게임 상태
            var gameState = '';

            // 열린 카드 src
            var openCardId = '';
            var openCardId2 = '';

            // 난수 생성 함수
            function generateRandom (min, max) {
                var ranNum = Math.floor(Math.random()*(max-min+1)) + min;
                    return ranNum;
            }


            var cards; // 카드 목록
            //var score = 0; // 점수
            var openedCtn = 0; // 맞춘 카드 갯수

            // 카드 배치
            function setTable(){
                cards = [
                'https://image.flaticon.com/icons/svg/1728/1728729.svg','https://image.flaticon.com/icons/svg/1728/1728729.svg', // 오렌지
                'https://image.flaticon.com/icons/svg/1868/1868212.svg','https://image.flaticon.com/icons/svg/1868/1868212.svg', // 파인애플
                'https://image.flaticon.com/icons/svg/765/765560.svg','https://image.flaticon.com/icons/svg/765/765560.svg', // 포도
                'https://image.flaticon.com/icons/svg/590/590772.svg','https://image.flaticon.com/icons/svg/590/590772.svg', // 딸기
                'https://image.flaticon.com/icons/svg/415/415733.svg','https://image.flaticon.com/icons/svg/415/415733.svg', // 사과
                'https://image.flaticon.com/icons/svg/1135/1135549.svg','https://image.flaticon.com/icons/svg/1135/1135549.svg', // 바나나
                'https://image.flaticon.com/icons/svg/874/874997.svg','https://image.flaticon.com/icons/svg/874/874997.svg', // 수박
                'https://image.flaticon.com/icons/svg/2754/2754032.svg','https://image.flaticon.com/icons/svg/2754/2754032.svg', // 체리

                'https://image.flaticon.com/icons/svg/700/700804.svg','https://image.flaticon.com/icons/svg/700/700804.svg', // 망고
                'https://image.flaticon.com/icons/svg/2548/2548560.svg','https://image.flaticon.com/icons/svg/2548/2548560.svg', // 메론
                'https://image.flaticon.com/icons/svg/590/590775.svg','https://image.flaticon.com/icons/svg/590/590775.svg' // 복숭아
                ];
                var cardTableCode = '<tr>';
                for(var i=0;i<20;i++) {
                    if(i>0 && i%4 == 0){
                        cardTableCode += '</tr><tr>';
                    }
                    var idx = generateRandom(0,19-i);
                    var img = cards.splice(idx,1);

                    cardTableCode += '<td id="card'+i+'"><img src="'+img+'"><span>?</span></td>';
                }
                cardTableCode += '</tr>';
                $('#cardTable').html(cardTableCode);
            }

            // 카드 전체 가리기
            function hiddenCards(){
                $('#cardTable td img').hide();
                $('#cardTable td span').show();
            }

            // 게임 시작
            function startGame() {
                var sec = 2;

                $('#info').hide(); // 안내 문구 가리기
                setTable(); // 카드 배치

                //준비 카운트 다운
                function setText(){
                    $('#countDown').text(--sec);
                }

                  //시작 카운트 다운
                var intervalID = setInterval(setText, 1000);
                setTimeout(function(){
                    clearInterval(intervalID);
                     keepgoin=true;
                     timer();
                    $('#countDown').text("시작!");
                    hiddenCards();
                    gameState = 'ingame';
                }, 2000);
            }


            // 카드 선택 시
            $(document).on('click', '#cardTable td', function(){
                if(gameState != 'ingame') return; // 게임 카운트 다운중일 때 누른 경우 return

                if(openCardId2 != '') return; // 2개 열려있는데 또 누른 경우 return
                if($(this).hasClass('opened')) return; // 열려있는 카드를 또 누른 경우
                $(this).addClass('opened'); // 열여있다는 것을 구분하기 위한 class 추가

                if(openCardId == '') {
                    $(this).find('img').show();
                    $(this).find('span').hide();
                    openCardId = this.id;
                }else {
                    if(openCardId == openCardId2) return; //같은 카드 누른 경우 return

                    $(this).find('img').show();
                    $(this).find('span').hide();

                    var openCardSrc = $('#'+openCardId).find('img').attr('src');
                    var openCardSrc2 = $(this).find('img').attr('src');
                    openCardId2 = this.id;

                    if(openCardSrc == openCardSrc2) { // 일치
                        openCardId = '';
                        openCardId2 = '';
                        if(++openedCtn == 1){
                            keepgoin=false
							gameState='';
                            //alert('시간 '+Strmin+':'+Strsec+':'+Strmil);
							var gametime= Strmin*10000+Strsec*100+Strmil*1;
							//alert(gametime);
							window.location.href="http://webdev.iptime.org:8080/kgy/insert_timermode.jsp?time="+gametime;

                        }
                    }else { // 불일치
                        setTimeout(back, 1000);
                    }
                }
            });

            // 두개의 카드 다시 뒤집기
            function back() {
                $('#'+openCardId).find('img').hide();
                $('#'+openCardId).find('span').show();
                $('#'+openCardId2).find('img').hide();
                $('#'+openCardId2).find('span').show();
                $('#'+openCardId).removeClass('opened');
                $('#'+openCardId2).removeClass('opened');
                openCardId = '';
                openCardId2 = '';
            }




            $(document).on('click', '#startBtn', function(){
                if(gameState == '') {
                    startGame();
                    gameState = 'alreadyStart'
                }
				if(gameState != 'ingame'){
                   document.getElementById("startBtn").disabled = true;}
            });


  </script>
 </head>
  <body>
  <div class="container">
    <div class="row">
      <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
        <div class="card card-signin my-5">
          <div class="card-body">

            <div>
				<div style="text-align: center; align: center;" id='countupbar' name='countupbar'>
					<FORM NAME="display" ONRESET="startover()">
						 <TABLE>
						  <TR>
							<TD COLSPAN=3>
							<DIV align="center">

							 <INPUT TYPE="text" style="border: none; background: transparent;font-size:12pt; color:#FFFFFF;font-weight:bold; width: 25%;" NAME="minutes"VALUE="00">
									 <input type="text" style="border: none; background: transparent;font-size:12pt; color:#FFFFFF;font-weight:bold;width: 8%;" value=":">
							 <INPUT TYPE="text"style="border: none; background: transparent;font-size:12pt; color:#FFFFFF;font-weight:bold;width: 25%;" NAME="seconds" VALUE="00">
										<input type="text" style="border: none; background: transparent;font-size:12pt; color:#FFFFFF;font-weight:bold;width: 8%;"  value=":">
							 <INPUT TYPE="text"style="border: none; background: transparent;font-size:12pt; color:#FFFFFF;font-weight:bold;width: 25%;" NAME="milsecs" VALUE="00">
							 </TD>
							</TR>
							</TABLE>
						</FORM>
				</div>
                <div id='countDown'>준비
                </div>
				<div id='exit' onclick="location.href='http://webdev.iptime.org:8080/kgy/modeselect.html'">X</div><br><br>

                <table id='cardTable'>
                </table>
                <div id='info'>
                    start 버튼을 눌러주세요<br>
                </div>
		<div>
                <div id='username' name='username' ><%=username%>

                </div>

				<%
				if(rs.next()){
					String time = rs.getString("time");
					int length = time.length();

					if(length == 4) {
					%>
						<div id='maxtime' name='maxtime'>00 : <%=time.substring(0,2)%> : <%=time.substring(2,4)%> </div>

					<%
					}else if(length == 5){
						%>
						<div id='maxtime' name='maxtime'>0<%=time.substring(0,1)%> : <%=time.substring(1,3)%> : <%=time.substring(3,5)%></div>

						<%
					}
					else if(length == 6) {
						%>
						<div id='maxtime' name='maxtime'><%=time.substring(0,2)%> : <%=time.substring(2,4)%> : <%=time.substring(4,6)%></div>
						<%
					}else if(length == 3){
						%>
						<div id='maxtime' name='maxtime'>00 : 0<%=time.substring(0,1)%> : <%=time.substring(1,3)%></div>
						<%
						}
				}



				%></div>
							<div><button id='startBtn'>start</button></div>

            </div>


            </div>
        </div>
        </div>
      </div>
    </div>
  </div>
 </body>
</html>
<%
		}finally{
			if(rs != null) try{rs.close();}catch(SQLException ex){}
			if(stmt != null) try{stmt.close();} catch(SQLException ex){}
			if(conn != null) try{conn.close();} catch(SQLException ex){}
		}

%>
