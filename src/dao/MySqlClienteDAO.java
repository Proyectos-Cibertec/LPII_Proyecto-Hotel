package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import entidad.Cliente;
import util.MySql_DBConexion;

public class MySqlClienteDAO implements ClienteDAO {

	@Override
	public List<Cliente> listaCliente() {
		List<Cliente> data = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			conn = MySql_DBConexion.getConexion();
			String sql = "SELECT C.idCliente, P.nombres, P.apellidos, P.dni, P.direccion, P.telefono, P.fechaNacimiento, "
					+ "C.fechaRegistro from cliente C INNER JOIN persona P ON P.idPersona = C.idCliente";
			pstm = conn.prepareStatement(sql);
			rs = pstm.executeQuery();

			Cliente obj = null;
			while (rs.next()) {
				obj = new Cliente();

				obj.setId(rs.getInt(1));
				obj.setNombres(rs.getString(2));
				obj.setApellidos(rs.getString(3));
				obj.setDni(rs.getString(4));
				obj.setDireccion(rs.getString(5));
				obj.setTelefono(rs.getString(6));
				obj.setFechaNacimiento(rs.getString(7));
				obj.setFechaRegistro(rs.getString(8));

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
	public int insertaCliente(Cliente cliente) { // Inserta en dos tablas: Persona, Cliente
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
			pstm1.setString(1, cliente.getNombres());
			pstm1.setString(2, cliente.getApellidos());
			pstm1.setString(3, cliente.getDni());
			pstm1.setString(4, cliente.getDireccion());
			pstm1.setString(5, cliente.getTelefono());
			pstm1.setString(6, cliente.getFechaNacimiento());

			System.out.println(pstm1);
			salida = pstm1.executeUpdate();

			if (salida > 0) {
				// Se inserta en la tabla cliente

				// Obtiene el último id insertado en la tabla persona
				int idCliente;
				rs = pstm1.getGeneratedKeys();

				if (rs.next()) {
					idCliente = rs.getInt(1);
					cliente.setId(idCliente); // Obtiene el id generado al insertar en la tabla Persona
					
					System.out.println("ID GENERADOR: " + idCliente);

					String sql2 = "INSERT INTO cliente VALUES(?, ?, NULL)";
					pstm2 = conn.prepareStatement(sql2);
					pstm2.setInt(1, cliente.getId());
					pstm2.setString(2, cliente.getFechaRegistro());

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
	public int insertaCliente2(Cliente cliente) { // Inserta solo en la tabla Cliente una persona ya existente en la tabla Empleado
		int salida = -1;

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			conn = MySql_DBConexion.getConexion();

			String sql = "INSERT INTO cliente VALUES(?, ?, NULL)";
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, cliente.getId());
			pstm.setString(2, cliente.getFechaRegistro());

			System.out.println(pstm);
			salida = pstm.executeUpdate();

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

		return salida;
	}

	@Override
	public int actualizaCliente(Cliente cliente) {
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
			pstm1.setString(1, cliente.getNombres());
			pstm1.setString(2, cliente.getApellidos());
			pstm1.setString(3, cliente.getDni());
			pstm1.setString(4, cliente.getDireccion());
			pstm1.setString(5, cliente.getTelefono());
			pstm1.setString(6, cliente.getFechaNacimiento());
			pstm1.setInt(7, cliente.getId());

			System.out.println(pstm1);
			salida = pstm1.executeUpdate();

			if (salida > 0) {
				String sql2 = "UPDATE cliente SET fechaRegistro = ? WHERE idCliente = ?";
				pstm2 = conn.prepareStatement(sql2);
				pstm2.setString(1, cliente.getFechaRegistro());
				pstm2.setInt(2, cliente.getId());

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
	public int eliminaCliente(int idCliente) { // No eliminar, cambiar su estado a 0 (1: activo | 0: inactivo)
		int salida = -1;

		Connection conn = null;
		PreparedStatement pstm1 = null;
		PreparedStatement pstm2 = null;
		try {
			conn = MySql_DBConexion.getConexion();

			// Se anula el autoenvío
			conn.setAutoCommit(false);

			String sql = "DELETE FROM cliente WHERE idCliente = ?";
			pstm1 = conn.prepareStatement(sql);
			pstm1.setInt(1, idCliente);

			System.out.println(pstm1);
			salida = pstm1.executeUpdate();

			if (salida > 0) {
				String sql2 = "DELETE FROM persona WHERE idPersona = ?";
				pstm2 = conn.prepareStatement(sql2);
				pstm2.setInt(1, idCliente);

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
	public List<Cliente> consultaClienteXDni(String dni) { // Dni
		List<Cliente> data = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			conn = MySql_DBConexion.getConexion();
			String sql = "SELECT C.idCliente, P.nombres, P.apellidos, P.dni, P.direccion, P.telefono, P.fechaNacimiento, "
					+ "C.fechaRegistro from cliente C INNER JOIN persona P ON P.idPersona = C.idCliente "
					+ "WHERE P.dni LIKE ?";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, '%' + dni + '%');
			rs = pstm.executeQuery();

			Cliente obj = null;
			while (rs.next()) {
				obj = new Cliente();

				obj.setId(rs.getInt(1));
				obj.setNombres(rs.getString(2));
				obj.setApellidos(rs.getString(3));
				obj.setDni(rs.getString(4));
				obj.setDireccion(rs.getString(5));
				obj.setTelefono(rs.getString(6));
				obj.setFechaNacimiento(rs.getString(7));
				obj.setFechaRegistro(rs.getString(8));

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
	public List<Cliente> consultaXFechaNacimiento(String fechaInicio, String fechaFin) {
		List<Cliente> data = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			conn = MySql_DBConexion.getConexion();
			String sql = "SELECT C.idCliente, P.nombres, P.apellidos, P.dni, P.direccion, P.telefono, P.fechaNacimiento, "
					+ "C.fechaRegistro from cliente C INNER JOIN persona P ON P.idPersona = C.idCliente "
					+ "WHERE P.fechaNacimiento BETWEEN ? AND ?";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, fechaInicio);
			pstm.setString(2, fechaFin);
			rs = pstm.executeQuery();

			Cliente obj = null;
			while (rs.next()) {
				obj = new Cliente();

				obj.setId(rs.getInt(1));
				obj.setNombres(rs.getString(2));
				obj.setApellidos(rs.getString(3));
				obj.setDni(rs.getString(4));
				obj.setDireccion(rs.getString(5));
				obj.setTelefono(rs.getString(6));
				obj.setFechaNacimiento(rs.getString(7));
				obj.setFechaRegistro(rs.getString(8));

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
	public Cliente obtenerClientePorID(int idCliente) {
		Cliente obj = null;

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			conn = MySql_DBConexion.getConexion();
			String sql = "SELECT C.idCliente, P.nombres, P.apellidos, P.dni, P.direccion, P.telefono, P.fechaNacimiento, "
					+ "C.fechaRegistro from cliente C INNER JOIN persona P ON P.idPersona = C.idCliente "
					+ "WHERE C.idCliente = ?";
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, idCliente);

			rs = pstm.executeQuery();

			if (rs.next()) {
				System.out.println("Cliente encontrado con id: " + idCliente);
				obj = new Cliente();

				obj.setId(rs.getInt(1));
				obj.setNombres(rs.getString(2));
				obj.setApellidos(rs.getString(3));
				obj.setDni(rs.getString(4));
				obj.setDireccion(rs.getString(5));
				obj.setTelefono(rs.getString(6));
				obj.setFechaNacimiento(rs.getString(7));
				obj.setFechaRegistro(rs.getString(8));
			} else {
				System.out.println("No encontró ningún cliente con ID = " + idCliente);
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
	public List<Cliente> buscarClienteXApellido(String apellidos) {
		List<Cliente> data = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			conn = MySql_DBConexion.getConexion();
			String sql = "SELECT C.idCliente, P.nombres, P.apellidos, P.dni, P.direccion, P.telefono, P.fechaNacimiento, "
					+ "C.fechaRegistro from cliente C INNER JOIN persona P ON P.idPersona = C.idCliente "
					+ "WHERE P.apellidos LIKE ?";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, '%' + apellidos + '%');
			rs = pstm.executeQuery();

			Cliente obj = null;
			while (rs.next()) {
				obj = new Cliente();

				obj.setId(rs.getInt(1));
				obj.setNombres(rs.getString(2));
				obj.setApellidos(rs.getString(3));
				obj.setDni(rs.getString(4));
				obj.setDireccion(rs.getString(5));
				obj.setTelefono(rs.getString(6));
				obj.setFechaNacimiento(rs.getString(7));
				obj.setFechaRegistro(rs.getString(8));

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
