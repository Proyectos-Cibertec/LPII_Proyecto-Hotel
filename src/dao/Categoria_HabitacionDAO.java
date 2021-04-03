package dao;

import java.util.List;

import entidad.Categoria_Habitacion;

// Se le ponga o no, ya son abstractos
public interface Categoria_HabitacionDAO {
	public abstract List<Categoria_Habitacion> listaCategoriaHabitacion();
}
