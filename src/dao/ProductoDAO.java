package dao;

import java.util.List;

import entidad.Producto;

public interface ProductoDAO {

	public abstract int insertaProducto(Producto obj) throws Exception;

	public abstract int actualizaProducto(Producto obj) throws Exception;

	public abstract int eliminaProducto(int idHabitacion) throws Exception;

	public abstract List<Producto> listaProducto() throws Exception;
	
	public abstract List<Producto> consultaProducto(String descripcion) throws Exception;
	
	public abstract List<Producto> buscaProductoXDescripcion(String descripcion) throws Exception;

}
