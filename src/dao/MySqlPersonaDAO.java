package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import entidad.Persona;
import util.MySql_DBConexion;

public class MySqlPersonaDAO implements PersonaDAO {

	@Override
	public List<Persona> consultaXDni(String dni) {
		List<Persona> data = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			conn = MySql_DBConexion.getConexion();
			String sql = "SELECT P.idPersona, P.nombres, P.apellidos, P.dni, P.direccion, P.telefono, P.fechaNacimiento "
					+ "FROM persona P WHERE P.dni = ?";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, dni);
			
			System.out.println(pstm);
			
			rs = pstm.executeQuery();

			Persona obj = null;
			while (rs.next()) {
				obj = new Persona();

				obj.setId(rs.getInt(1));
				obj.setNombres(rs.getString(2));
				obj.setApellidos(rs.getString(3));
				obj.setDni(rs.getString(4));
				obj.setDireccion(rs.getString(5));
				obj.setTelefono(rs.getString(6));
				obj.setFechaNacimiento(rs.getString(7));

				data.add(obj);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstm != null)
					pstm.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return data;
	}

}
