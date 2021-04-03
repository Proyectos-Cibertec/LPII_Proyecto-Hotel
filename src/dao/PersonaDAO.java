package dao;

import java.util.List;

import entidad.Persona;

public interface PersonaDAO {
	public abstract List<Persona> consultaXDni(String dni);
}
