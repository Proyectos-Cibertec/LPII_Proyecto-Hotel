package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import dao.ClienteDAO;
import dao.HabitacionDAO;
import dao.HospedajeDAO;
import entidad.Categoria_Habitacion;
import entidad.Cliente;
import entidad.Habitacion;
import entidad.Hospedaje;
import entidad.HospedajeHabitacion;
import entidad.Tipo_Habitacion;
import entidad.Trabajador;
import fabricas.Fabrica;

/**
 * Servlet implementation class ServletHospedaje
 */
@WebServlet("/hospedaje")
public class ServletHospedaje extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Log log = LogFactory.getLog(ServletHospedaje.class);
	List<Hospedaje> hospedajes = new ArrayList<>();

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String metodo = request.getParameter("metodo");

		switch (metodo) {
		case "agregarSeleccion":
			agregarSeleccion(request, response);
			break;

		case "eliminarSeleccion":
			eliminarSeleccion(request, response);
			break;

		case "registrarHospedaje":
			registrarHospedaje(request, response);
			break;

		case "consultaPorFecha":
			consultaPorFecha(request, response);
			break;

		
		
		case "obtenerDetalleHospedaje":
			obtenerDetalleHospedaje(request, response);
			break;
		}
	}
	
	protected void obtenerDetalleHospedaje(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String idHospedaje = request.getParameter("idHospedaje");

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			HospedajeDAO dao = fabrica.getHospedajeDAO();
			HabitacionDAO daoHabitacion = fabrica.getHabitacionDAO();
			List<HospedajeHabitacion> detalles = dao.listarDetalleHospedaje(Integer.parseInt(idHospedaje));
			
			log.info("Obtener detalle Hospedaje");

			JsonArrayBuilder array = Json.createArrayBuilder();
			Habitacion habitacion = null;
			
			for (HospedajeHabitacion detalle : detalles) {
				
				log.info(detalle.getIdHabitacion());
				
				habitacion = daoHabitacion.obtenerHabitacionPorID(detalle.getIdHabitacion());
				
				JsonObject item = Json.createObjectBuilder().
						add("idHospedaje", detalle.getIdHospedaje())
						.add("idHabitacion", habitacion.getIdHabitacion())
						.add("costo", detalle.getCosto())
						.add("tipo", habitacion.getTipo().getDescripcion())
						.add("categoria", habitacion.getCategoria().getDescripcion())
						.add("numero", habitacion.getNumero())
						.add("piso", habitacion.getPiso()).build();

				array.add(item);
			}

			response.setContentType("application/json;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print(array.build());

		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	protected void consultaPorFecha(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.info("En consultaHospedaje por fecha");
		try {
			String fechaInicial = request.getParameter("fechaInicial");
			String fechaFinal = request.getParameter("fechaFinal");

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			HospedajeDAO dao = fabrica.getHospedajeDAO();

			hospedajes = dao.consultaPorFecha(fechaInicial, fechaFinal);
		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("hospedajes", hospedajes);
		request.getRequestDispatcher("/ConsultaHospedajesPorFechaIngreso.jsp").forward(request, response);

	}

	@SuppressWarnings("unchecked")
	protected void registrarHospedaje(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.info("En registra registrarHospedaje");

		HttpSession session = request.getSession();
		ArrayList<Habitacion> habitaciones = (ArrayList<Habitacion>) session.getAttribute("dataDeGrillaHabitaciones");
		Trabajador trabajador = (Trabajador) session.getAttribute("objTrabajador");

		String idClienteStr = request.getParameter("idCliente");
		String fechaIngreso = request.getParameter("fechaIngreso");
		String fechaSalida = request.getParameter("fechaSalida");
		String cantidadDiasStr = request.getParameter("cantidadDias");
		String igv = request.getParameter("igv");

		int idCliente = Integer.parseInt(idClienteStr);
		int cantidadDias = Integer.parseInt(cantidadDiasStr);

		// Cantidad de días

		// Creamos el Hospedaje
		Hospedaje hospedaje = new Hospedaje();
		hospedaje.setFechaIngreso(fechaIngreso);
		hospedaje.setFechaSalida(fechaSalida);
		hospedaje.setIgv(Double.parseDouble(igv));

		Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
		ClienteDAO clienteDao = fabrica.getClienteDAO();
		Cliente cliente = clienteDao.obtenerClientePorID(idCliente);
		hospedaje.setCliente(cliente);
		hospedaje.setTrabajador(trabajador);

		// Creamos el detalle
		ArrayList<HospedajeHabitacion> detalles = new ArrayList<HospedajeHabitacion>();
		for (Habitacion habitacion : habitaciones) {
			HospedajeHabitacion detalle = new HospedajeHabitacion();
			detalle.setIdHabitacion(habitacion.getIdHabitacion());
			detalle.setCosto(habitacion.getCosto() * cantidadDias); // Costo total de la Habitación por los días que se
																	// va a quedar hospedado
			detalles.add(detalle);
		}

		// Se inserta la boleta
		Fabrica mysql = Fabrica.getFabrica(Fabrica.MYSQL);
		HospedajeDAO dao = mysql.getHospedajeDAO();

		dao.insertaHospedaje(hospedaje, detalles);

		// limpiamos la sesion
		session.removeAttribute("dataDeGrillaHabitaciones");

		// reenvio
		request.getRequestDispatcher("/RegistroHospedaje.jsp").forward(request, response);
	}

	@SuppressWarnings("unchecked")
	protected void agregarSeleccion(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		log.info("En agegarSeleccion");

		// String numeroDias = request.getParameter("cantidadDias");
		String codigoHabitacion = request.getParameter("codigoHabitacion");
		String numeroHabitacion = request.getParameter("numeroHabitacion");
		String pisoHabitacion = request.getParameter("pisoHabitacion");
		String idTipoHabitacion = request.getParameter("idTipoHabitacion");
		String tipoHabitacion = request.getParameter("tipoHabitacion");
		String idCategoriaHabitacion = request.getParameter("idCategoriaHabitacion");
		String categoriaHabitacion = request.getParameter("categoriaHabitacion");
		String costoHabitacion = request.getParameter("costoHabitacion");

		List<Habitacion> habitaciones = null;

		// Se verifica si existe en sesion
		HttpSession session = request.getSession();
		if (session.getAttribute("dataDeGrillaHabitaciones") == null) {
			habitaciones = new ArrayList<Habitacion>();
		} else {
			habitaciones = (ArrayList<Habitacion>) session.getAttribute("dataDeGrillaHabitaciones");
		}

		// Se crear el objeto
		Habitacion habitacion = new Habitacion();
		habitacion.setIdHabitacion(Integer.parseInt(codigoHabitacion));
		habitacion.setNumero(Integer.parseInt(numeroHabitacion));
		habitacion.setPiso(Integer.parseInt(pisoHabitacion));

		Tipo_Habitacion tipo_Habitacion = new Tipo_Habitacion();
		tipo_Habitacion.setIdTipo(Integer.parseInt(idTipoHabitacion));
		tipo_Habitacion.setDescripcion(tipoHabitacion);
		habitacion.setTipo(tipo_Habitacion);

		Categoria_Habitacion categoria_Habitacion = new Categoria_Habitacion();
		categoria_Habitacion.setIdCategoria(Integer.parseInt(idCategoriaHabitacion));
		categoria_Habitacion.setDescripcion(categoriaHabitacion);
		habitacion.setCategoria(categoria_Habitacion);

		habitacion.setCosto(Double.parseDouble(costoHabitacion));

		boolean noExiste = true;
		// Se verifica los repetidos
		for (int i = 0; i < habitaciones.size(); i++) {
			if (habitaciones.get(i).getIdHabitacion() == Integer.parseInt(codigoHabitacion)) {
				habitaciones.set(i, habitacion);
				noExiste = false;
				break;
			}
		}

		// Si no existe se agrega
		if (noExiste) {
			habitaciones.add(habitacion);
		}

		// La lista se agrega a sesion
		session.setAttribute("dataDeGrillaHabitaciones", habitaciones);
		request.getRequestDispatcher("/RegistroHospedaje.jsp").forward(request, response);

	}

	@SuppressWarnings("unchecked")
	protected void eliminarSeleccion(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		log.info("En eliminar selección");

		String idHabitacion = request.getParameter("idEliminaHabitacion");

		HttpSession session = request.getSession();
		ArrayList<Habitacion> habitaciones = (ArrayList<Habitacion>) session.getAttribute("dataDeGrillaHabitaciones");

		// Se elimina
		for (Habitacion habitacion : habitaciones) {
			if (habitacion.getIdHabitacion() == Integer.parseInt(idHabitacion)) {
				habitaciones.remove(habitacion);
				break;
			}
		}

		session.setAttribute("dataDeGrillaHabitaciones", habitaciones);
		request.getRequestDispatcher("/RegistroHospedaje.jsp").forward(request, response);
	}

}
