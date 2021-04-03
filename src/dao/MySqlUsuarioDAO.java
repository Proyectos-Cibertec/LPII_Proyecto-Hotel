package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import entidad.Enlace;
import entidad.Usuario;
import util.MySql_DBConexion;

public class MySqlUsuarioDAO implements UsuarioDAO {
	private static final Log log = LogFactory.getLog(MySqlUsuarioDAO.class);

	@Override
	public Usuario login(Usuario usuario) throws Exception {
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		Usuario obj = null;
		try {
			conn = MySql_DBConexion.getConexion();
			String sql = "SELECT * FROM usuario WHERE usuario = ? AND password = ?";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, usuario.getUsuario());
			pstm.setString(2, usuario.getPassword());

			log.info(pstm);

			rs = pstm.executeQuery();
			while (rs.next()) {
				obj = new Usuario();
				obj.setIdUsuario(rs.getInt(1));
				obj.setUsuario(rs.getString(2));
				obj.setPassword(rs.getString(3));
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
			}
		}

		return obj;
	}

	@Override
	public List<Enlace> traerEnlacesDeUsuario(int idUsuario) throws Exception {
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		ArrayList<Enlace> data = new ArrayList<Enlace>();
		Enlace obj = null;

		try {
			conn = MySql_DBConexion.getConexion();
			String sql = "SELECT DISTINCT r.idEnlace, r.descripcion, r.ruta FROM enlace r, ROL_ENLACE p, ROL t, USUARIO_ROL q WHERE r.idEnlace = p.idEnlace AND	p.idRol = t.idRol AND t.idRol = q.idRol AND	q.idUsuario = ? ORDER BY 2";
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, idUsuario);

			System.out.println(pstm);

			rs = pstm.executeQuery();
			while (rs.next()) {
				obj = new Enlace();
				obj.setIdEnlace(rs.getInt(1));
				obj.setDescripcion(rs.getString(2));
				obj.setRuta(rs.getString(3));
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
			}
		}

		return data;
	}
}
