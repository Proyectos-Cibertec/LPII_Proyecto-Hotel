package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import entidad.Categoria_Habitacion;
import util.MySql_DBConexion;

public class MySqlCategoria_HabitacionDAO implements Categoria_HabitacionDAO {

	@Override
	public List<Categoria_Habitacion> listaCategoriaHabitacion() {
		List<Categoria_Habitacion> data = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			conn = MySql_DBConexion.getConexion();
			String sql = "SELECT * from estado_habitacion";
			pstm = conn.prepareStatement(sql);
			rs = pstm.executeQuery();

			Categoria_Habitacion obj = null;
			while (rs.next()) {
				obj = new Categoria_Habitacion();

				obj.setIdCategoria(rs.getInt(1));
				obj.setDescripcion(rs.getString(2));
				
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
