package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import entidad.Hospedaje;
import entidad.HospedajeHabitacion;
import fabricas.Fabrica;
import util.MySql_DBConexion;

public class MySqlHospedajeDAO implements HospedajeDAO {

	private Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
	private ClienteDAO daoCliente = fabrica.getClienteDAO();
	private TrabajadorDAO daoTrabajador = fabrica.getTrabajadorDAO();
	
	@Override
	/*
	 * public int insertaHospedaje(Hospedaje hospedaje, List<HospedajeHabitacion>
	 * detalle1, List<HospedajeHabitacionHuesped> detalle2) { int salida = -1;
	 * 
	 * Connection conn = null; PreparedStatement pstm1 = null; PreparedStatement
	 * pstm2 = null; PreparedStatement pstm3 = null; ResultSet rs = null; try { conn
	 * = MysqlDBConexion.getConexion();
	 * 
	 * // Se anula el autoenvío conn.setAutoCommit(false);
	 * 
	 * String sql = "INSERT INTO hospedaje VALUE(null, ?, ?, ?, ?, ?, ?, ?)"; //
	 * CURDATE() pstm1 = conn.prepareStatement(sql,
	 * Statement.RETURN_GENERATED_KEYS); pstm1.setString(1,
	 * hospedaje.getFechaIngreso()); pstm1.setString(2, hospedaje.getFechaSalida());
	 * pstm1.setDouble(3, hospedaje.getIgv()); pstm1.setInt(4,
	 * hospedaje.getEstado()); pstm1.setInt(5,
	 * hospedaje.getReserva().getIdReserva()); pstm1.setInt(6,
	 * hospedaje.getCliente().getId()); pstm1.setInt(7,
	 * hospedaje.getTrabajador().getId());
	 * 
	 * System.out.println(pstm1); salida = pstm1.executeUpdate();
	 * 
	 * if (salida > 0) { // Obtiene el id insertado en la tabla Hospedaje int
	 * idHospedaje; rs = pstm1.getGeneratedKeys();
	 * 
	 * if (rs.next()) { idHospedaje = rs.getInt(1); // Insertar en las tablas
	 * detalle String sql2 = "INSERT INTO hospedaje_habitacion VALUES(?, ?, ?)";
	 * pstm2 = conn.prepareStatement(sql2); for (HospedajeHabitacion detalle :
	 * detalle1) { pstm2.setInt(1, idHospedaje); pstm2.setInt(2,
	 * detalle.getIdHabitacion()); pstm2.setDouble(3, detalle.getCosto());
	 * 
	 * System.out.println(pstm2); pstm2.executeUpdate();
	 * 
	 * }
	 * 
	 * String sql3 = "INSERT INTO hospedaje_habitacion_huesped VALUES(?, ?, ?)";
	 * pstm3 = conn.prepareStatement(sql3); for (HospedajeHabitacionHuesped detalle
	 * : detalle2) { pstm3.setInt(1, idHospedaje); pstm3.setInt(2,
	 * detalle.getIdHabitacion()); pstm3.setInt(3, detalle.getIdHabitacion());
	 * 
	 * System.out.println(pstm3); pstm2.executeUpdate(); }
	 * 
	 * conn.commit(); } }
	 * 
	 * } catch (Exception e) { try { conn.rollback(); } catch (Exception e2) {
	 * e2.printStackTrace(); } e.printStackTrace();
	 * 
	 * } finally { try { if (rs != null) rs.close(); if (pstm3 != null)
	 * pstm3.close(); if (pstm2 != null) pstm2.close(); if (pstm1 != null)
	 * pstm1.close(); if (conn != null) conn.close(); } catch (Exception e2) {
	 * e2.printStackTrace(); } }
	 * 
	 * return salida; }
	 */

	public int insertaHospedaje(Hospedaje hospedaje, List<HospedajeHabitacion> detalle1) {
		int salida = -1;

		Connection conn = null;
		PreparedStatement pstm1 = null;
		PreparedStatement pstm2 = null;
		PreparedStatement pstm3 = null;
		PreparedStatement pstm4 = null;
		ResultSet rs = null;
		try {
			conn = MySql_DBConexion.getConexion();

			// Se anula el autoenvío
			conn.setAutoCommit(false);

			String sql = "INSERT INTO hospedaje VALUE(null, ?, ?, ?, NULL, NULL, ?, ?)"; // CURDATE()
			pstm1 = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			pstm1.setString(1, hospedaje.getFechaIngreso());
			pstm1.setString(2, hospedaje.getFechaSalida());
			pstm1.setDouble(3, hospedaje.getIgv());
			// pstm1.setInt(4, hospedaje.getEstado());
			// pstm1.setInt(5, hospedaje.getReserva().getIdReserva());
			pstm1.setInt(4, hospedaje.getCliente().getId());
			pstm1.setInt(5, hospedaje.getTrabajador().getId());
			// pstm1.setInt(7, hospedaje.getTrabajador().getId());

			System.out.println(pstm1);
			salida = pstm1.executeUpdate();

			if (salida > 0) {
				// Obtiene el id insertado en la tabla Hospedaje
				int idHospedaje;
				rs = pstm1.getGeneratedKeys();

				if (rs.next()) {

					// Insertar en las tablas detalle: Hospedaje_Habitacion
					idHospedaje = rs.getInt(1);
					String sql2 = "INSERT INTO hospedaje_habitacion VALUES(?, ?, ?)";
					pstm2 = conn.prepareStatement(sql2);

					// Se actualiza el estado de las Habitaciones a Ocupada
					String sql3 = "UPDATE habitacion SET idEstado = 4 WHERE idHabitacion = ?";
					pstm3 = conn.prepareStatement(sql3);

					for (HospedajeHabitacion detalle : detalle1) {
						pstm2.setInt(1, idHospedaje);
						pstm2.setInt(2, detalle.getIdHabitacion());
						pstm2.setDouble(3, detalle.getCosto());
						pstm2.executeUpdate();

						pstm3.setInt(1, detalle.getIdHabitacion());
						System.out.println(pstm3);
						pstm3.executeUpdate();
					}
					
					
					/*String sql4 = "INSERT INTO hospedaje_habitacion_huesped VALUES(?, ?, ?)";
					pstm4 = conn.prepareStatement(sql4);
					for (HospedajeHabitacionHuesped detalle : detalle2) {
						pstm4.setInt(1, idHospedaje);
						pstm4.setInt(2, detalle.getIdHabitacion());
						pstm4.setInt(3, detalle.getIdHuesped());

						System.out.println(pstm4);
						pstm4.executeUpdate();
					}*/

					conn.commit();
				}
			}

		} catch (Exception e) {
			try {
				conn.rollback(); // No permite un SQL a medias
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();

		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstm4 != null)
					pstm4.close();
				if (pstm3 != null)
					pstm3.close();
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
	
	public List<Hospedaje> consultaPorFecha(String fechaInicial, String fechaFinal) {
		List<Hospedaje> hospedajes = new ArrayList<>();
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;

		try {
			conn = MySql_DBConexion.getConexion();
			String sentenciaSQL	= "SELECT H.* FROM hospedaje H WHERE H.fechaIngreso BETWEEN ? AND ?";
			pstm = conn.prepareStatement(sentenciaSQL);
			pstm.setString(1, fechaInicial);
			pstm.setString(2, fechaFinal);

			// Se obtiene el resultado de la base de datos
			rs = pstm.executeQuery();

			// Se recorre el resultado y se almacena en el ArrayList
			Hospedaje hospedaje = null;
			
			while (rs.next()) {
				hospedaje = new Hospedaje();
				
				hospedaje.setIdHospedaje(rs.getInt("idHospedaje"));
				hospedaje.setFechaIngreso(rs.getString("fechaIngreso"));
				hospedaje.setFechaSalida(rs.getString("fechaSalida"));
				hospedaje.setIgv(rs.getDouble("igv"));
				hospedaje.setCliente(daoCliente.obtenerClientePorID(rs.getInt("idCliente")));
				hospedaje.setTrabajador(daoTrabajador.obtenerTrabajadorPorID(rs.getInt("idTrabajador")));
				
				hospedajes.add(hospedaje);
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			// Se cierran las conexiones
			try {
				if (rs != null)
					rs.close();
				if (pstm != null)
					pstm.close();
				if (conn!= null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return hospedajes;
	}
	
	public List<HospedajeHabitacion> listarDetalleHospedaje(int idHospedaje) {
		List<HospedajeHabitacion> detalles = new ArrayList<>();
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;

		try {
			conn = MySql_DBConexion.getConexion();
			String sentenciaSQL	= "SELECT HH.* FROM hospedaje_habitacion HH WHERE HH.idHospedaje = ?";
			pstm = conn.prepareStatement(sentenciaSQL);
			pstm.setInt(1, idHospedaje);

			System.out.println(pstm);
			// Se obtiene el resultado de la base de datos
			rs = pstm.executeQuery();

			// Se recorre el resultado y se almacena en el ArrayList
			HospedajeHabitacion detalle = null;
			
			while (rs.next()) {
				detalle = new HospedajeHabitacion();
				
				detalle.setIdHospedaje(rs.getInt("idHospedaje"));
				detalle.setIdHabitacion(rs.getInt("idHabitacion"));
				detalle.setCosto(rs.getDouble("costo"));
				
				System.out.println(detalle.getIdHabitacion());
				
				detalles.add(detalle);
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			// Se cierran las conexiones
			try {
				if (rs != null)
					rs.close();
				if (pstm != null)
					pstm.close();
				if (conn!= null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return detalles;
	}
}
