package dao;

import java.util.List;

import entidad.Equipamiento;

public interface EquipamientoDAO {
	public abstract List<Equipamiento> listaEquipamiento();
	public abstract Equipamiento obtenerEquipamientoPorID(int idEquipamiento);
	public abstract List<Equipamiento> consultaEquipamiento(String filtro);
	public abstract int insertaEquipamiento(Equipamiento equipamiento);
	public abstract int actualizaEquipamiento(Equipamiento equipamiento);
	public abstract int eliminaEquipamiento(int idEquipamiento);
}
