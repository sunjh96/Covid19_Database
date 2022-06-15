<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
		<title>DELETE THE DATA</title>
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
					<li><a href="updateMenu.html">UPDATE</a></li>
					<li><a href="deleteMenu.html" class="active">DELETE</a></li>
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
		String temp = "";
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);
		int num = Integer.parseInt(request.getParameter("delete2"));
	%>
	
	<%		
	if (num == 1) {
		String sql = "";
		String Ssn = request.getParameter("ssn");
		
		try {
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			out.print(Ssn);
			
			sql = String.format("DELETE FROM PATIENT WHERE Ssn = '%s'", Ssn);
			res = stmt.executeUpdate(sql);
			
			if (res == 1) {
				out.println("이 삭제되었습니다");
			}
			else
				out.println("삭제 실패!");
			
			conn.commit();
			conn.setAutoCommit(true);
				
			}catch(SQLException e) {
				out.println("sql error = " + e.getMessage());
			}
	}
	
	else if (num == 2) {
		String sql = "";
	
		int H_id = Integer.parseInt(request.getParameter("hno"));
		
		try {
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			out.print(H_id);
			sql = String.format("DELETE FROM HOSPITAL WHERE H_id = %d", H_id);
			res = stmt.executeUpdate(sql);
			
			if (res == 1) {
				out.println("이 삭제되었습니다");
			}
			else
				out.println("삭제 실패!");
			conn.commit();
			
		}catch(SQLException e) {
			out.println("sql2 error = " + e.getMessage());
		}
		
	}
	
	else if (num == 3) {
		String sql = "";
		
		int	R_id = Integer.parseInt(request.getParameter("rno"));
		
		try {
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			out.println(R_id);
			sql = String.format("DELETE FROM REGION WHERE R_id = %d", R_id);
			res = stmt.executeUpdate(sql);
			
			if (res == 1) {
				out.println("이 삭제되었습니다");
			}
			else
				out.println("삭제 실패!");
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
			out.println(Sname);
			sql = String.format("DELETE FROM SYMPTOM WHERE Name = '%s'", Sname);
			res = stmt.executeUpdate(sql);
			
			if (res == 1) {
				out.println("이 삭제되었습니다");
			}
			else
				out.println("삭제 실패!");
			conn.commit();
			
		}catch(SQLException e) {
			out.println("sql error = " + e.getMessage());
		}
	}
	
	else if (num == 5) {
		String sql = "";
		String Pssn = request.getParameter("ssn");
		String Sname = request.getParameter("sname");
		
		try {
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			out.println(Pssn + " " + Sname);
			sql = String.format("DELETE FROM HAS WHERE Pssn = '%s' AND Sname = '%s'", Pssn, Sname);
			res = stmt.executeUpdate(sql);
			
			if (res == 1) {
				out.println("이 삭제되었습니다");
			}
			else
				out.println("삭제 실패!");
			conn.commit();
			
		}catch(SQLException e) {
			out.println("sql error = " + e.getMessage());
		}
	}
	
	else if (num == 6) {
		String sql = "";
		String Pssn = request.getParameter("pssn");
		String Bssn = request.getParameter("bssn");
		
		try {
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			out.println(Pssn + " " + Bssn);
			sql = String.format("DELETE FROM BUBBLE WHERE Pssn = '%s' AND Bssn = '%s'", Pssn, Bssn);
			res = stmt.executeUpdate(sql);
			
			if (res == 1) {
				out.println("이 삭제되었습니다");
			}
			else
				out.println("삭제 실패!");
			conn.commit();
			
		}catch(SQLException e) {
			out.println("sql error = " + e.getMessage());
		}
	}
	
	else if (num == 7) {
		String sql = "";
		String Pssn = request.getParameter("pssn");
		
		try {
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			out.println(Pssn);
			sql = String.format("DELETE FROM PATH WHERE Pssn = '%s'", Pssn);
			res = stmt.executeUpdate(sql);
			
			if (res == 1) {
				out.println("이 삭제되었습니다");
			}
			else
				out.println("삭제 실패!");
			conn.commit();
			
		}catch(SQLException e) {
			out.println("sql error = " + e.getMessage());
		}
	}
	
	else if (num == 8) {
		String sql = "";
		String Pssn = request.getParameter("ssn");
		
		try {
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			out.println(Pssn);
			sql = String.format("DELETE FROM RECOVERY WHERE Pssn = '%s'", Pssn);
			res = stmt.executeUpdate(sql);
			
			if (res == 1) {
				out.println("이 삭제되었습니다");
			}
			else
				out.println("삭제 실패!");
			conn.commit();
			
		}catch(SQLException e) {
			out.println("sql error = " + e.getMessage());
		}
	}
	%>
	
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