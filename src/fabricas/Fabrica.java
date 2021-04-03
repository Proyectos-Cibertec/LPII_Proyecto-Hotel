package fabricas;

import dao.ClienteDAO;
import dao.EquipamientoDAO;
import dao.HabitacionDAO;
import dao.HospedajeDAO;
import dao.PersonaDAO;
import dao.ProductoDAO;
import dao.TrabajadorDAO;
import dao.UsuarioDAO;

public abstract class Fabrica {
	public static final int MYSQL = 1;
	public static final int SQLSERVER = 2;
	public static final int ORACLE = 3;

	// Se inscribe el DAO a las Fábricas
	public abstract PersonaDAO getPersonaDAO();
	public abstract ClienteDAO getClienteDAO();
	public abstract TrabajadorDAO getTrabajadorDAO();
	public abstract HospedajeDAO getHospedajeDAO();
	public abstract EquipamientoDAO getEquipamientoDAO();
	public abstract HabitacionDAO getHabitacionDAO();
	public abstract ProductoDAO getProductoDAO();
	public abstract UsuarioDAO getUsuarioDAO();
	

	// Fabrica subfábricas (MySQL, SQLServer)
	public static Fabrica getFabrica(int tipo) {
		Fabrica salida = null;

		switch (tipo) {
			case MYSQL:
				salida = new FabricaMySql();
				break;
	
			case SQLSERVER:
				salida = new FabricaSqlServer();
				break;
		}

		return salida;
	}
}
