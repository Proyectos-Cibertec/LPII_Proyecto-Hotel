package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import entidad.Producto;
import entidad.Servicio;
import util.MySql_DBConexion;

public class MySqlProductoDAO implements ProductoDAO {

	private static final Log log = LogFactory.getLog(MySqlProductoDAO.class);

	public int insertaProducto(Producto obj) throws Exception {
		Connection conn = null;
		PreparedStatement pstm = null;
		int salida = -1;
		try {
			String sql = "INSERT INTO producto VALUES(null, ?, ?, ?)";
			conn = MySql_DBConexion.getConexion();
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, obj.getDescripcion());
			pstm.setDouble(2, obj.getCosto());
			pstm.setInt(3, obj.getServicio().getIdServicio());

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

	public int actualizaProducto(Producto obj) throws Exception {
		Connection conn = null;
		PreparedStatement pstm = null;
		int salida = -1;
		try {
			String sql = "UPDATE producto SET descripcion = ?, costo = ?, idServicio = ? WHERE idProducto = ?";
			conn = MySql_DBConexion.getConexion();
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, obj.getDescripcion());
			pstm.setDouble(2, obj.getCosto());
			pstm.setInt(3, obj.getServicio().getIdServicio());
			pstm.setInt(4, obj.getIdProducto());

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

	public int eliminaProducto(int idProducto) throws Exception {
		Connection conn = null;
		PreparedStatement pstm = null;
		int salida = -1;
		try {
			String sql = "DELETE FROM producto WHERE idProducto = ?";
			conn = MySql_DBConexion.getConexion();
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, idProducto);

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

	public List<Producto> listaProducto() throws Exception {
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;

		List<Producto> lista = new ArrayList<Producto>();
		try {
			String sql = "SELECT P.idProducto, P.descripcion, P.costo, S.idServicio, S.nombre FROM producto P "
					+ "INNER JOIN servicio S ON S.idServicio = P.idServicio";

			conn = MySql_DBConexion.getConexion();
			pstm = conn.prepareStatement(sql);

			log.info(pstm);
			System.out.println(pstm);

			rs = pstm.executeQuery();
			Producto bean = null;
			Servicio servicio = null;

			while (rs.next()) {
				bean = new Producto();
				bean.setIdProducto(rs.getInt(1));
				bean.setDescripcion(rs.getString(2));
				bean.setCosto(rs.getDouble(3));

				servicio = new Servicio();
				servicio.setIdServicio(rs.getInt(4));
				servicio.setNombre(rs.getString(5));
				bean.setServicio(servicio);

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

	public List<Producto> consultaProducto(String descripcion) throws Exception {
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;

		List<Producto> lista = new ArrayList<Producto>();
		try {
			String sql = "SELECT P.idProducto, P.descripcion, P.costo, S.idServicio, S.nombre FROM producto P "
					+ "INNER JOIN servicio S ON S.idServicio = P.idServicio WHERE P.descripcion LIKE ?";

			conn = MySql_DBConexion.getConexion();
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, '%' + descripcion + '%');

			log.info(pstm);
			System.out.println(pstm);

			rs = pstm.executeQuery();
			Producto bean = null;
			Servicio servicio = null;

			while (rs.next()) {
				bean = new Producto();
				bean.setIdProducto(rs.getInt(1));
				bean.setDescripcion(rs.getString(2));
				bean.setCosto(rs.getDouble(3));

				servicio = new Servicio();
				servicio.setIdServicio(rs.getInt(4));
				servicio.setNombre(rs.getString(5));
				bean.setServicio(servicio);

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
	
	public List<Producto> buscaProductoXDescripcion(String descripcion) throws Exception {
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;

		List<Producto> lista = new ArrayList<Producto>();
		try {
			String sql = "SELECT P.idProducto, P.descripcion, P.costo, S.idServicio, S.nombre FROM producto P "
					+ "INNER JOIN servicio S ON S.idServicio = P.idServicio WHERE P.descripcion LIKE ?";

			conn = MySql_DBConexion.getConexion();
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, '%' + descripcion + '%');

			log.info(pstm);
			System.out.println(pstm);

			rs = pstm.executeQuery();
			Producto bean = null;
			Servicio servicio = null;

			while (rs.next()) {
				bean = new Producto();
				bean.setIdProducto(rs.getInt(1));
				bean.setDescripcion(rs.getString(2));
				bean.setCosto(rs.getDouble(3));

				servicio = new Servicio();
				servicio.setIdServicio(rs.getInt(4));
				servicio.setNombre(rs.getString(5));
				bean.setServicio(servicio);

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
