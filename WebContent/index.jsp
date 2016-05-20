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
<title>Pizza</title>
</head>
<body>

<h1> Meniu </h1>


<div class="bigSection">
<div class="section">
<%
	Connection c = null;
		try {
			c = DBUtil.getConnection();
			// deci aici faci interogarile pt baza de date dupa modelul asta mkay?
			String sql = "select * from pizza";
			Statement stmt = c.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
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
					
				out.print("<FORM NAME=\"form1\"METHOD=\"POST\"> <input type=\"button\" VALUE=\"Adauga in cos\" ONCLICK=\"functieButon()\"> </Form>");
				out.print("<br>");
				out.print("<br>");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 %>
 
 
 </div>

 
 
 </div>
 
 
 
 
 


 <style>
 body{
 background-color: Beige;
 }

form{
border-bottom: 1px solid black;
padding: 1px;
float:right;
width:100%;
}
input{
float:right;
}

.bigSection{
width:55%;
float: left;
margin-right:20%;
margin-left:20%;
}
 
 .section{
 text-aling: center;
 padding: 20px;
 border: 1px solid black;
 }
 
 h1{
 width: 100%;
 margin-left:0;
 border: 1px solid black;
 text-align:center;
 }
 </style>
 
 
 
 

 
 
 
 
 
 
 
 
</body>
</html>