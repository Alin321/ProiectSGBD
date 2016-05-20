<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
<title>Comanda ta</title>
<link href="index.css" rel="stylesheet" type="text/css" />



</head>
<body>


<h1>Comanda ta</h1>
<a href="cosCumparaturi.jsp">Vezi comanda ta aici</a>

<div class="bigSection">
<div class="section">

<%
		//aici cod neinteresant
				out.print("<FORM NAME=\"delete\"METHOD=\"Delete\"> <input type=\"button\" VALUE=\"Sterge din cos\" ONCLICK=\"functieButon_stergere()\"> </Form>");
				out.print("<br>");
				out.print("<br>");

 %>


 </div>
 </div>
 




</body>
</html>