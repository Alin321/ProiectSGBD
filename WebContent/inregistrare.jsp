<%@page import="java.sql.Date"%>
<%@page import="java.sql.SQLType"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="proiect.sgbd.utildb.DBUtil"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Calendar"%>

<%
	String nume = ""; nume = request.getParameter("Nume");
	String prenume = "";prenume = request.getParameter("Prenume");
	String Email = ""; Email = request.getParameter("E-mail");
	String Parola = ""; Parola = request.getParameter("Parola");
	String ReParola = "";ReParola = request.getParameter("ReParola");
	String Data_nastere = "";Data_nastere = request.getParameter("data");
	String Telefon ="";Telefon =  request.getParameter("Telefon");
	String Strada ="";Strada = request.getParameter("Strada");
	String Numar ="";Numar = request.getParameter("Numar");
	String Bloc =""; Bloc = request.getParameter("Bloc");
	String Scara ="";Scara = request.getParameter("Scara");
	String Etaj = "";Etaj = request.getParameter("Etaj");
	String Apartament ="";Apartament = request.getParameter("Apartament");

	//p_nume in VARCHAR2, p_prenume in VARCHAR2, p_email in VARCHAR2, p_parola in VARCHAR2, p_confirmare_parola in VARCHAR2, 
	//p_data_nastere in DATE, p_telefon in VARCHAR2, p_strada in VARCHAR2, p_numar in NUMBER,p_bloc in VARCHAR2,p_scara in VARCHAR2,
	//p_etaj in NUMBER, p_apartament in NUMBER);
	int intNumar = 0;
	int intEtaj = 0;
	int intApart = 0;
	try{
		intNumar = Integer.parseInt(Numar);
		intEtaj = Integer.parseInt(Etaj);
		intApart = Integer.parseInt(Apartament);
	} catch (NumberFormatException e) {
		intNumar = 0;
		intEtaj = 0;
		intApart = 0;
	}
	Connection c = DBUtil.getConnection();
	CallableStatement cstmt = c
			.prepareCall("{call application_procedures.inregistrare(?,?,?,?,?,?,?,?,?,?,?,?,?)}");

	cstmt.setString(1, nume);
	cstmt.setString(2, prenume);
	cstmt.setString(3, Email);
	cstmt.setString(4, Parola);
	cstmt.setString(5, ReParola);
	cstmt.setDate(6, java.sql.Date.valueOf(Data_nastere) );
	cstmt.setString(7, Telefon);
	cstmt.setString(8, Strada);
	cstmt.setInt(9, intNumar);
	cstmt.setString(10, Bloc);
	cstmt.setString(11, Scara);
	cstmt.setInt(12, intEtaj);
	cstmt.setInt(13, intApart);
	try{
		cstmt.executeUpdate();
		String site = new String("/Pizza/login.html");
   		response.setStatus(response.SC_MOVED_TEMPORARILY);
   		response.setHeader("Location", site);
   	} catch( SQLException e ) {
   		String [] erori = e.getMessage().split("ORA");
		String [] mesaje = erori[1].split(":");		
		out.println(mesaje[1]);
   	} 
%>