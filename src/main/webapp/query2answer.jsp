<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.sql.*, java.util.* , java.io.*, java.text.*, java.util.Date" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
		<title>COVID-19 PATIENT DB USER QUERY2 ANSWER</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
</head>
<body>
	<div style="font-size:60px">COVID-19 PATIENT DATABASE QUERY2 ANSWERS</div>
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
    
	String pSex1 = request.getParameter("pSex1");
	String city1 = request.getParameter("city1");
	String city2 = request.getParameter("city2");
	String symptom2 = request.getParameter("symptom2");
	String symptom3 = request.getParameter("symptom3");
	String city4 = request.getParameter("city4");
	String district4 = request.getParameter("district4");
	String startY4 = request.getParameter("startY4");
	String startM4 = request.getParameter("startM4");
	String startD4 = request.getParameter("startD4");
	String finishY4 = request.getParameter("finishY4");
	String finishM4 = request.getParameter("finishM4");
	String finishD4 = request.getParameter("finishD4");
	String first5 = request.getParameter("first5");
	String second5 = request.getParameter("second5");
	String city6 = request.getParameter("city6");
	String pSex8 = request.getParameter("pSex8");
	String symptom8 = request.getParameter("symptom8");
	String city8 = request.getParameter("city8");
	String city9 = request.getParameter("city9");
%>
	<!-- 1-1) 환자 성별 선택 & 주민번호, 이름, 전화번호 출력 -->
	<div style="font-size:32px">
	1-1) 선택된 성별에 맞는 환자들의 정보
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT Ssn, L_name, F_name, Phone_num FROM PATIENT WHERE Sex = '" + pSex1 + "'";

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
		out.println("</tr>");
	}
	out.println("</table>");
%>
	</div><br><br>
	
	<!-- 1-2) 도시명 정확히 입력 & 도시, 구 출력 -->
	<div style="font-size:32px">
	1-2) 입력한 도시의 이름과 구 목록
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT City, District FROM REGION WHERE City = '" + city1 + "'";

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
	</div><br><br>
	
	<!-- 2-1) 도시명 정확히 입력 & 병원, 도시, 구 출력 -->
	<div style="font-size:32px">
	2-1) 입력된 도시의 병원이 위치한 도시와 구 목록
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT H.Name, R.City, R.District FROM HOSPITAL H, REGION R"
			+ " WHERE H.Rno = R.R_Id AND City = '" + city2 + "'";

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
		out.println("</tr>");
	}
	out.println("</table>");
%>
	</div><br><br>

	<!-- 2-2) 증상명 입력 & 환자 이름 출력 -->
	<div style="font-size:32px">
	2-2) 입력된 증상을 가지는 환자 목록
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT L_name, F_name, H.Sname AS SYMPTOM FROM PATIENT P, HAS H"
			+ " WHERE H.Pssn = P.Ssn AND H.Sname LIKE '%" + symptom2 + "%'";

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
		out.println("</tr>");
	}
	out.println("</table>");
%>
	</div><br><br>
	
	<!-- 3-1) 증상명 입력 & 성별 환자 수 출력 -->
	<div style="font-size:32px">
	3-1) 각 성별에서 입력된 증상을 가지는 환자 수
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT Sex, COUNT(Ssn) AS PATIENTS FROM PATIENT, HAS "
            + "WHERE Pssn = Ssn AND Sname LIKE '%" + symptom3 + "%' "
            + "GROUP BY Sex";

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
	</div><br><br>

	<!-- 3-2) 입력 파라미터 없음 & 각 지역별 병원 수 출력 -->
	<div style="font-size:32px">
	3-2) 각 지역별 병원 수(내림차순)
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT City, District, COUNT(Rno) AS HOSPITALS FROM REGION R, HOSPITAL H"
            + " WHERE H.Rno = R.R_Id"
            + " GROUP BY City, District"
            + " ORDER BY HOSPITALS DESC";

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
		out.println("</tr>");
	}
	out.println("</table>");
%>
	</div><br><br>
	
	<!-- 4-1)  -->
	<div style="font-size:32px">
	4-1) 입력된 지역의 환자 수
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT COUNT(H.Name) AS PATIENTS FROM HOSPITAL H, PATIENT P"
			+ " WHERE H.H_id = P.Hno AND H.Rno = ( SELECT R_id FROM REGION"
			+ " WHERE City = '" + city4 + "' AND District = '" + district4 + "')";

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
	</div><br><br>
	
	<!-- 4-2) 증상 시작, 종료일자 입력 & 입력된 기간 사이 증상이 시작된 환자의 주민등록번호, 이름 출력 -->
	<div style="font-size:32px">
	4-2) 입력된 기간 사이 증상이 시작된 환자의 정보
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT P.Ssn, P.L_name, P.F_name FROM PATIENT P"
			+ " WHERE P.Ssn IN ( SELECT Pssn FROM HAS"
			+ " WHERE Start_date BETWEEN TO_DATE('" + startY4 + "-" + startM4 + "-" + startD4 + "','YYYY-MM-DD')"
			+ " AND TO_DATE('" + finishY4 + "-" + finishM4 + "-" + finishD4 + "','YYYY-MM-DD'))";

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
		out.println("</tr>");
	}
	out.println("</table>");
%>
	</div><br><br>
	
	<!-- 5-1)  -->
	<div style="font-size:32px">
	5-1) 입력된 두 공간에 모두 다녀온 환자들의 정보
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT L_name, F_name, Phone_num FROM PATIENT "
    		+ "WHERE EXISTS(SELECT Pssn FROM PATH "
    		+ "WHERE PATIENT.Ssn = PATH.Pssn AND Place LIKE '%" + first5 + "%') "
            + "OR EXISTS(SELECT Pssn FROM PATH "
            + "WHERE PATIENT.Ssn = PATH.Pssn AND Place LIKE '%" + second5 + "%')";

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
		out.println("</tr>");
	}
	out.println("</table>");
%>
	</div><br><br>
	
	<!-- 5-2) 지인이 있고 완치가 안 된 환자들의 이름 출력 -->
	<div style="font-size:32px">
	5-2) 지인이 있고 완치가 안 된 환자들의 이름
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT L_name, F_name FROM PATIENT "
            + "WHERE EXISTS (SELECT Pssn FROM BUBBLE "
            + "WHERE Ssn = Pssn) "
            + "AND NOT EXISTS (SELECT Pssn FROM RECOVERY "
            + "WHERE Ssn = Pssn)";

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
	</div><br><br>
	
	<!-- 6-1) 치료된 환자들의 지인들의 이름과 주민등록번호 출력 -->
	<div style="font-size:32px">
	6-1) 치료된 환자들의 지인 정보
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT L_name, F_name, Bssn FROM BUBBLE"
			+ " WHERE Pssn IN (SELECT Pssn FROM RECOVERY WHERE Treatment ='YES')";

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
		out.println("</tr>");
	}
	out.println("</table>");
%>
	</div><br><br>
	
	<!-- 6-2) 입력된 도시의 병원과 전화번호 출력 -->
	<div style="font-size:32px">
	6-2) 입력된 도시의 병원과 전화번호 목록
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT Name, Phone_num FROM HOSPITAL WHERE Rno IN ( SELECT H.Rno FROM REGION R, HOSPITAL H"
			+ " WHERE R.R_id = H.Rno AND R.City = '" + city6 + "')";

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
	</div><br><br>
	
	<!-- 7-1) 각 병원별 주소 및 환자 수 출력 -->
	<div style="font-size:32px">
	7-1) 각 병원별 주소 및 환자 수
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT H.Name, H.Address, A.Patients "
            + "FROM (SELECT Hno, COUNT(Ssn) AS PATIENTS "
            + "FROM PATIENT "
            + "GROUP BY Hno "
            + "ORDER BY Hno ASC"
            + ") A, HOSPITAL H "
            + "WHERE A.Hno = H.H_id";

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
		out.println("</tr>");
	}
	out.println("</table>");
%>
	</div><br><br>
	
	<!-- 7-2) 월별 환자 수 출력 -->
	<div style="font-size:32px">
	7-2) 월별 환자 수 출력
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT SUM(M1) AS JAN, SUM(M2) AS FEB, SUM(M3) AS MAR, SUM(M4) AS APR, SUM(M5) AS MAY, SUM(M6) AS JUN, SUM(M7) AS JUL, SUM(M8) AS AUG, SUM(M9) AS SEP, SUM(M10) AS OCT, SUM(M11) AS NOV, SUM(M12) DEC "
            + "FROM ( "
            + "      SELECT DECODE(TO_CHAR(TO_DATE(START_DATE,'YY/MM/DD'), 'MM'), '01', COUNT(*), 0) \"M1\", "
            + "             DECODE(TO_CHAR(TO_DATE(START_DATE,'YY/MM/DD'), 'MM'), '02', COUNT(*), 0) \"M2\", "
            + "             DECODE(TO_CHAR(TO_DATE(START_DATE,'YY/MM/DD'), 'MM'), '03', COUNT(*), 0) \"M3\", "
            + "             DECODE(TO_CHAR(TO_DATE(START_DATE,'YY/MM/DD'), 'MM'), '04', COUNT(*), 0) \"M4\", "
            + "             DECODE(TO_CHAR(TO_DATE(START_DATE,'YY/MM/DD'), 'MM'), '05', COUNT(*), 0) \"M5\", "
            + "             DECODE(TO_CHAR(TO_DATE(START_DATE,'YY/MM/DD'), 'MM'), '06', COUNT(*), 0) \"M6\", "
            + "             DECODE(TO_CHAR(TO_DATE(START_DATE,'YY/MM/DD'), 'MM'), '07', COUNT(*), 0) \"M7\", "
            + "             DECODE(TO_CHAR(TO_DATE(START_DATE,'YY/MM/DD'), 'MM'), '08', COUNT(*), 0) \"M8\", "
            + "             DECODE(TO_CHAR(TO_DATE(START_DATE,'YY/MM/DD'), 'MM'), '09', COUNT(*), 0) \"M9\", "
            + "             DECODE(TO_CHAR(TO_DATE(START_DATE,'YY/MM/DD'), 'MM'), '10', COUNT(*), 0) \"M10\", "
            + "             DECODE(TO_CHAR(TO_DATE(START_DATE,'YY/MM/DD'), 'MM'), '11', COUNT(*), 0) \"M11\", "
            + "             DECODE(TO_CHAR(TO_DATE(START_DATE,'YY/MM/DD'), 'MM'), '12', COUNT(*), 0) \"M12\" "
            + "      FROM HAS "
            + "      GROUP BY TO_CHAR(TO_DATE(START_DATE,'YY/MM/DD'), 'MM') "
            + ")";

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
		out.println("<td>" + rs.getString(11) + "</td>");
		out.println("<td>" + rs.getString(12) + "</td>");
		out.println("</tr>");
	}
	out.println("</table>");
%>
	</div><br><br>
	
	<!-- 8-1) 입력된 성별과 증상을 포함하는 환자들의 주민등록번호, 이름, 증상, 성별 출력 -->
	<div style="font-size:32px">
	8-1) 선택된 성별과 입력된 증상을 포함하는 환자들의 정보
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT Ssn, L_name, F_name, Sname AS SYMPTOM, Sex"
			+ " FROM ((Has JOIN Symptom ON Name = Sname) JOIN Patient ON Ssn = Pssn)"
			+ " WHERE Sex = '" + pSex8 + "' and Sname LIKE '%" + symptom8 + "%' ORDER BY Ssn DESC";

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
		out.println("</tr>");
	}
	out.println("</table>");
%>
	</div><br><br>
	
	<!-- 8-3) 입력된 도시의 환자들의 지인들의 주민등록번호, 이름, 성별, 전화번호 출력 -->
	<div style="font-size:32px">
	8-2) 입력된 도시의 환자들의 지인 정보
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT B.Bssn, B.L_name, B.F_name, B.Sex, B.Phone_num"
			+ " FROM ((Bubble B JOIN Patient P ON Ssn = Pssn) JOIN Region R ON Rno = R_id)"
			+ " WHERE City = '" + city8 + "' ORDER BY L_name ASC";

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
		out.println("</tr>");
	}
	out.println("</table>");
%>
	</div><br><br>
	
	<!-- 9-1) 입력된 도시의 각 구별 환자 수 출력 -->
	<div style="font-size:32px">
	9-1) 입력된 도시의 각 구별 환자 수
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT R_Id, City, District, COUNT(Ssn) AS PATIENTS "
            + "FROM PATIENT, REGION "
            + "WHERE Rno = R_Id AND City = '" + city9 + "'"
            + "GROUP BY R_Id, City, District "
            + "ORDER BY  PATIENTS DESC, R_Id ASC";

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
		out.println("</tr>");
	}
	out.println("</table>");
%>
	</div><br><br>
	
	<!-- 9-2) 각 지역별 환자 수 출력 (환자 수 기준으로 내림차순) -->
	<div style="font-size:32px">
	9-2) 환자 수 기준으로 내림차순된 각 지역별 환자 수
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT R_Id, City, District, COUNT(Ssn) AS PATIENTS "
            + "FROM PATIENT JOIN REGION ON Rno = R_Id "
            + "GROUP BY R_Id, City, District "
            + "ORDER BY  PATIENTS DESC, R_Id ASC";

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
		out.println("</tr>");
	}
	out.println("</table>");
%>
	</div><br><br>
	
	<!-- 9-3) 각 병원별 환자 수 출력 (환자 수 기준으로 내림차순) -->
	<div style="font-size:32px">
	9-3) 환자 수 기준으로 내림차순된 각 병원별 환자 수
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT H_Id, Name, COUNT(Ssn) AS PATIENTS "
            + "FROM PATIENT, HOSPITAL "
            + "WHERE Hno = H_Id "
            + "GROUP BY H_Id, Name "
            + "ORDER BY  PATIENTS DESC, H_Id ASC";

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
		out.println("</tr>");
	}
	out.println("</table>");
%>
	</div><br><br>
	
	<!-- 9-4) 각 증상별 환자 수 출력 (환자 수 기준으로 내림차순) -->
	<div style="font-size:32px">
	9-4) 환자 수 기준으로 내림차순된 각 증상별 환자 수
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT Name AS SYMPTOM, COUNT(Ssn) AS PATIENTS "
            + "FROM HAS, PATIENT, SYMPTOM "
            + "WHERE Pssn = Ssn AND Name = Sname "
            + "GROUP BY Name "
            + "ORDER BY Name ASC, PATIENTS DESC";

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
	</div><br><br>
	
	<!-- 10-1) 아직 치료되지 않은 환자들의 주민등록번호, 이름, 성별, 전화번호 출력 -->
	<div style="font-size:32px">
	10-1) 아직 치료되지 않은 환자들의 정보
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT Ssn, L_Name, F_Name, Sex, Phone_num FROM Patient"
			+ " WHERE Ssn IN (SELECT Ssn FROM PATIENT MINUS SELECT Pssn FROM RECOVERY)";

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
		out.println("</tr>");
	}
	out.println("</table>");
%>
	</div><br><br>
	
	<!-- 10-2) 병원이 있는 도시와 구 출력 -->
	<div style="font-size:32px">
	10-2) 병원이 있는 지역 목록
	</div>
	<div style="font-size:20px">
<%
	query = "SELECT City, District FROM Region"
			+ " WHERE R_id IN (SELECT Rno FROM Hospital INTERSECT SELECT R_id from Region)";

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
	</div><br><br>
	<div>
	<button style = "font-size: 20px" type="button" onClick="location.href='main.html'">
	to MAIN PAGE</button>
	</div>
</body>
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
</html>