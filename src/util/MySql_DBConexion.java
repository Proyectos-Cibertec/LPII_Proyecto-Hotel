package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class MySql_DBConexion {

	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static Connection getConexion() {
		Connection conexion = null;

		try {
			// conexion = DriverManager.getConnection("jdbc:mysql://localhost/hotel", "root", "");
			conexion = DriverManager.getConnection("jdbc:mysql://localhost/hotel", "root", "mysql");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return conexion;
	}
}
