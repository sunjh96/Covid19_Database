<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
		<title>INSERT THE DATA</title>
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
				<li><a href="insertMenu.html" class="active">INSERT</a></li>
				<li><a href="updateMenu.html">UPDATE</a></li>
				<li><a href="deleteMenu.html">DELETE</a></li>
			</ul>
		</nav>
	</header>
	<%
	
		String serverIP = "localhost";
		String strSID = "xe";
		String portNum = "1521";
		String user = "DBteamproject";
		String pass = "comp322";
		String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs;
		int res = 0;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);
		int num = Integer.parseInt(request.getParameter("insert2"));
	%>
	
	<%		
	if (num == 1) {
		String Ssn = request.getParameter("ssn");
		String Lname = request.getParameter("lname");
		String Fname = request.getParameter("fname");
		String Phone = request.getParameter("phone_num");
		if (!Phone.equals("NULL"))
			Phone = String.format("'%s'",Phone);
		String Sex = request.getParameter("sex");
		int Rno = Integer.parseInt(request.getParameter("rno"));
		int Hno = Integer.parseInt(request.getParameter("hno"));
		
		
		try {                  
			conn.setAutoCommit(false);
			rs = null;
			String sql = String.format("INSERT INTO PATIENT VALUES ('%s', %s, '%s', '%s', '%s', %d, %d)", Ssn, Phone, Fname, Lname, Sex, Hno, Rno);
			stmt = conn.createStatement();
			res = stmt.executeUpdate(sql);
			
			if (res == 1) {
				out.print(Lname + Fname+ " " + Ssn + " " + Phone + " " + Rno + " " + Hno);
				out.println("이 추가되었습니다");
			}
			else
				out.println("데이터 추가 실패!");
			
			conn.commit();
			}catch(SQLException ex) {
				out.println("sql error = " + ex.getMessage());
			}
	}
	
	else if (num == 2) {
		String sql = "";
		String Address = request.getParameter("address");
		String Name = request.getParameter("name");
		String Phone = request.getParameter("phone_num");
		if (!Phone.equals("NULL"))
			Phone = String.format("'%s'",Phone);
		int Rno = Integer.parseInt(request.getParameter("rno"));
		
		int H_id = 0;
		try {
			conn.setAutoCommit(false);
			rs = null;                  
			sql = "SELECT COUNT(*) FROM HOSPITAL";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
				H_id = rs.getInt(1) + 1;
			
			rs.close();
			
		}catch(SQLException ex) {
			out.println("sql error = " + ex.getMessage());
		}
		
		try {
			sql = String.format("INSERT INTO HOSPITAL VALUES (%d, %s, '%s', '%s', %d)", H_id, Phone, Name, Address, Rno);
			res = stmt.executeUpdate(sql);
			
			if (res == 1) {
				out.print(H_id + " " + Phone + " " + Name + " " + Address + " " + Rno);
				out.println("이 추가되었습니다");
			}
			else
				out.println("데이터 추가 실패!");
			conn.commit();
			
		}catch(SQLException e) {
			out.println("sql error = " + e.getMessage());
		}
		
	}
	
	else if (num == 3) {
		String sql = "";
		String City = request.getParameter("cname");
		String District = request.getParameter("dname");
		
		int R_id = 0;
		try {
			conn.setAutoCommit(false);
			rs = null;                  
			sql = "SELECT COUNT(*) FROM REGION";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
				R_id = rs.getInt(1) + 1;
			
			rs.close();
			
		}catch(SQLException ex) {
			out.println("sql error = " + ex.getMessage());
		}
		
		try {
			sql = String.format("INSERT INTO REGION VALUES (%d, '%s', '%s')", R_id, City, District);
			res = stmt.executeUpdate(sql);
			
			if (res == 1) {
				out.print(R_id + " " + City + " " + District);
				out.println("이 추가되었습니다");
			}
			else
				out.println("데이터 추가 실패!");
			conn.commit();
			
		}catch(SQLException e) {
			out.println("sql error = " + e.getMessage());
		}
		
	}
	
	else if (num == 4) {
		String sql = "";
		String Sname = request.getParameter("sname");
		
		try {
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			sql = String.format("INSERT INTO SYMPTOM VALUES ('%s')", Sname);
			res = stmt.executeUpdate(sql);
			
			if (res == 1) {
				out.print(Sname);
				out.println("이 추가되었습니다");
			}
			else
				out.println("데이터 추가 실패!");
			conn.commit();
			
		}catch(SQLException e) {
			out.println("sql error = " + e.getMessage());
		}
	}
	
	else if (num == 5) {
		String sql = "";
		//String Pssn = request.getParameter("pssn");
		String Pssn = request.getParameter("ssn");
		String Sname = request.getParameter("sname");
		String Start_date = request.getParameter("start_date");
		
		try {
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			sql = String.format("INSERT INTO HAS VALUES ('%s', '%s', '%s')",Pssn, Sname, Start_date);
			res = stmt.executeUpdate(sql);
			
			if (res == 1) {
				out.print(Pssn + " " + Sname + " " + Start_date);
				out.println("이 추가되었습니다");
			}
			else
				out.println("데이터 추가 실패!");
			conn.commit();
			
		}catch(SQLException e) {
			out.println("sql error = " + e.getMessage());
		}
	}
	
	else if (num == 6) {
		String sql = "";
		String Pssn = request.getParameter("pssn");
		String Bssn = request.getParameter("bssn");
		String Phone = request.getParameter("phone_num");
		if (!Phone.equals("NULL"))
			Phone = String.format("'%s'",Phone);
		String Fname = request.getParameter("fname");
		String Lname = request.getParameter("lname");
		String Sex = request.getParameter("sex");
		
		try {
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			sql = String.format("INSERT INTO BUBBLE VALUES ('%s', '%s', %s, '%s', '%s', '%s')", Pssn, Bssn, Phone, Fname, Lname, Sex);
			res = stmt.executeUpdate(sql);
			
			if (res == 1) {
				out.print(Pssn + " " + Bssn + " " + Lname + Fname + " " + Phone + " " + Sex);
				out.println("이 추가되었습니다");
			}
			else
				out.println("데이터 추가 실패!");
			conn.commit();
			
		}catch(SQLException e) {
			out.println("sql error = " + e.getMessage());
		}
	}
	
	else if (num == 7) {
		String sql = "";
		String Pssn = request.getParameter("ssn");
		String Place = request.getParameter("path");
		int P_id = 0;
		
		try {
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			rs = null;
			sql = "SELECT COUNT(*) FROM PATH";
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			P_id = rs.getInt(1) + 1;
			
			rs.close();
			
		}catch(SQLException ex) {
			out.println("sql error = " + ex.getMessage());
		}
		
		try {
			sql = String.format("INSERT INTO PATH VALUES ('%s', '%d', '%s')", Pssn, P_id, Place);
			res = stmt.executeUpdate(sql);
			
			if (res == 1) {
				out.print(P_id + " " + Pssn + " " + Place);
				out.println("이 추가되었습니다");
			}
			else
				out.println("데이터 추가 실패!");
			conn.commit();
			
		}catch(SQLException e) {
			out.println("sql error = " + e.getMessage());
		}
	}
	
	else if (num == 8) {
		String sql = "";
		String Pssn = request.getParameter("ssn");
		String Treatment = request.getParameter("treatment");
		String Finish_Date = request.getParameter("finish_date");
		int C_id = 0;
		try {
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			rs = null;      
			sql = "SELECT COUNT(*) FROM RECOVERY";
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			C_id = rs.getInt(1) + 1;
			
			rs.close();
			
		}catch(SQLException ex) {
			out.println("sql error = " + ex.getMessage());
		}
		
		try {
			sql = String.format("INSERT INTO RECOVERY VALUES ('%s', '%d', '%s', '%s')", Pssn, C_id, Treatment, Finish_Date);
			res = stmt.executeUpdate(sql);
			
			if (res == 1) {
				out.print(C_id + " " + Pssn + " " + Treatment + " " + Finish_Date);
				out.println("이 추가되었습니다");
			}
			else
				out.println("데이터 추가 실패!");
			conn.commit();
			
		}catch(SQLException e) {
			out.println("sql error = " + e.getMessage());
		}
	}
	%>
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