<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
      <title>UPDATE DATA</title>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
      <link rel="stylesheet" href="assets/css/main.css" />
      <noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
</head>
<body>
      <header id="header">
         <a href="adminmenu.html" class="title">관리자 모드</a>
         <nav>
            <ul>
               <li><a href="main.html">HOME</a></li>
               <li><a href="insertMenu.html">INSERT</a></li>
               <li><a href="updateMenu.html" class="active">UPDATE</a></li>
               <li><a href="deleteMenu.html">DELETE</a></li>
            </ul>
         </nav>
      </header>
   <form action="update2.jsp" method="POST">
      <%
         int num = Integer.parseInt(request.getParameter("update"));
         if (num == 1) {
            out.println("<input type=\"hidden\" name=\"update2\" value=\"1\">");
            out.println("수정할 환자의 Ssn을 입력해주세요");
            out.println("<input type=\"text\" name=\"ssn\" /><br />");
            
            out.println("환자의 새로운 Last Name을 입력해주세요 (그대로면 빈칸)");
            out.println("<input type=\"text\" name=\"lname\" /><br />");
            
            out.println("환자의 새로운 First Name을 입력해주세요 (그대로면 빈칸)");
            out.println("<input type=\"text\" name=\"fname\" /><br />");
            
            out.println("환자의 새로운 Phone number을 입력해주세요(없으면 NULL을 그대로면 빈칸으로)");
            out.println("<input type=\"text\" name=\"phone_num\" /><br />");
            
            out.println("환자의 새로운 Sex을 입력해주세요 (그대로면 빈칸)");
            out.println("<input type=\"text\" name=\"sex\" /><br />");
            
            out.println("환자의 새로운 지역번호를 입력해주세요 (그대로면 빈칸)");
            out.println("<input type=\"text\" name=\"rno\" /><br />");
            
            out.println("환자의 새로운 병원번호를 입력해주세요 (그대로면 빈칸)");
            out.println("<input type=\"text\" name=\"hno\" /><br />");
         }
         
         else if (num == 2) {
            out.println("<input type=\"hidden\" name=\"update2\" value=\"2\">");
            
            out.println("수정할 병원의 Id을 입력해주세요");
            out.println("<input type=\"text\" name=\"hno\" /><br />");
            
            out.println("병원의 새로운 이름을 입력해주세요 (그대로면 빈칸)");
            out.println("<input type=\"text\" name=\"name\" /><br />");
            
            out.println("병원의 새로운 주소를 입력해주세요 (그대로면 빈칸)");
            out.println("<input type=\"text\" name=\"address\" /><br />");
            
            out.println("병원의 새로운 Phone Number를 입력해주세요 (그대로면 빈칸)");
            out.println("<input type=\"text\" name=\"phone_num\" /><br />");
            
            out.println("병원의 새로운 지역번호를 입력해주세요 (그대로면 빈칸)");
            out.println("<input type=\"text\" name=\"rno\" /><br />");
         }
         
         else if (num == 3) {
            out.println("<input type=\"hidden\" name=\"update2\" value=\"3\">");
            
            out.println("수정할 지역의 Id를 입력해주세요");
            out.println("<input type=\"text\" name=\"rno\" /><br />");
            
            out.println("지역의 새로운 City Name을 입력해주세요 (그대로면 빈칸)");
            out.println("<input type=\"text\" name=\"cname\" /><br />");
            
            out.println("지역의 새로운 DistrictName을 입력해주세요 (그대로면 빈칸)");
            out.println("<input type=\"text\" name=\"dname\" /><br />");
            
         }
         else if (num == 4) {
            out.println("<input type=\"hidden\" name=\"update2\" value=\"4\">");
            
            out.println("수정할 증상여부정보의 환자의 Ssn을 입력해주세요");
            out.println("<input type=\"text\" name=\"ssn\" /><br />");
            
            out.println("환자의 새로운 증상 Name을 입력해주세요 (그대로면 빈칸)");
            out.println("<input type=\"text\" name=\"sname\" /><br />");
            
            out.println("환자의 새로운 증상 Start date을 입력해주세요 (그대로면 빈칸)");
            out.println("<input type=\"text\" name=\"start_date\" /><br />");   
         }
         
         else if (num == 5) {
            out.println("<input type=\"hidden\" name=\"update2\" value=\"5\">");
            
            out.println("수정할 관련인이 마주한 환자의 Ssn을 입력해주세요");
            out.println("<input type=\"text\" name=\"pssn\" /><br />");
            
            out.println("수정할 관련인의 Ssn을 입력해주세요");
            out.println("<input type=\"text\" name=\"bssn\" /><br />");
            
            out.println("관련인의 새로운 Last Name을 입력해주세요 (그대로면 빈칸)");
            out.println("<input type=\"text\" name=\"lname\" /><br />");
            
            out.println("관련인의 새로운 First Name을 입력해주세요 (그대로면 빈칸)");
            out.println("<input type=\"text\" name=\"fname\" /><br />");
            
            out.println("관련인의 새로운 Phone Number을 입력해주세요 (그대로면 빈칸)");
            out.println("<input type=\"text\" name=\"phone_num\" /><br />");
            
            out.println("관련인의 새로운 Sex을 입력해주세요 (그대로면 빈칸)");
            out.println("<input type=\"text\" name=\"sex\" /><br />");
            
         }
         
         else if (num == 6) {
            out.println("<input type=\"hidden\" name=\"update2\" value=\"6\">");
            
            out.println("수정될 경로정보의 환자의 Ssn을 입력해주세요");
            out.println("<input type=\"text\" name=\"pssn\" /><br />");
            
            out.println("경로정보의 새로운 Path을 입력해주세요 (그대로면 빈칸)");
            out.println("<input type=\"text\" name=\"path\" /><br />");
         }
         
         else if (num == 7) {
            out.println("<input type=\"hidden\" name=\"update2\" value=\"7\">");
            
            out.println("수정할 완치자의 Ssn을 입력해주세요");
            out.println("<input type=\"text\" name=\"ssn\" /><br />");
            
            out.println("완치자의 새로운 Treatment을 입력해주세요 (그대로면 빈칸)");
            out.println("<input type=\"text\" name=\"treatment\" /><br />");
            
            out.println("완치자의 새로운 Finish Date을 입력해주세요(YY/MM/DD, 그대로면 빈칸)");
            out.println("<input type=\"text\" name=\"finish_date\" /><br />");
         }
         
         out.println("<input type=\"submit\" value=\"수정\">");
      %>
   </form>
      <!-- Footer -->
         <footer id="footer" class="wrapper style1-alt">
            <div class="inner">
               <ul class="menu">
                  <p>Made with  <span role='img' aria-label='coffee'> ☕ </span>  by Team 11</p>
               </ul>
            </div>
         </footer>

      <!-- Scripts -->
         <script src="assets/js/jquery.min.js"></script>
         <script src="assets/js/jquery.scrollex.min.js"></script>
         <script src="assets/js/jquery.scrolly.min.js"></script>
         <script src="assets/js/browser.min.js"></script>
         <script src="assets/js/breakpoints.min.js"></script>
         <script src="assets/js/util.js"></script>
         <script src="assets/js/main.js"></script>
</body>
</html>