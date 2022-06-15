<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.sql.*, java.util.* , java.io.*, java.text.*, java.util.Date" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
		<title>COVID-19 PATIENT DB USER MENU</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
</head>
<body>
	<div style="font-size:40px">COVID-19 PATIENT DATABASE</div>
<%
	String serverIP = "localhost";
	String strSID = "xe";
	String portNum = "1521";
	String user = "DBteamproject";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
	
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	
	String query = "";
	ResultSetMetaData rsmd;
	int cnt = 0;
	
	request.setCharacterEncoding("UTF-8");
    
	String pName = request.getParameter("pName");
	String ln = "", fn = "";
	//성, 이름 한 번에 입력 ex)김민수
	if(pName.length() == 2) {
		ln = pName.substring(0, 1);
		fn = pName.substring(1);
		//pInfo(ln, fn);
	}
	else if(pName.length() == 3) {
		ln = pName.substring(0, 1);
		fn = pName.substring(1);
		//pInfo(ln, fn);
	}
	else if(pName.length() == 4) {
		ln = pName.substring(0, 2);
		fn = pName.substring(2);
		//pInfo(ln, fn);
	}
	
    String city = request.getParameter("city");
%>
	<!-- 검색한 환자 정보 출력 -->
	<div style="font-size:32px">
	검색한 환자의 정보
	</div>
	<div style="font-size:20px">
<%		
	query = "SELECT P.ssn, P.l_name, P.f_name, P.sex, P.phone_num,"
			+ " R.city, R.district, H.name, H.address, H.phone_num" 
			+ " FROM PATIENT P LEFT JOIN REGION R ON P.rno = R.r_id"
			+ " LEFT JOIN HOSPITAL H ON P.hno = H.h_id AND R.r_id = H.rno"
			+ " LEFT JOIN HAS A ON P.ssn = A.pssn LEFT JOIN PATH T ON P.ssn = T.pssn"
			+ " LEFT JOIN RECOVERY C ON P.ssn = C.pssn LEFT JOIN BUBBLE B ON P.ssn = B.pssn"
			+ " WHERE P.l_name = '" + ln + "' AND P.f_name = '" + fn + "' ORDER BY P.ssn";
	
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
	
			out.println("<table border=\"1\">");
			rsmd = rs.getMetaData();
			cnt = rsmd.getColumnCount();
			
			for(int i = 1; i <= cnt; i++)
				out.println("<th>" + rsmd.getColumnName(i) + "</th>");
			while(rs.next())
			{
				out.println("<tr>");
				out.println("<td>" + rs.getString(1) + "</td>");
				out.println("<td>" + rs.getString(2) + "</td>");
				out.println("<td>" + rs.getString(3) + "</td>");
				out.println("<td>" + rs.getString(4) + "</td>");
				out.println("<td>" + rs.getString(5) + "</td>");
				out.println("<td>" + rs.getString(6) + "</td>");
				out.println("<td>" + rs.getString(7) + "</td>");
				out.println("<td>" + rs.getString(8) + "</td>");
				out.println("<td>" + rs.getString(9) + "</td>");
				out.println("<td>" + rs.getString(10) + "</td>");
				out.println("</tr>");
			}
			out.println("</table>");

	query = "SELECT A.sname AS Symptom, A.start_date, T.place, C.treatment, C.finish_date,"
			+ " B.bssn, B.l_name, B.f_name, B.sex, B.phone_num"
			+ " FROM PATIENT P LEFT JOIN REGION R ON P.rno = R.r_id"
			+ " LEFT JOIN HOSPITAL H ON P.hno = H.h_id AND R.r_id = H.rno"
			+ " LEFT JOIN HAS A ON P.ssn = A.pssn LEFT JOIN PATH T ON P.ssn = T.pssn"
			+ " LEFT JOIN RECOVERY C ON P.ssn = C.pssn LEFT JOIN BUBBLE B ON P.ssn = B.pssn"
			+ " WHERE P.l_name = '" + ln + "' AND P.f_name = '" + fn + "' ORDER BY P.ssn";
	
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
	
			out.println("<table border=\"1\">");
			rsmd = rs.getMetaData();
			cnt = rsmd.getColumnCount();
			
			for(int i = 1; i <= cnt; i++)
				out.println("<th>" + rsmd.getColumnName(i) + "</th>");
			while(rs.next())
			{
				out.println("<tr>");
				out.println("<td>" + rs.getString(1) + "</td>");
				out.println("<td>" + rs.getString(2) + "</td>");
				out.println("<td>" + rs.getString(3) + "</td>");
				out.println("<td>" + rs.getString(4) + "</td>");
				out.println("<td>" + rs.getString(5) + "</td>");
				out.println("<td>" + rs.getString(6) + "</td>");
				out.println("<td>" + rs.getString(7) + "</td>");
				out.println("<td>" + rs.getString(8) + "</td>");
				out.println("<td>" + rs.getString(9) + "</td>");
				out.println("<td>" + rs.getString(10) + "</td>");
				out.println("</tr>");
			}
			out.println("</table>");			
%>	
	</div>
	
	<!-- 검색한 지역의 확진자 수 출력 -->
	<div style="font-size:32px">
	검색한 지역의 확진자 수
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT city, COUNT(ssn) "
			+ "FROM REGION LEFT OUTER JOIN PATIENT "
			+ "ON r_id = rno "
			+ "WHERE city LIKE '%"
			+ city
			+ "%' GROUP BY city";

			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();

			out.println("<table border=\"1\">");
			rsmd = rs.getMetaData();
			cnt = rsmd.getColumnCount();
			
			for(int i = 1; i <= cnt; i++)
				out.println("<th>" + rsmd.getColumnName(i) + "</th>");
			while(rs.next())
			{
				out.println("<tr>");
				out.println("<td>" + rs.getString(1) + "</td>");
				out.println("<td>" + rs.getString(2) + "</td>");
				out.println("</tr>");
			}
			out.println("</table>");
%>
	</div>
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