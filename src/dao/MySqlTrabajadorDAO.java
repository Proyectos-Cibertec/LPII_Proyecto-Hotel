package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import entidad.Trabajador;
import util.MySql_DBConexion;

public class MySqlTrabajadorDAO implements TrabajadorDAO {

	@Override
	public List<Trabajador> listaTrabajador() {
		List<Trabajador> data = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			conn = MySql_DBConexion.getConexion();
			String sql = "SELECT T.idTrabajador, P.nombres, P.apellidos, P.dni, P.direccion, P.telefono, P.fechaNacimiento, "
					+ "T.fechaContratacion, T.salario from trabajador T INNER JOIN persona P ON P.idPersona = T.idTrabajador";
			pstm = conn.prepareStatement(sql);
			rs = pstm.executeQuery();

			Trabajador obj = null;
			while (rs.next()) {
				obj = new Trabajador();

				obj.setId(rs.getInt(1));
				obj.setNombres(rs.getString(2));
				obj.setApellidos(rs.getString(3));
				obj.setDni(rs.getString(4));
				obj.setDireccion(rs.getString(5));
				obj.setTelefono(rs.getString(6));
				obj.setFechaNacimiento(rs.getString(7));
				obj.setFechaContratacion(rs.getString(8));
				obj.setSalario(rs.getDouble(9));

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

	@Override
	public int insertaTrabajador(Trabajador trabajador) { // Inserta en dos tablas: Persona, Trabajador
		int salida = -1;

		Connection conn = null;
		PreparedStatement pstm1 = null;
		PreparedStatement pstm2 = null;
		ResultSet rs = null;
		try {
			conn = MySql_DBConexion.getConexion();

			// Se anula el autoenvío
			conn.setAutoCommit(false);

			String sql = "INSERT INTO persona VALUES(NULL, ?, ?, ?, ?, ?, ?)";
			pstm1 = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			pstm1.setString(1, trabajador.getNombres());
			pstm1.setString(2, trabajador.getApellidos());
			pstm1.setString(3, trabajador.getDni());
			pstm1.setString(4, trabajador.getDireccion());
			pstm1.setString(5, trabajador.getTelefono());
			pstm1.setString(6, trabajador.getFechaNacimiento());

			System.out.println(pstm1);
			salida = pstm1.executeUpdate();

			if (salida > 0) {
				// Se inserta en la tabla trabajador

				// Obtiene el último id insertado en la tabla persona
				int idTrabajador;
				rs = pstm1.getGeneratedKeys();

				if (rs.next()) {
					idTrabajador = rs.getInt(1);
					trabajador.setId(idTrabajador); // Obtiene el id generado al insertar en la tabla Persona

					String sql2 = "INSERT INTO trabajador VALUES(?, ?, ?, NULL)";
					pstm2 = conn.prepareStatement(sql2);
					pstm2.setInt(1, trabajador.getId());
					pstm2.setString(2, trabajador.getFechaContratacion());
					pstm2.setDouble(3, trabajador.getSalario());

					System.out.println(pstm2);

					salida = pstm2.executeUpdate();
					conn.commit();
				}
			}

		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstm2 != null)
					pstm2.close();
				if (pstm1 != null)
					pstm1.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return salida;
	}

	@Override
	public int insertaTrabajador2(Trabajador trabajador) { // Inserta solo en la tabla Trabajador una persona ya
															// existente
		int salida = -1;

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			conn = MySql_DBConexion.getConexion();

			String sql = "INSERT INTO trabajador VALUES(?, ?, ?, NULL)";
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, trabajador.getId());
			pstm.setString(2, trabajador.getFechaContratacion());
			pstm.setDouble(3, trabajador.getSalario());

			System.out.println(pstm);

			salida = pstm.executeUpdate();

		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
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

		return salida;
	}

	@Override
	public int actualizaTrabajador(Trabajador trabajador) {
		int salida = -1;

		Connection conn = null;
		PreparedStatement pstm1 = null;
		PreparedStatement pstm2 = null;
		try {
			conn = MySql_DBConexion.getConexion();

			// Se anula el autoenvío
			conn.setAutoCommit(false);

			String sql = "UPDATE persona SET nombres = ?, apellidos = ?, dni = ?, direccion = ?, telefono = ?, "
					+ "fechaNacimiento = ? WHERE idPersona = ?";
			pstm1 = conn.prepareStatement(sql);
			pstm1.setString(1, trabajador.getNombres());
			pstm1.setString(2, trabajador.getApellidos());
			pstm1.setString(3, trabajador.getDni());
			pstm1.setString(4, trabajador.getDireccion());
			pstm1.setString(5, trabajador.getTelefono());
			pstm1.setString(6, trabajador.getFechaNacimiento());
			pstm1.setInt(7, trabajador.getId());

			System.out.println(pstm1);
			salida = pstm1.executeUpdate();

			if (salida > 0) {
				String sql2 = "UPDATE trabajador SET fechaContratacion = ?, salario  = ? WHERE idTrabajador = ?";
				pstm2 = conn.prepareStatement(sql2);
				pstm2.setString(1, trabajador.getFechaContratacion());
				pstm2.setDouble(2, trabajador.getSalario());
				pstm2.setInt(3, trabajador.getId());

				System.out.println(pstm2);

				salida = pstm2.executeUpdate();
				conn.commit();
			}

		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				if (pstm2 != null)
					pstm2.close();
				if (pstm1 != null)
					pstm1.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return salida;
	}

	@Override
	public int eliminaTrabajador(int idTrabajador) { // No eliminar, cambiar su estado a 0 (1: activo | 0: inactivo)
		int salida = -1;

		Connection conn = null;
		PreparedStatement pstm1 = null;
		PreparedStatement pstm2 = null;
		try {
			conn = MySql_DBConexion.getConexion();

			// Se anula el autoenvío
			conn.setAutoCommit(false);

			String sql = "DELETE FROM trabajador WHERE idTrabajador = ?";
			pstm1 = conn.prepareStatement(sql);
			pstm1.setInt(1, idTrabajador);

			System.out.println(pstm1);
			salida = pstm1.executeUpdate();

			if (salida > 0) {
				String sql2 = "DELETE FROM persona WHERE idPersona = ?";
				pstm2 = conn.prepareStatement(sql2);
				pstm2.setInt(1, idTrabajador);

				System.out.println(pstm2);

				salida = pstm2.executeUpdate();
				conn.commit();
			}

		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				if (pstm2 != null)
					pstm2.close();
				if (pstm1 != null)
					pstm1.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return salida;
	}

	@Override
	public List<Trabajador> consultaTrabajadorXDni(String dni) {
		List<Trabajador> data = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			conn = MySql_DBConexion.getConexion();
			String sql = "SELECT T.idTrabajador, P.nombres, P.apellidos, P.dni, P.direccion, P.telefono, P.fechaNacimiento, "
					+ "T.fechaContratacion, T.salario from trabajador T INNER JOIN persona P ON P.idPersona = T.idTrabajador "
					+ "WHERE P.dni LIKE ?";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, '%' + dni + '%');
			rs = pstm.executeQuery();

			Trabajador obj = null;
			while (rs.next()) {
				obj = new Trabajador();

				obj.setId(rs.getInt(1));
				obj.setNombres(rs.getString(2));
				obj.setApellidos(rs.getString(3));
				obj.setDni(rs.getString(4));
				obj.setDireccion(rs.getString(5));
				obj.setTelefono(rs.getString(6));
				obj.setFechaNacimiento(rs.getString(7));
				obj.setFechaContratacion(rs.getString(8));
				obj.setSalario(rs.getDouble(9));

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

	@Override
	public Trabajador obtenerTrabajadorPorID(int idTrabajador) {
		Trabajador obj = null;

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			conn = MySql_DBConexion.getConexion();
			String sql = "SELECT T.idTrabajador, P.nombres, P.apellidos, P.dni, P.direccion, P.telefono, P.fechaNacimiento, "
					+ "T.fechaContratacion, T.salario from trabajador T INNER JOIN persona P ON P.idPersona = T.idTrabajador "
					+ "WHERE T.idTrabajador = ?";
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, idTrabajador);

			rs = pstm.executeQuery();

			if (rs.next()) {
				obj = new Trabajador();

				obj.setId(rs.getInt(1));
				obj.setNombres(rs.getString(2));
				obj.setApellidos(rs.getString(3));
				obj.setDni(rs.getString(4));
				obj.setDireccion(rs.getString(5));
				obj.setTelefono(rs.getString(6));
				obj.setFechaNacimiento(rs.getString(7));
				obj.setFechaContratacion(rs.getString(8));
				obj.setSalario(rs.getDouble(9));
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

		return obj;
	}

	@Override
	public Trabajador obtenerTrabajadorPorIDUsuario(int idUsuario) {
		Trabajador obj = null;

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			conn = MySql_DBConexion.getConexion();
			String sql = "SELECT T.idTrabajador, P.nombres, P.apellidos, P.dni, P.direccion, P.telefono, P.fechaNacimiento, "
					+ "T.fechaContratacion, T.salario from trabajador T INNER JOIN persona P ON P.idPersona = T.idTrabajador "
					+ "WHERE T.idUsuario = ?";
			pstm = conn.prepareStatement(sql);
			pstm.setInt(idUsuario, 1);

			rs = pstm.executeQuery();

			if (rs.next()) {
				obj = new Trabajador();

				obj.setId(rs.getInt(1));
				obj.setNombres(rs.getString(2));
				obj.setApellidos(rs.getString(3));
				obj.setDni(rs.getString(4));
				obj.setDireccion(rs.getString(5));
				obj.setTelefono(rs.getString(6));
				obj.setFechaNacimiento(rs.getString(7));
				obj.setFechaContratacion(rs.getString(8));
				obj.setSalario(rs.getDouble(9));
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

		return obj;
	}
	
	@Override
	public List<Trabajador> consultaXFechaContratacion(String fechaInicio, String fechaFin) {
		List<Trabajador> data = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			conn = MySql_DBConexion.getConexion();
			String sql = "SELECT T.idTrabajador, P.nombres, P.apellidos, P.dni, P.direccion, P.telefono, P.fechaNacimiento, "
					+ "T.fechaContratacion, T.salario from trabajador T INNER JOIN persona P ON P.idPersona = T.idTrabajador "
					+ "WHERE T.fechaContratacion BETWEEN ? AND ?";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, fechaInicio);
			pstm.setString(2, fechaFin);
			rs = pstm.executeQuery();

			Trabajador obj = null;
			while (rs.next()) {
				obj = new Trabajador();

				obj.setId(rs.getInt(1));
				obj.setNombres(rs.getString(2));
				obj.setApellidos(rs.getString(3));
				obj.setDni(rs.getString(4));
				obj.setDireccion(rs.getString(5));
				obj.setTelefono(rs.getString(6));
				obj.setFechaNacimiento(rs.getString(7));
				obj.setFechaContratacion(rs.getString(8));
				obj.setSalario(rs.getDouble(9));

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
	
	@Override
	public List<Trabajador> consultaXFechaNacimiento(String fechaInicio, String fechaFin) {
		List<Trabajador> data = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			conn = MySql_DBConexion.getConexion();
			String sql = "SELECT T.idTrabajador, P.nombres, P.apellidos, P.dni, P.direccion, P.telefono, P.fechaNacimiento, "
					+ "T.fechaContratacion, T.salario from trabajador T INNER JOIN persona P ON P.idPersona = T.idTrabajador "
					+ "WHERE P.fechaNacimiento BETWEEN ? AND ?";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, fechaInicio);
			pstm.setString(2, fechaFin);
			rs = pstm.executeQuery();

			Trabajador obj = null;
			while (rs.next()) {
				obj = new Trabajador();

				obj.setId(rs.getInt(1));
				obj.setNombres(rs.getString(2));
				obj.setApellidos(rs.getString(3));
				obj.setDni(rs.getString(4));
				obj.setDireccion(rs.getString(5));
				obj.setTelefono(rs.getString(6));
				obj.setFechaNacimiento(rs.getString(7));
				obj.setFechaContratacion(rs.getString(8));
				obj.setSalario(rs.getDouble(9));

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
