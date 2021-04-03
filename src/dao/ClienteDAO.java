package dao;

import java.util.List;

import entidad.Cliente;

public interface ClienteDAO {

	public abstract List<Cliente> listaCliente();
	public abstract int insertaCliente(Cliente cliente);
	public abstract int insertaCliente2(Cliente cliente);
	public abstract int actualizaCliente(Cliente cliente);
	public abstract int eliminaCliente(int idCliente);
	public abstract List<Cliente> consultaClienteXDni(String dni);
	public abstract List<Cliente> buscarClienteXApellido(String apellidos);
	public abstract Cliente obtenerClientePorID(int idCliente);
	public abstract List<Cliente> consultaXFechaNacimiento(String fechaInicio, String fechaFin);
}
