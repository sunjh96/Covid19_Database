<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*, java.io.*, java.util.*" %>
<!DOCTYPE html>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
		<title>INSERT THE OLD DATA</title>
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
				<li><a href="deleteMenu.html">DELETE</a></li>
			</ul>
		</nav>
	</header>
	<%
	
		String serverIP = "localhost";
		String strSID = "xe";
		String portNum = "1521";
		String user = "DBTeamProject";
		String pass = "comp322";
		String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
		
		Connection conn = null;
		Statement stmt = null;
		String sql ="";
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);
	%>
	<br>
	<%		
	try {   
		stmt = conn.createStatement();   
		conn.setAutoCommit(false);
		sql = "CREATE TABLE Patient" + 
			"(Ssn varchar(15) NOT NULL, " +
			"Phone_num varchar(15), " +
			"F_name varchar(500) NOT NULL, " +
			"L_name varchar(500) NOT NULL, " +
			"Sex char NOT NULL," +
			"Hno int NOT NULL, " +				
			"Rno int NOT NULL, " +
			"PRIMARY KEY (Ssn))";   
		stmt.addBatch(sql);

		sql = "CREATE TABLE Hospital" + 
			"(H_id int NOT NULL, " +
			"Phone_num varchar(15), " +
			"Name varchar(500) NOT NULL, " +
			"Address varchar(1000) NOT NULL, " +
			"Rno int NOT NULL, " +
			"PRIMARY KEY(H_id))";   
		stmt.addBatch(sql);         

		sql = "CREATE TABLE Region" + 
			"(R_id int NOT NULL, " +
			"City varchar(500) NOT NULL, " +
			"District varchar(500) NOT NULL, " +
			"PRIMARY KEY(R_id))";
		stmt.addBatch(sql);

		sql = "CREATE TABLE Symptom" + 
			"(Name varchar(1000) NOT NULL, " +
			"PRIMARY KEY(Name))";
		stmt.addBatch(sql);

		sql = "CREATE TABLE Has" + 
			"(Pssn varchar(15) NOT NULL, " +
			"Sname varchar(1000) NOT NULL, " +
			"Start_date date, " +
			"PRIMARY KEY(Pssn, Sname))";
		stmt.addBatch(sql);

		sql = "CREATE TABLE Bubble" + 
			"(Pssn varchar(15) NOT NULL, " +
			"Bssn varchar(15) NOT NULL, " +
			"Phone_num varchar(15), " +
			"F_name varchar(500) NOT NULL, " +
			"L_name varchar(500) NOT NULL, " +
			" Sex char NOT NULL, " +
			"PRIMARY KEY (Pssn, Bssn))";
		stmt.addBatch(sql);

		sql = "CREATE TABLE Path" + 
			"(Pssn varchar(15) NOT NULL, " +
			"P_id int NOT NULL, " +
			"Place varchar(1000), " +
			"PRIMARY KEY (Pssn, P_id))";
		stmt.addBatch(sql);

		sql = "CREATE TABLE Recovery" + 
			"(Pssn varchar(15) NOT NULL, " +
			"C_id int NOT NULL, " +
			"Treatment varchar(5), " +
			"Finish_date date, " +
			"PRIMARY KEY (Pssn, C_id))";
		stmt.addBatch(sql);
		
		int [] count = null;
		count = stmt.executeBatch();
		out.println(count.length + " Table Created." );
		
		conn.commit();   
		conn.setAutoCommit(true);
		}catch(Exception e) {
			out.println("sql error = " + e.getMessage());
			if(conn != null){
				try{
					conn.rollback();
				}catch(SQLException ex){
					ex.printStackTrace();
				}
			}
		}
	%>
	<br>
	<%
	try {
		conn.setAutoCommit(false);
		
		sql = ("ALTER TABLE Patient ADD FOREIGN KEY (Rno) REFERENCES Region(R_id) ON DELETE CASCADE");
		stmt.addBatch(sql);
		sql = ("ALTER TABLE Patient ADD FOREIGN KEY (Hno) REFERENCES Hospital(H_id) ON DELETE CASCADE");
		stmt.addBatch(sql);
		sql = ("ALTER TABLE Bubble ADD FOREIGN KEY (Pssn) REFERENCES Patient(Ssn) ON DELETE CASCADE");
		stmt.addBatch(sql);
		sql = ("ALTER TABLE Path ADD FOREIGN KEY (Pssn) REFERENCES Patient(Ssn) ON DELETE CASCADE");
		stmt.addBatch(sql);
		sql = ("ALTER TABLE Recovery ADD FOREIGN KEY (Pssn) REFERENCES Patient(Ssn) ON DELETE CASCADE");
		stmt.addBatch(sql);
		sql = ("ALTER TABLE Has ADD FOREIGN KEY (Pssn) REFERENCES Patient(Ssn) ON DELETE CASCADE");
		stmt.addBatch(sql);
		sql = ("ALTER TABLE Hospital ADD FOREIGN KEY (Rno) REFERENCES Region(R_id) ON DELETE CASCADE");
		stmt.addBatch(sql);
		sql = ("ALTER TABLE Has ADD FOREIGN KEY (Sname) REFERENCES Symptom(Name) ON DELETE CASCADE");
		stmt.addBatch(sql);
		
		int [] count = null;
		count = stmt.executeBatch();
		out.println(count.length + " Table Altered." );
		
		conn.commit();
		conn.setAutoCommit(true);
	} catch(Exception e) {
		out.println("sql error = " + e.getMessage());
		if(conn != null){
			try{
				conn.rollback();
			}catch(SQLException ex){
				ex.printStackTrace();
			}
		}
	}
	
	%>
	<br>
	<%
	conn.setAutoCommit(false);
	
    String delimiter = ";";
    Scanner scanner;
    String filePath = application.getRealPath("DB Data.txt");
    File inputFile = new File(filePath); //Insert 데이터 파일 경로

    try {
        scanner = new Scanner(inputFile).useDelimiter(delimiter);
        
    } catch (FileNotFoundException e) {
        e.printStackTrace();
        out.println("sql error = " + e.getMessage());
        return;
    }	  
    
    while(scanner.hasNext()) {
        String line = scanner.next() + delimiter;
        String line1 = line.replace(";", "");
        try {
            stmt.addBatch(line1);
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("sql error = " + e.getMessage());
        } 
    }	  
    try {
    	int [] count = null;
		count = stmt.executeBatch();			
		out.println(count.length+ " Row Inserted." );
		
		conn.commit();
		conn.setAutoCommit(true);
	} catch(Exception e) {
		out.println("sql error = " + e.getMessage());
		if(conn != null){
			try{
				conn.rollback();
			}catch(SQLException ex){
				ex.printStackTrace();
			}
		}
	}

    scanner.close();
	%>
	<br><br><br><br>
	<p>Click the <b> 관리자 모드 </b> text in the top left corner of the page!</p>
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