package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import entidad.Categoria_Habitacion;
import entidad.Estado_Habitacion;
import entidad.Habitacion;
import entidad.Tipo_Habitacion;
import util.MySql_DBConexion;

public class MySqlHabitacionDAO implements HabitacionDAO {

	private static final Log log = LogFactory.getLog(MySqlHabitacionDAO.class);

	public int insertaHabitacion(Habitacion obj) throws Exception {
		Connection conn = null;
		PreparedStatement pstm = null;
		int salida = -1;
		try {
			String sql = "INSERT INTO habitacion VALUES(null, ?, ?, ?, ?, ?, ?)";
			conn = MySql_DBConexion.getConexion();
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, obj.getNumero());
			pstm.setInt(2, obj.getPiso());
			pstm.setInt(3, obj.getTipo().getIdTipo());
			pstm.setInt(4, obj.getCategoria().getIdCategoria());
			pstm.setInt(5, obj.getEstado().getIdEstado());
			pstm.setDouble(6, obj.getCosto());

			log.info(pstm);

			salida = pstm.executeUpdate();

		} catch (Exception e) {
			log.info(e);
		} finally {
			try {
				if (pstm != null)
					pstm.close();
			} catch (SQLException e1) {
			}
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
			}
		}
		return salida;
	}

	public int actualizarHabitacion(Habitacion obj) throws Exception {
		Connection conn = null;
		PreparedStatement pstm = null;
		int salida = -1;
		try {
			String sql = "UPDATE habitacion set numero=?, piso=?, idTipo=?, idCategoria=?, idEstado=?, costo=? WHERE idHabitacion=?";
			conn = MySql_DBConexion.getConexion();
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, obj.getNumero());
			pstm.setInt(2, obj.getPiso());
			pstm.setInt(3, obj.getTipo().getIdTipo());
			pstm.setInt(4, obj.getCategoria().getIdCategoria());
			pstm.setInt(5, obj.getEstado().getIdEstado());
			pstm.setDouble(6, obj.getCosto());

			pstm.setInt(7, obj.getIdHabitacion());

			log.info(pstm);

			salida = pstm.executeUpdate();

		} catch (Exception e) {
			log.info(e);
		} finally {
			try {
				if (pstm != null)
					pstm.close();
			} catch (SQLException e1) {
			}
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
			}
		}
		return salida;
	}

	public int eliminaHabitacion(int idHabitacion) throws Exception {
		Connection conn = null;
		PreparedStatement pstm = null;
		int salida = -1;
		try {
			String sql = "delete from habitacion where idHabitacion=?";
			conn = MySql_DBConexion.getConexion();
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, idHabitacion);

			log.info(pstm);

			salida = pstm.executeUpdate();

		} catch (Exception e) {
			log.info(e);
		} finally {
			try {
				if (pstm != null)
					pstm.close();
			} catch (SQLException e1) {
			}
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
			}
		}
		return salida;
	}

	public List<Habitacion> listarHabitacion() throws Exception {
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;

		List<Habitacion> lista = new ArrayList<Habitacion>();
		try {
			String sql = "SELECT H.idHabitacion, H.numero, H.piso, H.idTipo, TH.descripcion, H.idCategoria, CH.descripcion, H.idEstado, "
					+ "EH.descripcion, H.costo FROM habitacion H INNER JOIN tipo_habitacion TH ON TH.idTipo = H.idTipo "
					+ "INNER JOIN categoria_habitacion CH ON CH.idCategoria = H.idCategoria INNER JOIN estado_habitacion EH "
					+ "ON EH.idEstado = H.idEstado";

			conn = MySql_DBConexion.getConexion();
			pstm = conn.prepareStatement(sql);

			log.info(pstm);
			System.out.println(pstm);

			rs = pstm.executeQuery();
			Habitacion bean = null;
			Tipo_Habitacion tipo = null;
			Categoria_Habitacion cat = null;
			Estado_Habitacion est = null;

			while (rs.next()) {
				bean = new Habitacion();
				bean.setIdHabitacion(rs.getInt(1));
				bean.setNumero(rs.getInt(2));
				bean.setPiso(rs.getInt(3));

				tipo = new Tipo_Habitacion();
				tipo.setIdTipo(rs.getInt(4));
				tipo.setDescripcion(rs.getString(5));
				bean.setTipo(tipo);

				cat = new Categoria_Habitacion();
				cat.setIdCategoria(rs.getInt(6));
				cat.setDescripcion(rs.getString(7));
				bean.setCategoria(cat);

				est = new Estado_Habitacion();
				est.setIdEstado(rs.getInt(8));
				est.setDescripcion(rs.getString(9));
				bean.setEstado(est);
				bean.setCosto(rs.getDouble(10));

				lista.add(bean);
			}
		} catch (Exception e) {
			log.info(e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstm != null)
					pstm.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
			}
		}

		return lista;
	}

	public List<Habitacion> consultaHabitacion(int piso) throws Exception {
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;

		List<Habitacion> lista = new ArrayList<Habitacion>();
		try {
			String sql = "SELECT H.idHabitacion, H.numero, H.piso, H.idTipo, TH.descripcion, H.idCategoria, CH.descripcion, H.idEstado, "
					+ "EH.descripcion, H.costo from habitacion H INNER JOIN tipo_habitacion TH ON TH.idTipo = H.idTipo "
					+ "INNER JOIN categoria_habitacion CH ON CH.idCategoria = H.idCategoria INNER JOIN estado_habitacion EH "
					+ "ON EH.idEstado = H.idEstado WHERE H.piso = ?";

			conn = MySql_DBConexion.getConexion();
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, piso);

			log.info(pstm);
			System.out.println(pstm);

			rs = pstm.executeQuery();
			Habitacion bean = null;
			Tipo_Habitacion tipo = null;
			Categoria_Habitacion cat = null;
			Estado_Habitacion est = null;

			while (rs.next()) {
				bean = new Habitacion();
				bean.setIdHabitacion(rs.getInt(1));
				bean.setNumero(rs.getInt(2));
				bean.setPiso(rs.getInt(3));

				tipo = new Tipo_Habitacion();
				tipo.setIdTipo(rs.getInt(4));
				tipo.setDescripcion(rs.getString(5));
				bean.setTipo(tipo);

				cat = new Categoria_Habitacion();
				cat.setIdCategoria(rs.getInt(6));
				cat.setDescripcion(rs.getString(7));
				bean.setCategoria(cat);

				est = new Estado_Habitacion();
				est.setIdEstado(rs.getInt(8));
				est.setDescripcion(rs.getString(9));
				bean.setEstado(est);
				bean.setCosto(rs.getDouble(10));

				lista.add(bean);
			}
		} catch (Exception e) {
			log.info(e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstm != null)
					pstm.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
			}
		}

		return lista;
	}
	
	public Habitacion obtenerHabitacionPorID(int idHabitacion) throws Exception {
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;

		Habitacion bean = null;
		try {
			String sql = "SELECT H.idHabitacion, H.numero, H.piso, H.idTipo, TH.descripcion, H.idCategoria, CH.descripcion, H.idEstado, "
					+ "EH.descripcion, H.costo from habitacion H INNER JOIN tipo_habitacion TH ON TH.idTipo = H.idTipo "
					+ "INNER JOIN categoria_habitacion CH ON CH.idCategoria = H.idCategoria INNER JOIN estado_habitacion EH "
					+ "ON EH.idEstado = H.idEstado WHERE H.idHabitacion = ?";

			conn = MySql_DBConexion.getConexion();
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, idHabitacion);

			log.info(pstm);
			System.out.println(pstm);

			rs = pstm.executeQuery();
			Tipo_Habitacion tipo = null;
			Categoria_Habitacion cat = null;
			Estado_Habitacion est = null;

			if (rs.next()) {
				bean = new Habitacion();
				bean.setIdHabitacion(rs.getInt(1));
				bean.setNumero(rs.getInt(2));
				bean.setPiso(rs.getInt(3));

				tipo = new Tipo_Habitacion();
				tipo.setIdTipo(rs.getInt(4));
				tipo.setDescripcion(rs.getString(5));
				bean.setTipo(tipo);

				cat = new Categoria_Habitacion();
				cat.setIdCategoria(rs.getInt(6));
				cat.setDescripcion(rs.getString(7));
				bean.setCategoria(cat);

				est = new Estado_Habitacion();
				est.setIdEstado(rs.getInt(8));
				est.setDescripcion(rs.getString(9));
				bean.setEstado(est);
				bean.setCosto(rs.getDouble(10));
			}
		} catch (Exception e) {
			log.info(e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstm != null)
					pstm.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
			}
		}

		return bean;
	}

	public List<Habitacion> buscarHabitacionXTipoCategoriaEstado(String tipoH, String categoriaH, String estadoH) throws Exception {
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;

		List<Habitacion> lista = new ArrayList<Habitacion>();
		try {
			String sql = "SELECT H.idHabitacion, H.numero, H.piso, H.idTipo, TH.descripcion, H.idCategoria, CH.descripcion, H.idEstado, "
					+ "EH.descripcion, H.costo from habitacion H INNER JOIN tipo_habitacion TH ON TH.idTipo = H.idTipo "
					+ "INNER JOIN categoria_habitacion CH ON CH.idCategoria = H.idCategoria INNER JOIN estado_habitacion EH "
					+ "ON EH.idEstado = H.idEstado WHERE TH.descripcion LIKE ? AND CH.descripcion LIKE ? AND EH.descripcion LIKE ?";

			conn = MySql_DBConexion.getConexion();
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, '%' + tipoH + '%');
			pstm.setString(2, '%' + categoriaH + '%');
			pstm.setString(3, '%' + estadoH + '%');

			log.info(pstm);
			System.out.println(pstm);

			rs = pstm.executeQuery();
			Habitacion bean = null;
			Tipo_Habitacion tipo = null;
			Categoria_Habitacion cat = null;
			Estado_Habitacion est = null;

			while (rs.next()) {
				bean = new Habitacion();
				bean.setIdHabitacion(rs.getInt(1));
				bean.setNumero(rs.getInt(2));
				bean.setPiso(rs.getInt(3));

				tipo = new Tipo_Habitacion();
				tipo.setIdTipo(rs.getInt(4));
				tipo.setDescripcion(rs.getString(5));
				bean.setTipo(tipo);

				cat = new Categoria_Habitacion();
				cat.setIdCategoria(rs.getInt(6));
				cat.setDescripcion(rs.getString(7));
				bean.setCategoria(cat);

				est = new Estado_Habitacion();
				est.setIdEstado(rs.getInt(8));
				est.setDescripcion(rs.getString(9));
				bean.setEstado(est);
				bean.setCosto(rs.getDouble(10));

				lista.add(bean);
			}
		} catch (Exception e) {
			log.info(e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstm != null)
					pstm.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
			}
		}

		return lista;
	}
}
