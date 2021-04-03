package dao;

import java.util.List;

import entidad.Enlace;
import entidad.Usuario;

public interface UsuarioDAO {
	public abstract Usuario login(Usuario usuario) throws Exception;
	public abstract List<Enlace> traerEnlacesDeUsuario(int idUsuario) throws Exception;
}
