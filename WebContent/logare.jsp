<%@page import="java.sql.SQLType"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="proiect.sgbd.utildb.DBUtil"%>
<%@page import="java.sql.SQLException"%>
<%
	String email = request.getParameter("E-mail");
	String parola = request.getParameter("Parola");
	
	Connection c = DBUtil.getConnection();
	CallableStatement cstmt = c.prepareCall("{call application_procedures.login(?,?)}");
	
	cstmt.setString(1,email);
	cstmt.setString(2,parola);
	try{
		cstmt.executeUpdate();
		session.setAttribute("EMAIL", email);
		
		String sql = "select nume, prenume, id from client where email='" + email +"'";
		Statement stmt = c.createStatement();
		ResultSet rs = stmt.executeQuery(sql);		
		
		rs.next();
		String nume = rs.getString(1);
		String prenume = rs.getString(2);
		int idClient = rs.getInt(3);
		session.setAttribute("NUME", nume);
		session.setAttribute("PRENUME", prenume);
		
		cstmt = c.prepareCall("{call APPLICATION_PROCEDURES.VERIFICA_ZI_NASTERE(?,?)}");
		cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
		cstmt.setInt(1, idClient);
		
		cstmt.executeUpdate();
		String raspuns = cstmt.getString(2);
		if(raspuns.equalsIgnoreCase("da")) {
			session.setAttribute("NASTERE", "da");
		} else session.setAttribute("NASTERE", "nu");
		
		
		String site = new String("/Pizza/index.jsp");
   		response.setStatus(response.SC_MOVED_TEMPORARILY);
   		response.setHeader("Location", site); 
		
	}catch (SQLException e){
//		String [] erori = e.getMessage().split("ORA");
//		String [] mesaje = erori[1].split(":");		
//		out.println(mesaje[1]);
		
		out.println(e);	
	}
%>