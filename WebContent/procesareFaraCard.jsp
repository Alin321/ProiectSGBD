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
<%
	String email = String.valueOf(session.getAttribute("EMAIL"));
	int idBon = Integer.parseInt(String.valueOf(session.getAttribute("BON")));
	Connection c = null;
	try {
		c = DBUtil.getConnection();
	} catch (Exception e) {
	}
	String sql = "select id from client where email='" + email + "'";
	Statement stmt = c.createStatement();
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
	int idClient = rs.getInt(1);

	CallableStatement cstmt3 = c.prepareCall("{call TABLE_INSERTS.INSERT_INTO_VANZARI(?,?)}");
	cstmt3.setInt(1, idClient);
	cstmt3.setInt(2, idBon);

	try {
		cstmt3.executeUpdate();
		session.removeAttribute("BON");
		session.removeAttribute("EMAIL");
		session.removeAttribute("NUME");
		session.removeAttribute("PRENUME");
		String site = new String("/Pizza");
   		response.setStatus(response.SC_MOVED_TEMPORARILY);
   		response.setHeader("Location", site);
	} catch (SQLException e) {
		out.println(e);
	}
	
	
%>