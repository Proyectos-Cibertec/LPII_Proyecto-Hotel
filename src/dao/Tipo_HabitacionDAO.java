package dao;

import java.util.List;

import entidad.Tipo_Habitacion;

// Se le ponga o no, ya son abstractos
public interface Tipo_HabitacionDAO {
	public abstract List<Tipo_Habitacion> listaTipoHabitacion();
}
