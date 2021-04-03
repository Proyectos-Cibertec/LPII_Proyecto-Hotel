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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import dao.HabitacionDAO;
import entidad.Categoria_Habitacion;
import entidad.Estado_Habitacion;
import entidad.Habitacion;
import entidad.Tipo_Habitacion;
import fabricas.Fabrica;

@WebServlet("/habitacion")
public class ServletHabitacion extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final Log log = LogFactory.getLog(ServletHabitacion.class);

	private List<Habitacion> habitaciones = new ArrayList<Habitacion>();
	private String filtro = "";

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String metodo = request.getParameter("metodo");

		switch (metodo) {
		case "registra":
			registra(request, response);
			break;

		case "elimina":
			elimina(request, response);
			break;

		case "actualiza":
			actualiza(request, response);
			break;

		case "consulta":
			consulta(request, response);
			break;
			
		case "buscarHabitacionXTipoCategoriaEstado":
			buscarHabitacionXTipoCategoriaEstado(request, response);
			break;
		}
	}
	
	protected void buscarHabitacionXTipoCategoriaEstado(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String tipo = request.getParameter("tipo");
			String categoria = request.getParameter("categoria");
			String estado = request.getParameter("estado");

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			HabitacionDAO dao = fabrica.getHabitacionDAO();
			habitaciones = dao.buscarHabitacionXTipoCategoriaEstado(tipo, categoria, estado);
			
			log.info("Tipo: " + tipo + ", Categoria: " + categoria + ", Estado: " + estado);

			JsonArrayBuilder array = Json.createArrayBuilder();
			for (Habitacion habitacion : habitaciones) {
				JsonObject item = Json.createObjectBuilder().add("idHabitacion", habitacion.getIdHabitacion())
						.add("numero", habitacion.getNumero()).add("piso", habitacion.getPiso())
						.add("tipo", habitacion.getTipo().getDescripcion())
						.add("idTipo", habitacion.getTipo().getIdTipo())
						.add("categoria", habitacion.getCategoria().getDescripcion())
						.add("idCategoria", habitacion.getCategoria().getIdCategoria())
						.add("estado", habitacion.getEstado().getDescripcion())
						.add("idEstado", habitacion.getEstado().getIdEstado())
						.add("costo", habitacion.getCosto()).build();

				array.add(item);
			}

			response.setContentType("application/json;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print(array.build());

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	protected void consulta(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String filtro = request.getParameter("filtro"); // número de piso
			log.info("En consulta: " + filtro);

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			HabitacionDAO dao = fabrica.getHabitacionDAO();

			if (filtro.length() == 0) {
				// Si no ingresa ningún valor, lista todas las habitaciones
				habitaciones = dao.listarHabitacion();
			} else {
				habitaciones = dao.consultaHabitacion(Integer.parseInt(filtro));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("habitaciones", habitaciones);
		request.getRequestDispatcher("/CrudHabitacion.jsp").forward(request, response);
	}

	protected void registra(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String numero = request.getParameter("numero");
			String piso = request.getParameter("piso");
			String tipo = request.getParameter("tipo");
			String categoria = request.getParameter("categoria");
			String estado = request.getParameter("estado");
			String costo = request.getParameter("costo");

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			HabitacionDAO dao = fabrica.getHabitacionDAO();

			Habitacion habitacion = new Habitacion();
			Tipo_Habitacion tipoHabitacion = new Tipo_Habitacion();
			Categoria_Habitacion categoriaHabitacion = new Categoria_Habitacion();
			Estado_Habitacion estadoHabitacion = new Estado_Habitacion();

			habitacion.setNumero(Integer.parseInt(numero));
			habitacion.setPiso(Integer.parseInt(piso));
			tipoHabitacion.setIdTipo(Integer.parseInt(tipo));
			habitacion.setTipo(tipoHabitacion);
			categoriaHabitacion.setIdCategoria(Integer.parseInt(categoria));
			habitacion.setCategoria(categoriaHabitacion);
			estadoHabitacion.setIdEstado(Integer.parseInt(estado));
			habitacion.setEstado(estadoHabitacion);
			habitacion.setCosto(Double.parseDouble(costo));

			dao.insertaHabitacion(habitacion);

			if (filtro.length() == 0) {
				// Si no ingresa ningún valor, lista todas las habitaciones
				habitaciones = dao.listarHabitacion();
			} else {
				habitaciones = dao.consultaHabitacion(Integer.parseInt(filtro));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("habitaciones", habitaciones);
		request.getRequestDispatcher("/CrudHabitacion.jsp").forward(request, response);
	}

	protected void elimina(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String idHabitacion = request.getParameter("idHabitacion");

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			HabitacionDAO dao = fabrica.getHabitacionDAO();

			dao.eliminaHabitacion(Integer.parseInt(idHabitacion));
			if (filtro.length() == 0) {
				// Si no ingresa ningún valor, lista todas las habitaciones
				habitaciones = dao.listarHabitacion();
			} else {
				habitaciones = dao.consultaHabitacion(Integer.parseInt(filtro));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("habitaciones", habitaciones);
		request.getRequestDispatcher("/CrudHabitacion.jsp").forward(request, response);
	}

	protected void actualiza(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.info("En actualizar habitación");
		try {
			String idHabitacion = request.getParameter("idHabitacion");

			String numero = request.getParameter("numero");
			String piso = request.getParameter("piso");
			String tipo = request.getParameter("tipo");
			String categoria = request.getParameter("categoria");
			String estado = request.getParameter("estado");
			String costo = request.getParameter("costo");

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			HabitacionDAO dao = fabrica.getHabitacionDAO();

			Habitacion habitacion = new Habitacion();
			Tipo_Habitacion tipoHabitacion = new Tipo_Habitacion();
			Categoria_Habitacion categoriaHabitacion = new Categoria_Habitacion();
			Estado_Habitacion estadoHabitacion = new Estado_Habitacion();

			habitacion.setIdHabitacion(Integer.parseInt(idHabitacion));
			habitacion.setNumero(Integer.parseInt(numero));
			habitacion.setPiso(Integer.parseInt(piso));
			tipoHabitacion.setIdTipo(Integer.parseInt(tipo));
			habitacion.setTipo(tipoHabitacion);
			categoriaHabitacion.setIdCategoria(Integer.parseInt(categoria));
			habitacion.setCategoria(categoriaHabitacion);
			estadoHabitacion.setIdEstado(Integer.parseInt(estado));
			habitacion.setEstado(estadoHabitacion);
			habitacion.setCosto(Double.parseDouble(costo));

			dao.actualizarHabitacion(habitacion);

			if (filtro.length() == 0) {
				// Si no ingresa ningún valor, lista todas las habitaciones
				habitaciones = dao.listarHabitacion();
			} else {
				habitaciones = dao.consultaHabitacion(Integer.parseInt(filtro));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("habitaciones", habitaciones);
		request.getRequestDispatcher("/CrudHabitacion.jsp").forward(request, response);
	}
}
