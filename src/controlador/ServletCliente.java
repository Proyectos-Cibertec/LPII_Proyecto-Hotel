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

import dao.ClienteDAO;
import entidad.Cliente;
import fabricas.Fabrica;

@WebServlet("/cliente")
public class ServletCliente extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final Log log = LogFactory.getLog(ServletCliente.class);

	private List<Cliente> clientes = new ArrayList<Cliente>();
	private String filtro = ""; // dni de Cliente

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

		case "buscarXApellido":
			buscarXApellido(request, response);
			break;
			
		case "consultaXFechaNacimiento":
			consultaXFechaNacimiento(request, response);
			break;

		case "consultaXDNI_JSON":
			consultaXDNI_JSON(request, response);
			break;

		}
	}
	
	protected void consultaXFechaNacimiento(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String fechaInicial = request.getParameter("fechaInicial");
			String fechaFinal = request.getParameter("fechaFinal");

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			ClienteDAO dao = fabrica.getClienteDAO();

			clientes = dao.consultaXFechaNacimiento(fechaInicial, fechaFinal);
		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("clientes", clientes);
		request.getRequestDispatcher("/ConsultaClientePorFechaNacimiento.jsp").forward(request, response);

	}

	protected void buscarXApellido(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String apellidos = request.getParameter("apellidos"); // apellidos
			log.info("En buscarXApellido: " + apellidos);

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			ClienteDAO dao = fabrica.getClienteDAO();
			clientes = dao.buscarClienteXApellido(apellidos);

			JsonArrayBuilder array = Json.createArrayBuilder();
			for (Cliente cliente : clientes) {
				JsonObject item = Json.createObjectBuilder().add("idCliente", cliente.getId())
						.add("nombres", cliente.getNombres()).add("apellidos", cliente.getApellidos())
						.add("dni", cliente.getDni()).add("direccion", cliente.getDireccion())
						.add("telefono", cliente.getTelefono()).add("fechaNacimiento", cliente.getFechaNacimiento())
						.add("fechaRegistro", cliente.getFechaRegistro()).build();

				array.add(item);
			}

			response.setContentType("application/json;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print(array.build());

		} catch (Exception e) {
			e.printStackTrace();
		}

		// request.setAttribute("productos", productos);
		// request.getRequestDispatcher("/BuscarProducto.jsp").forward(request,
		// response);
	}

	protected void consultaXDNI_JSON(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String filtro = request.getParameter("filtro");

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			ClienteDAO dao = fabrica.getClienteDAO();

			clientes = dao.consultaClienteXDni(filtro);

			JsonArrayBuilder array = Json.createArrayBuilder();
			for (Cliente cliente : clientes) {
				JsonObject item = Json.createObjectBuilder().add("nombres", cliente.getNombres())
						.add("apellidos", cliente.getApellidos()).add("dni", cliente.getDni())
						.add("direccion", cliente.getDireccion()).add("telefono", cliente.getTelefono())
						.add("fechaNacimiento", cliente.getFechaNacimiento())
						.add("fechaRegistro", cliente.getFechaRegistro()).build();

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
			ClienteDAO dao = fabrica.getClienteDAO();

			clientes = dao.consultaClienteXDni(filtro);
		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("clientes", clientes);
		request.getRequestDispatcher("/CrudCliente.jsp").forward(request, response);
	}

	protected void consultaxNombre(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/*
		 * try { String nombre = request.getParameter("cliente");
		 * 
		 * Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL); ClienteDAO dao =
		 * fabrica.getClienteDAO();
		 * 
		 * clientes = dao.consultaCliente(nombre); } catch (Exception e) {
		 * e.printStackTrace(); }
		 * 
		 * request.setAttribute("clientes", clientes);
		 * request.getRequestDispatcher("/ConsultaClientePorNombre.jsp").forward(
		 * request, response);
		 */
	}

	protected void registra(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String tipoRegistro = request.getParameter("tipoRegistro");
			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			ClienteDAO dao = fabrica.getClienteDAO();

			if (tipoRegistro.equalsIgnoreCase("default")) {
				log.info("Se inserta el cliente en la tabla persona y cliente");

				String nombres = request.getParameter("nombres");
				String apellidos = request.getParameter("apellidos");
				String dni = request.getParameter("dni");
				String direccion = request.getParameter("direccion");
				String telefono = request.getParameter("telefono");
				String fechaNacimiento = request.getParameter("fechaNacimiento");
				String fechaRegistro = request.getParameter("fechaRegistro");

				Cliente cliente = new Cliente();
				cliente.setNombres(nombres);
				cliente.setApellidos(apellidos);
				cliente.setDni(dni);
				cliente.setDireccion(direccion);
				cliente.setTelefono(telefono);
				cliente.setFechaNacimiento(fechaNacimiento);
				cliente.setFechaRegistro(fechaRegistro);

				dao.insertaCliente(cliente);

			} else {
				log.info("La persona ya existe, solo se inserta en la tabla cliente");
				String idPersona = request.getParameter("idPersona");
				String fechaRegistro = request.getParameter("fechaRegistro");

				Cliente cliente = new Cliente();
				cliente.setId(Integer.parseInt(idPersona));
				cliente.setFechaRegistro(fechaRegistro);

				dao.insertaCliente2(cliente);

			}

			clientes = dao.consultaClienteXDni(filtro);

		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("clientes", clientes);
		request.getRequestDispatcher("/CrudCliente.jsp").forward(request, response);
	}

	protected void elimina(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String idCliente = request.getParameter("idCliente");

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			ClienteDAO dao = fabrica.getClienteDAO();

			dao.eliminaCliente(Integer.parseInt(idCliente));
			clientes = dao.consultaClienteXDni(filtro);

		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("clientes", clientes);
		request.getRequestDispatcher("/CrudCliente.jsp").forward(request, response);

	}

	protected void actualiza(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		log.info("En actualizar cliente");
		try {
			String idCliente = request.getParameter("idCliente");
			String nombres = request.getParameter("nombres");
			String apellidos = request.getParameter("apellidos");
			String dni = request.getParameter("dni");
			String direccion = request.getParameter("direccion");
			String telefono = request.getParameter("telefono");
			String fechaNacimiento = request.getParameter("fechaNacimiento");
			String fechaRegistro = request.getParameter("fechaRegistro");

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			ClienteDAO dao = fabrica.getClienteDAO();

			Cliente cliente = new Cliente();
			cliente.setId(Integer.parseInt(idCliente));
			cliente.setNombres(nombres);
			cliente.setApellidos(apellidos);
			cliente.setDni(dni);
			cliente.setDireccion(direccion);
			cliente.setTelefono(telefono);
			cliente.setFechaNacimiento(fechaNacimiento);
			cliente.setFechaRegistro(fechaRegistro);

			dao.actualizaCliente(cliente);
			clientes = dao.consultaClienteXDni(filtro);

		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("clientes", clientes);
		request.getRequestDispatcher("/CrudCliente.jsp").forward(request, response);

	}
}
