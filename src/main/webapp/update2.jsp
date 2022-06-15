<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*, java.util.Date"%>
<!DOCTYPE html>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
      <title>UPDATE THE DATA</title>
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
      int num = Integer.parseInt(request.getParameter("update2"));
   %>
   
   <%      
   if (num == 1) {
      String sql = "", Lname = "", Fname = "", Phone = "", Sex = "";
      String Ssn = request.getParameter("ssn");
      int Rno = 0, Hno = 0;
      
      try {
         conn.setAutoCommit(false);
         rs = null;                  
         sql = String.format("SELECT * FROM PATIENT WHERE Ssn = '%s'", Ssn);
         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
         
         while(rs.next()) {
            Phone = rs.getString(2);
            if (Phone == null)
               Phone = String.format("null");
            else
               Phone = String.format("'" + Phone + "'");
            Fname = rs.getString(3);
            Lname = rs.getString(4);
            Sex = rs.getString(5);
            Hno = rs.getInt(6);
            Rno = rs.getInt(7);
         }
         rs.close();
      }catch(SQLException ex) {
         out.println("sql error = " + ex.getMessage());
      }
      
      temp = request.getParameter("lname");
      if (!temp.equals(""))
         Lname = temp;
      
      temp = request.getParameter("fname");
      if (!temp.equals(""))
         Fname = temp;
      
      temp = request.getParameter("phone_num");
      if (!temp.equals("")) {
         if (temp.equals("NULL"))
            Phone = null;
         else
            Phone = String.format("'" + temp + "'");
      }
      
      temp = request.getParameter("sex");
      if (!temp.equals(""))
         Sex = temp;
      
      temp = request.getParameter("rno");
      if (!temp.equals(""))
         Rno = Integer.parseInt(temp);
      
      temp = request.getParameter("hno");
      if (!temp.equals(""))
         Hno = Integer.parseInt(temp);
      
      
      try {
         out.println(Lname + Fname+ " " + Ssn + " " + Sex + " " + Phone + " " + Rno + " " + Hno);
         
         sql = String.format("UPDATE PATIENT SET Phone_num = %s, F_name = '%s', L_name = '%s', Sex = '%s', Hno = %d, Rno = %d WHERE Ssn = '%s'", Phone, Fname, Lname, Sex, Hno, Rno, Ssn);
         res = stmt.executeUpdate(sql);
         
         if (res == 1) {
            out.println("이 업데이트 되었습니다");
         }
         else
            out.println("업데이트 실패!");
         
         conn.commit();
            
         }catch(SQLException e) {
            out.println("sql error = " + e.getMessage());
         }
   }
   
   else if (num == 2) {
      String sql = "", Address = "", Phone = "", Name = "";
      int Rno = 0;
   
      int H_id = 0;
      H_id = Integer.parseInt(request.getParameter("hno"));
      
      try {
         conn.setAutoCommit(false);
         rs = null;                  
         sql = String.format("SELECT * FROM HOSPITAL WHERE H_id = %d", H_id);
         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
         
         while(rs.next()) {
            Phone = rs.getString(2);
            if (Phone == null)
               Phone = String.format("null");
            else
               Phone = String.format("'" + Phone + "'");
            Name = rs.getString(3);
            Address = rs.getString(4);
            Rno = rs.getInt(5);
         }
         rs.close();
         
      }catch(SQLException ex) {
         out.println("sql error = " + ex.getMessage());
      }
      
      temp = request.getParameter("address");
      if (!temp.equals(""))
         Address = temp;
      
      temp = request.getParameter("name");
      if (!temp.equals(""))
         Name = temp;
      
      temp = request.getParameter("phone_num");
      if (!temp.equals("")) {
         if (temp.equals("NULL"))
            Phone = null;
         else
            Phone = String.format("'" + temp + "'");
      }
      
      temp = request.getParameter("rno");
      if (!temp.equals(""))
         Rno = Integer.parseInt(temp);
         
      try {
         out.println(H_id + " " + Phone + " " + Name + " " + Address + " " + Rno);
         sql = String.format("UPDATE HOSPITAL SET Phone_num = %s, Name = '%s', Address = '%s', Rno = %d WHERE H_id = %d", Phone, Name, Address, Rno, H_id);
         res = stmt.executeUpdate(sql);
         
         if (res == 1) {
            out.println("이 업데이트 되었습니다");
         }
         else
            out.println("업데이트 실패!");
         conn.commit();
         
      }catch(SQLException e) {
         out.println("sql2 error = " + e.getMessage());
      }
      
   }
   
   else if (num == 3) {
      String sql = "", City = "", District = "";
      
      int R_id = 0;
      R_id = Integer.parseInt(request.getParameter("rno"));
      
      try {
         conn.setAutoCommit(false);
         rs = null;                  
         sql = String.format("SELECT * FROM REGION WHERE R_id = %d", R_id);
         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
         
         while(rs.next()) {
            City = rs.getString(2);
            District = rs.getString(3);
         }
         
         rs.close();
         
      }catch(SQLException ex) {
         out.println("sql error = " + ex.getMessage());
      }
      
      temp = request.getParameter("cname");
      if (!temp.equals(""))
         City = temp;
      temp = request.getParameter("dname");
      if (!temp.equals(""))
         District = temp;
      
      try {
         out.println(R_id + " " + City + " " + District);
         sql = String.format("UPDATE REGION SET City = '%s', District = '%s' WHERE R_id = %d", City, District, R_id);
         res = stmt.executeUpdate(sql);
         
         if (res == 1) {
            out.println("이 업데이트 되었습니다");
         }
         else
            out.println("업데이트 실패!");
         conn.commit();
         
      }catch(SQLException e) {
         out.println("sql error = " + e.getMessage());
      }
      
   }
   
   else if (num == 4) {
      String sql = "", Sname = "";
      String Start_Date = "";
      String Pssn = request.getParameter("ssn");
      SimpleDateFormat transFormat = new SimpleDateFormat("yy/MM/dd");
      try {
         conn.setAutoCommit(false);
         rs = null;                  
         sql = String.format("SELECT * FROM HAS WHERE Pssn = '%s'", Pssn);
         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
         
         while(rs.next()) {
            Sname = rs.getString(2);
            Start_Date = transFormat.format(rs.getDate(3));
         }
         
         rs.close();
         
      }catch(SQLException ex) {
         out.println("sql error = " + ex.getMessage());
      }
      
      temp = request.getParameter("sname");
      if (!temp.equals(""))
         Sname = temp;
      
      temp = request.getParameter("start_date");
      if (!temp.equals(""))
         Start_Date = temp;
      
      try {
         out.println(Pssn + " " + Sname + " " + Start_Date);
         sql = String.format("UPDATE HAS SET Sname = '%s', Start_date = '%s' WHERE Pssn = '%s'", Sname, Start_Date, Pssn);
         res = stmt.executeUpdate(sql);
         
         if (res == 1) {
            out.println("이 업데이트 되었습니다");
         }
         else
            out.println("업데이트 실패!");
         conn.commit();
         
      }catch(SQLException e) {
         out.println("sql error = " + e.getMessage());
      }
      
   }
   
   else if (num == 5) {
      String sql = "", Pssn = "", Bssn = "", Phone = "", Fname = "", Lname = "", Sex = "";
      
      Pssn = request.getParameter("pssn");
      Bssn = request.getParameter("bssn");
      
      try {
         conn.setAutoCommit(false);
         rs = null;
         stmt = conn.createStatement();
         sql = String.format("SELECT * FROM BUBBLE WHERE Pssn = '%s' AND Bssn = '%s'", Pssn, Bssn);
         rs = stmt.executeQuery(sql);
      
         while(rs.next()) {
            Phone = rs.getString(3);
            if (Phone == null)
               Phone = String.format("null");
            else
               Phone = String.format("'" + Phone + "'");
            Fname = rs.getString(4);
            Lname = rs.getString(5);
            Sex = rs.getString(6);
         }
      
         rs.close();
      
      }catch(SQLException ex) {
         out.println("sql error = " + ex.getMessage());
      }
      
      temp = request.getParameter("phone_num");
      if (!temp.equals("")) {
         if (temp.equals("NULL"))
            Phone = null;
         else
            Phone = String.format("'" + temp + "'");
      }
      
      temp = request.getParameter("fname");
      if(!temp.equals(""))
         Fname = temp;
      
      temp = request.getParameter("lname");
      if(!temp.equals(""))
         Lname = temp;
      
      temp = request.getParameter("sex");
      if(!temp.equals(""))
         Sex = temp;
      
      try {
         out.println(Pssn + " " + Bssn + " " + Lname + Fname + " " + Phone + " " + Sex);
         sql = String.format("UPDATE BUBBLE SET Phone_num = %s, F_name = '%s', L_name = '%s', Sex = '%s' WHERE Pssn = '%s' AND Bssn = '%s'", Phone, Fname, Lname, Sex, Pssn, Bssn);
         res = stmt.executeUpdate(sql);
         
         if (res == 1) {
            out.println("이 업데이트 되었습니다");
         }
         else
            out.println("업데이트 실패!");
         conn.commit();
         
      }catch(SQLException e) {
         out.println("sql error = " + e.getMessage());
      }
   }
   
   else if (num == 6) {
      String sql = "", Place = "";
      String Pssn = request.getParameter("pssn");
      int P_id = 0;
      
      try {
         conn.setAutoCommit(false);
         stmt = conn.createStatement();
         rs = null;
         sql = String.format("SELECT * FROM PATH WHERE Pssn = '%s'", Pssn);
         rs = stmt.executeQuery(sql);
         
         while(rs.next()) {
            Place = rs.getString(3);
            P_id = rs.getInt(2);
         }
         rs.close();
         
      }catch(SQLException ex) {
         out.println("sql error = " + ex.getMessage());
      }
      
      temp = request.getParameter("path");
      if(!temp.equals(""))
         Place = temp;
      
      try {
         out.println(P_id + " " + Pssn + " " + Place);
         sql = String.format("UPDATE PATH SET Place = '%s' WHERE Pssn = '%s'",Place, Pssn);
         res = stmt.executeUpdate(sql);
         
         if (res == 1) {
            out.println("이 업데이트 되었습니다");
         }
         else
            out.println("업데이트 실패!");
         conn.commit();
         
      }catch(SQLException e) {
         out.println("sql error = " + e.getMessage());
      }
   }
   
   else if (num == 7) {
      String sql = "", Treatment = "", Finish_Date = "";
      String Pssn = request.getParameter("ssn");
      SimpleDateFormat transFormat = new SimpleDateFormat("yy/MM/dd");
      int C_id = 0;
   
      try {
         conn.setAutoCommit(false);
         stmt = conn.createStatement();
         rs = null;      
         sql = String.format("SELECT * FROM RECOVERY WHERE Pssn = '%s'", Pssn);
         rs = stmt.executeQuery(sql);
         
         while(rs.next()) {
            C_id = rs.getInt(2);
            Treatment = rs.getString(3);
            Finish_Date = transFormat.format(rs.getDate(4));
         }
         rs.close();
         
      }catch(SQLException ex) {
         out.println("sql error = " + ex.getMessage());
      }
      
      temp = request.getParameter("treatment");
      if(!temp.equals(""))
         Treatment = temp;
      
      temp = request.getParameter("finish_date");
      if(!temp.equals(""))
         Finish_Date = temp;
      
      try {
         out.println(C_id + " " + Pssn + " " + Treatment + " " + Finish_Date);
         sql = String.format("UPDATE RECOVERY SET Treatment = '%s', Finish_date = '%s' WHERE Pssn = '%s'", Treatment, Finish_Date, Pssn);
         res = stmt.executeUpdate(sql);
         
         if (res == 1) {
            out.println("이 업데이트 되었습니다");
         }
         else
            out.println("업데이트 실패!");
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