<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="proiect.sgbd.utildb.DBUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="proiect.sgbd.entities.Cart"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.SQLException"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Comanda ta</title>
<link href="index.css" rel="stylesheet" type="text/css" />



</head>
<body>


<h1>Comanda ta</h1>

<div class="bigSection">
<div class="section">

<%
		out.println("Pizzele selectate: <br>");
		String[] listOfPizza = request.getParameterValues("pizza");
		List<Integer> listOfIds = new ArrayList<>();
		
		for(String s : listOfPizza) {
			listOfIds.add(Integer.parseInt(s));
		}
		
		Connection c = null;
		try {
			c = DBUtil.getConnection();
		} catch(Exception e) {}
		
		String sql1 = "select max(id) from bon";
		Statement stmt1 = c.createStatement();
		ResultSet rs1 = stmt1.executeQuery(sql1);
		
		rs1.next();
		int idBon = rs1.getInt(1);
		idBon++;
		java.sql.Date date = new java.sql.Date(Calendar.getInstance().getTime().getTime());
		session.setAttribute("BON",idBon);
		for (Integer i : listOfIds) {
			String sql = "select * from pizza where id="+i.intValue();
			Statement stmt = c.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			rs.next();
			
			
			// insert_into_bon(p_id in NUMBER, p_data_creare in DATE, p_id_pizza in NUMBER)
			CallableStatement cstmt1 = c.prepareCall("{call TABLE_INSERTS.insert_into_bon(?,?,?)}");
			cstmt1.setInt(1, idBon);
			cstmt1.setDate(2,date);
			cstmt1.setInt(3,i);
			try{
				cstmt1.executeUpdate();
			}catch(SQLException e) {
				System.out.println(e);
			}
			String numePizza = rs.getString("nume");
			double pret = rs.getDouble("pret");			
			
			out.println(numePizza+"                           "+pret+" lei <br>");
		}
		String zi = String.valueOf(session.getAttribute("NASTERE"));
		if(zi.equalsIgnoreCase("da")){
			out.println("Tort cadou               0 lei <br>");
		}
		double pretTotal = 0;
		
		//calculeaza_total_bon(p_id_bon in NUMBER, p_total out NUMBER);
		CallableStatement cstmt2 = c.prepareCall("{call application_procedures.calculeaza_total_bon(?,?)}");
		cstmt2.registerOutParameter(2, java.sql.Types.DOUBLE);
		cstmt2.setInt(1, idBon);
		
		try {
			cstmt2.executeUpdate();
			
			pretTotal = cstmt2.getDouble(2);
		} catch(SQLException e) {
			out.println(e);
		}
		
		out.println("TOTAL                         "+ pretTotal + " lei <br>");

		String email = String.valueOf(session.getAttribute("EMAIL"));
		String adresaClient = "";
		
		CallableStatement cstmt3 = c.prepareCall("{call application_procedures.adresa_clientului(?,?)}");
		cstmt3.registerOutParameter(2, java.sql.Types.VARCHAR);
		cstmt3.setString(1, email);
		
		try {
			cstmt3.executeUpdate();			
			adresaClient = cstmt3.getString(2);
		} catch(SQLException e) {
			out.println(e);
		}
		
		out.println("<br><br>");
		
		out.println("Comanda va fi livrata la adresa: " + adresaClient + "<br><br>");
	
		double puncteCard = 0;
		
		cstmt3 = c.prepareCall("{call application_procedures.numar_puncte_card(?,?)}");
		cstmt3.registerOutParameter(2, java.sql.Types.DOUBLE);
		cstmt3.setString(1, email);		
		try {
			cstmt3.executeUpdate();			
			puncteCard = cstmt3.getDouble(2);
		} catch(SQLException e) {
			out.println(e);
		}
		
		out.print("Puncte disponibile pe card: " + puncteCard + " lei. <br><br>");
		double diferenta = pretTotal - puncteCard;
		if(diferenta < 0) diferenta = 0;
		if(puncteCard > 0) {
			out.println("<FORM NAME=\"form1\"METHOD=\"POST\" action=\"procesareCard.jsp\"> <br>");
			out.println("Foloseste puncte card (Rest de plata "+diferenta+" lei))) <input  type=\"checkbox\" name=\"card\" value=\"ok\"> <br> <br> <br>");
			out.println("<input type=\"submit\" value = \"Finalizare comanda\" >");
		} else {
			out.println("<FORM NAME=\"form1\"METHOD=\"POST\" action=\"procesareFaraCard.jsp\"> <br>");
			out.println("<input type=\"submit\" value = \"Finalizare comanda\" >");
		}
 %>


 </div>
 </div>
 




</body>
</html>