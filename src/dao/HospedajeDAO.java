package dao;

import java.util.List;

import entidad.Hospedaje;
import entidad.HospedajeHabitacion;

public interface HospedajeDAO {
	// public abstract int insertaHospedaje(Hospedaje hospedaje,
	// List<HospedajeHabitacion> detalle1, List<HospedajeHabitacionHuesped>
	// detalle2);

	public abstract int insertaHospedaje(Hospedaje hospedaje, List<HospedajeHabitacion> detalle1);
	public abstract List<Hospedaje> consultaPorFecha(String fechaInicial, String fechaFinal);
	public abstract List<HospedajeHabitacion> listarDetalleHospedaje(int idHospedaje);
	// detalle2);
}
