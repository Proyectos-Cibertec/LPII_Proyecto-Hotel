package dao;

import java.util.List;

import entidad.Habitacion;

public interface HabitacionDAO {

	public abstract int insertaHabitacion(Habitacion obj) throws Exception;

	public abstract int actualizarHabitacion(Habitacion obj) throws Exception;

	public abstract int eliminaHabitacion(int idHabitacion) throws Exception;

	public abstract List<Habitacion> listarHabitacion() throws Exception;
	
	public abstract List<Habitacion> consultaHabitacion(int piso) throws Exception;
	
	public abstract Habitacion obtenerHabitacionPorID(int idHabitacion) throws Exception;
	
	public abstract List<Habitacion> buscarHabitacionXTipoCategoriaEstado(String tipo, String categoria, String estado) throws Exception;

}
