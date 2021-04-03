package dao;

import java.util.List;

import entidad.Trabajador;

public interface TrabajadorDAO {

	public abstract List<Trabajador> listaTrabajador();
	public abstract int insertaTrabajador(Trabajador trabajador);
	public abstract int insertaTrabajador2(Trabajador trabajador);
	public abstract int actualizaTrabajador(Trabajador trabajador);
	public abstract int eliminaTrabajador(int idTrabajador);
	public abstract List<Trabajador> consultaTrabajadorXDni(String dni);
	public abstract Trabajador obtenerTrabajadorPorID(int idTrabajador);
	public abstract Trabajador obtenerTrabajadorPorIDUsuario(int idUsuario);
	public abstract List<Trabajador> consultaXFechaContratacion(String fechaInicio, String fechaFin);
	public abstract List<Trabajador> consultaXFechaNacimiento(String fechaInicio, String fechaFin);
}
