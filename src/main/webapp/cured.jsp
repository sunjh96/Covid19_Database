<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.sql.*, java.util.* , java.io.*, java.text.*, java.util.Date" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
		<title>CURED</title>
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
	
	SimpleDateFormat dtf = new SimpleDateFormat("yyyy/MM/dd");
    Calendar calendar = Calendar.getInstance();
    Date dateObj = calendar.getTime();
    String formattedDate = dtf.format(dateObj);
    String todaydate = formattedDate.substring(2);
	
%>
	<!-- 총 완치자 수 / 신규 완치자 수 바로 출력 -->
	<div style="font-size:32px">총 완치자 수 / 신규 완치자 수</div>
	<div style="font-size:20px">
<%
	query = "SELECT COUNT(pssn) AS ALL_RECOVERIES FROM RECOVERY";
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
		out.println("</tr>");
	}
	out.println("</table>");
	
	query = "SELECT COUNT(pssn) AS NEW_RECOVERIES FROM RECOVERY WHERE finish_date = '" + todaydate + "'";
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