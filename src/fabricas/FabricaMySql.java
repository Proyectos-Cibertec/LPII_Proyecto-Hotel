package fabricas;

import dao.ClienteDAO;
import dao.EquipamientoDAO;
import dao.HabitacionDAO;
import dao.HospedajeDAO;
import dao.MySqlClienteDAO;
import dao.MySqlEquipamientoDAO;
import dao.MySqlHabitacionDAO;
import dao.MySqlHospedajeDAO;
import dao.MySqlPersonaDAO;
import dao.MySqlProductoDAO;
import dao.MySqlTrabajadorDAO;
import dao.MySqlUsuarioDAO;
import dao.PersonaDAO;
import dao.ProductoDAO;
import dao.TrabajadorDAO;
import dao.UsuarioDAO;

public class FabricaMySql extends Fabrica {

	@Override
	public ClienteDAO getClienteDAO() {
		return new MySqlClienteDAO();
	}

	@Override
	public TrabajadorDAO getTrabajadorDAO() {
		return new MySqlTrabajadorDAO();
	}

	@Override
	public HospedajeDAO getHospedajeDAO() {
		return new MySqlHospedajeDAO();
	}

	@Override
	public EquipamientoDAO getEquipamientoDAO() {
		return new MySqlEquipamientoDAO();
	}

	@Override
	public HabitacionDAO getHabitacionDAO() {
		// TODO Auto-generated method stub
		return new MySqlHabitacionDAO();
	}

	@Override
	public PersonaDAO getPersonaDAO() {
		return new MySqlPersonaDAO();
	}

	@Override
	public ProductoDAO getProductoDAO() {
		return new MySqlProductoDAO();
	}

	@Override
	public UsuarioDAO getUsuarioDAO() {
		// TODO Auto-generated method stub
		return new MySqlUsuarioDAO();
	}

}
