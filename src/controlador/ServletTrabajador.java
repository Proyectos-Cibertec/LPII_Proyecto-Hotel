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

import dao.TrabajadorDAO;
import entidad.Trabajador;
import fabricas.Fabrica;

@WebServlet("/trabajador")
public class ServletTrabajador extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final Log log = LogFactory.getLog(ServletTrabajador.class);

	private List<Trabajador> trabajadores = new ArrayList<Trabajador>();
	private String filtro = ""; // dni de trabajador

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String metodo = request.getParameter("metodo");
		log.info("Método llamado: " + metodo);

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

		case "consultaxNombre":
			consultaxNombre(request, response);
			break;

		case "consultaXFechaContratacion":
			consultaXFechaContratacion(request, response);
			break;
			
		case "consultaXFechaNacimiento":
			consultaXFechaNacimiento(request, response);
			break;

		case "consultaXDNI_JSON":
			consultaXDNI_JSON(request, response);
			break;

		}
	}

	protected void consultaXDNI_JSON(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String filtro = request.getParameter("filtro");

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			TrabajadorDAO dao = fabrica.getTrabajadorDAO();

			trabajadores = dao.consultaTrabajadorXDni(filtro);

			JsonArrayBuilder array = Json.createArrayBuilder();
			for (Trabajador trabajador : trabajadores) {
				JsonObject item = Json.createObjectBuilder().add("nombres", trabajador.getNombres())
						.add("apellidos", trabajador.getApellidos()).add("dni", trabajador.getDni())
						.add("direccion", trabajador.getDireccion()).add("telefono", trabajador.getTelefono())
						.add("fechaNacimiento", trabajador.getFechaNacimiento())
						.add("fechaRegistro", trabajador.getFechaContratacion()).add("salario", trabajador.getSalario())
						.build();

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
			String filtro = request.getParameter("filtro");

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			TrabajadorDAO dao = fabrica.getTrabajadorDAO();

			trabajadores = dao.consultaTrabajadorXDni(filtro);
		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("trabajadores", trabajadores);
		request.getRequestDispatcher("/CrudTrabajador.jsp").forward(request, response);
	}

	protected void consultaxNombre(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/*
		 * try { String nombre = request.getParameter("trabajador");
		 * 
		 * Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL); TrabajadorDAO dao =
		 * fabrica.getTrabajadorDAO();
		 * 
		 * trabajadores = dao.consultaCliente(nombre); } catch (Exception e) {
		 * e.printStackTrace(); }
		 * 
		 * request.setAttribute("trabajadores", trabajadores);
		 * request.getRequestDispatcher("/ConsultaClientePorNombre.jsp").forward(
		 * request, response);
		 */
	}

	protected void consultaXFechaContratacion(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String fechaInicial = request.getParameter("fechaInicial");
			String fechaFinal = request.getParameter("fechaFinal");

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			TrabajadorDAO dao = fabrica.getTrabajadorDAO();

			trabajadores = dao.consultaXFechaContratacion(fechaInicial, fechaFinal);
		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("trabajadores", trabajadores);
		request.getRequestDispatcher("/ConsultaTrabajadorPorFechaContratacion.jsp").forward(request, response);

	}
	
	protected void consultaXFechaNacimiento(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String fechaInicial = request.getParameter("fechaInicial");
			String fechaFinal = request.getParameter("fechaFinal");

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			TrabajadorDAO dao = fabrica.getTrabajadorDAO();

			trabajadores = dao.consultaXFechaNacimiento(fechaInicial, fechaFinal);
		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("trabajadores", trabajadores);
		request.getRequestDispatcher("/ConsultaTrabajadorPorFechaNacimiento.jsp").forward(request, response);

	}

	protected void registra(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String tipoRegistro = request.getParameter("tipoRegistro");
			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			TrabajadorDAO dao = fabrica.getTrabajadorDAO();

			if (tipoRegistro.equalsIgnoreCase("default")) {
				log.info("Se inserta el trabajador en la tabla persona y trabajador");

				String nombres = request.getParameter("nombres");
				String apellidos = request.getParameter("apellidos");
				String dni = request.getParameter("dni");
				String direccion = request.getParameter("direccion");
				String telefono = request.getParameter("telefono");
				String fechaNacimiento = request.getParameter("fechaNacimiento");
				String fechaContratacion = request.getParameter("fechaContratacion");
				String salario = request.getParameter("salario");

				Trabajador trabajador = new Trabajador();
				trabajador.setNombres(nombres);
				trabajador.setApellidos(apellidos);
				trabajador.setDni(dni);
				trabajador.setDireccion(direccion);
				trabajador.setTelefono(telefono);
				trabajador.setFechaNacimiento(fechaNacimiento);
				trabajador.setFechaContratacion(fechaContratacion);
				trabajador.setSalario(Double.parseDouble(salario));

				dao.insertaTrabajador(trabajador);

			} else {
				log.info("La persona ya existe, solo se inserta en la tabla trabajador");
				String idPersona = request.getParameter("idPersona");
				String fechaContratacion = request.getParameter("fechaContratacion");
				String salario = request.getParameter("salario");

				Trabajador trabajador = new Trabajador();
				trabajador.setId(Integer.parseInt(idPersona));
				trabajador.setFechaContratacion(fechaContratacion);
				trabajador.setSalario(Double.parseDouble(salario));

				dao.insertaTrabajador2(trabajador);

			}

			trabajadores = dao.consultaTrabajadorXDni(filtro);

		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("trabajadores", trabajadores);
		request.getRequestDispatcher("/CrudTrabajador.jsp").forward(request, response);
	}

	protected void elimina(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String idTrabajador = request.getParameter("idTrabajador");

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			TrabajadorDAO dao = fabrica.getTrabajadorDAO();

			dao.eliminaTrabajador(Integer.parseInt(idTrabajador));
			trabajadores = dao.consultaTrabajadorXDni(filtro);

		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("trabajadores", trabajadores);
		request.getRequestDispatcher("/CrudTrabajador.jsp").forward(request, response);

	}

	protected void actualiza(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		log.info("En actualizar trabajador");
		try {
			String idTrabajador = request.getParameter("idTrabajador");
			String nombres = request.getParameter("nombres");
			String apellidos = request.getParameter("apellidos");
			String dni = request.getParameter("dni");
			String direccion = request.getParameter("direccion");
			String telefono = request.getParameter("telefono");
			String fechaNacimiento = request.getParameter("fechaNacimiento");
			String fechaContratacion = request.getParameter("fechaContratacion");
			String salario = request.getParameter("salario");

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			TrabajadorDAO dao = fabrica.getTrabajadorDAO();

			Trabajador trabajador = new Trabajador();
			trabajador.setId(Integer.parseInt(idTrabajador));
			trabajador.setNombres(nombres);
			trabajador.setApellidos(apellidos);
			trabajador.setDni(dni);
			trabajador.setDireccion(direccion);
			trabajador.setTelefono(telefono);
			trabajador.setFechaNacimiento(fechaNacimiento);
			trabajador.setFechaContratacion(fechaContratacion);
			trabajador.setSalario(Double.parseDouble(salario));

			dao.actualizaTrabajador(trabajador);
			trabajadores = dao.consultaTrabajadorXDni(filtro);

		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("trabajadores", trabajadores);
		request.getRequestDispatcher("/CrudTrabajador.jsp").forward(request, response);

	}
}
