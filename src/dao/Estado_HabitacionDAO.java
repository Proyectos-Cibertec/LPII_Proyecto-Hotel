package dao;

import java.util.List;

import entidad.Estado_Habitacion;

// Se le ponga o no, ya son abstractos
public interface Estado_HabitacionDAO {
	public abstract List<Estado_Habitacion> listaEstadoHabitacion();
}
