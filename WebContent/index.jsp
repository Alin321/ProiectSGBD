<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="proiect.sgbd.utildb.DBUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	Connection c = null;
		try {
			c = DBUtil.getConnection();
			String sql = "select * from pizza";
			Statement stmt = c.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int idPizza = rs.getInt("id");
				int pret = rs.getInt("pret");
				String numePizza = rs.getString("nume");
				out.println(numePizza + ": " + pret + " lei" + "<br>");
				String innerSql = "select i.nume from pizza p join ingrediente_pizza ip on ip.id_pizza = p.id join ingrediente i on ip.id_ingredient=i.id where p.id =" + idPizza;
				
				Statement stmt2 = c.createStatement();
				ResultSet innerRs = stmt2.executeQuery(innerSql);
				out.print("Ingrediente: ");
				while (innerRs.next()){
					
					String numeIngredient = innerRs.getString(1);
					out.print(numeIngredient+" ");
				}
				out.println("<br>");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 %>
</body>
</html>