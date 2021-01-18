# OpenSource
2020 - 1학기 "오픈소스SW개발"

앱 게임 만들기 "같은 그림 찾기"
- 웹 환경을 이용해 개발하여 'webview'로 앱 구성
- font end : 김정인, 이승빈
- back end : 김가연, 심유라
- DB : 김형규

참고한 오픈소스
- https://dororongju.tistory.com/103

앱 구성 화면


- 첫화면
  - 로그인
  - 회원가입
  - 종료하기
  
<img src="https://user-images.githubusercontent.com/45381907/104876623-69841980-599b-11eb-99ca-76d2d0a2f95d.PNG" width = "200">

- 로그인 및 회원가입

<img src = "https://user-images.githubusercontent.com/45381907/104876608-6557fc00-599b-11eb-8da9-e60f395d88ba.jpg" width="300">

<img src ="https://user-images.githubusercontent.com/45381907/104876612-66892900-599b-11eb-8c6a-0789cabaaf67.jpg" width="300">

- 게임 모드 선택 화면
  - 'Game Description'
    - 게임 설명이 담긴 페이지
  - 'score mode'
    - '틀린 그림 찾기' score 모드
  - 'timer mode'
    - '틀린 그림 찾기' timer 모드
  - 'ranking'
    - '틀린 그림 찾기' 사용자 들의 랭킹 화면
<img src ="https://user-images.githubusercontent.com/45381907/85711950-c4fe6980-b722-11ea-8da8-199fb746528c.jpg" width="300">
  

- 게임화면
  - '스코어'
    - 모든 카드를 다 맞출때까지 두 카드가 일치하면 +10, 두 카드가 일치하지 않으면 -5점을 부여하여 점수계산
    - 게임화면 밑에는 나의 최고 점수가 나옴
  - '타이머'
    - 스톱워치를 적용하여 모든 카드를 맞추면 타이머가 시간을 기록
    - 게임화면 밑에는 나의 최단 시간이 나옴
  
<img src ="https://user-images.githubusercontent.com/45381907/104878767-e5806080-599f-11eb-9571-9e67a98e9570.jpg" width="300">
<img src = "https://user-images.githubusercontent.com/45381907/104876620-68eb8300-599b-11eb-8cd7-1da7d2a78330.jpg" width="300">

  
- 랭킹화면 (게임이 끝나고 나서 보여지는 페이지)
  - '스코어' 랭킹
    - 제일 위에 나의 점수를 보여주고 밑에 1~3등 까지의 등수를 보여줌
  - '타이머' 랭킹
    - 제일 위에 나의 시간을 보여주고 밑에 1~3등 까지의 등수를 보여줌
    
      - 여기서 나의 점수 및 시간은 방금 한 게임의 점수 및 시간을 보여줌
      
<img src ="https://user-images.githubusercontent.com/45381907/104878699-c1248400-599f-11eb-9b11-233381031872.jpg" width="300">
<img src = "https://user-images.githubusercontent.com/45381907/104876614-6721bf80-599b-11eb-9a6e-efa324716c22.jpg" width="300">


- 랭킹 (게임 선택 화면에서 누르면 나오는 페이지)
  - '스코어' 랭킹
    - 화면 위쪽으로 가장 높은 점수를 획득한 1~3 등이 표시
  - '타이머' 랭킹
    - 화면 아래쪽으로 가장 짧은 시간을 기록한 1~3 등이 표시
    
<img src ="https://user-images.githubusercontent.com/45381907/104876618-6852ec80-599b-11eb-9414-f74ca4c35768.jpg" width="300">  
