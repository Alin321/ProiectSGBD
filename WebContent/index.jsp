<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="proiect.sgbd.utildb.DBUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="proiect.sgbd.entities.Cart"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pizza</title>
<link href="index.css" rel="stylesheet" type="text/css" />
</head>
<body>

<h1> Meniu </h1>

<div class="bigSection">

<div class="section">
Bine ai venit, <%=session.getAttribute("NUME") %> <%=session.getAttribute("PRENUME") %> ! <br>
<%
	String zi = String.valueOf(session.getAttribute("NASTERE"));
	if(zi.equalsIgnoreCase("da")){
		out.println("La multi ani! Fiindca azi e ziua ta la orice comanda primesti un tort gratuit! <br>");
	}
 %>
<%
	Connection c = null;
		try {
			c = DBUtil.getConnection();
			String sql = "select * from pizza";
			Statement stmt = c.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			out.println("<FORM NAME=\"form1\"METHOD=\"POST\" action=\"cosCumparaturi.jsp\">");
			while (rs.next()) {
				int idPizza = rs.getInt("id");
				int pret = rs.getInt("pret");
				String numePizza = rs.getString("nume");
				out.print("<br>");
				out.println(numePizza + ": " + pret + " lei" + "<br>");
				String innerSql = "select i.nume from pizza p join ingrediente_pizza ip on ip.id_pizza = p.id join ingrediente i on ip.id_ingredient=i.id where p.id =" + idPizza;
				
				Statement stmt2 = c.createStatement();
				ResultSet innerRs = stmt2.executeQuery(innerSql);
				out.print("Ingrediente: ");

				while (innerRs.next()){
					
					String numeIngredient = innerRs.getString(1);
					out.print(numeIngredient+" ");
				}
					
				out.print("<input  type=\"checkbox\" name=\"pizza\" value=\""+idPizza+"\"> ");
				out.print("<br>");
				out.print("<br>");
			}
			out.println();
			out.println("<input type=\"submit\" value=\"Mergi Catre Cos\">");
			out.println("</form>");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 %>




 </div>
 </div>
 
 
</body>
</html>