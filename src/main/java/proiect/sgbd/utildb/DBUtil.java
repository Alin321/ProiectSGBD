package proiect.sgbd.utildb;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
public class DBUtil {
	public static Connection getConnection() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con = DriverManager.getConnection(
				"jdbc:oracle:thin:student/student@localhost:1521:xe", "student", "student");
		return con;
	}
	
	public static void cleanUp(Statement st, Connection con) {
		try {
			if (st != null) {
				st.close();
			}
			if (con != null) {
				con.close();
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	}	
}
