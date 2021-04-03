package entidad;

public class Habitacion {

	public int idHabitacion;
	public int numero;
	public int piso;
	public Tipo_Habitacion tipo;
	public Categoria_Habitacion categoria;
	public Estado_Habitacion estado;
	public double costo;

	public int getIdHabitacion() {
		return idHabitacion;
	}

	public void setIdHabitacion(int idHabitacion) {
		this.idHabitacion = idHabitacion;
	}

	public int getNumero() {
		return numero;
	}

	public void setNumero(int numero) {
		this.numero = numero;
	}

	public int getPiso() {
		return piso;
	}

	public void setPiso(int piso) {
		this.piso = piso;
	}

	public Tipo_Habitacion getTipo() {
		return tipo;
	}

	public void setTipo(Tipo_Habitacion tipo) {
		this.tipo = tipo;
	}

	public Categoria_Habitacion getCategoria() {
		return categoria;
	}

	public void setCategoria(Categoria_Habitacion categoria) {
		this.categoria = categoria;
	}

	public Estado_Habitacion getEstado() {
		return estado;
	}

	public void setEstado(Estado_Habitacion estado) {
		this.estado = estado;
	}

	public double getCosto() {
		return costo;
	}

	public void setCosto(double costo) {
		this.costo = costo;
	}

}
