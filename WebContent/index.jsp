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
	Connection c = DBUtil.getConnection();
	Statement stmt = c.createStatement();
	
	String sql = "select nume from ingrediente";
	ResultSet rs = stmt.executeQuery(sql);
	
	while(rs.next()){
		String nume = rs.getString("nume");
		out.println(nume);
	}
 %>
</body>
</html>