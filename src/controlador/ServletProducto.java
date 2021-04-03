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

import dao.ProductoDAO;
import entidad.Producto;
import entidad.Servicio;
import fabricas.Fabrica;

@WebServlet("/producto")
public class ServletProducto extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final Log log = LogFactory.getLog(ServletProducto.class);

	private List<Producto> productos = new ArrayList<Producto>();
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

		case "busca":
			busca(request, response);
			break;
		}
	}
	
	protected void busca(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String descripcion = request.getParameter("descripcion"); // descripción
			log.info("En busca: " + descripcion);

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			ProductoDAO dao = fabrica.getProductoDAO();
			productos = dao.buscaProductoXDescripcion(descripcion);
			
			JsonArrayBuilder array = Json.createArrayBuilder();
			for (Producto producto : productos) {
				JsonObject item = Json.createObjectBuilder().add("idProducto", producto.getIdProducto())
						.add("descripcion", producto.getDescripcion()).add("costo", producto.getCosto())
						.add("servicio", producto.getServicio().getNombre()).build();

				array.add(item);
			}

			response.setContentType("application/json;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print(array.build());
		} catch (Exception e) {
			e.printStackTrace();
		}

		// request.setAttribute("productos", productos);
		// request.getRequestDispatcher("/BuscarProducto.jsp").forward(request, response);
	}

	protected void consulta(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String filtro = request.getParameter("filtro"); // descripción
			log.info("En consulta: " + filtro);

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			ProductoDAO dao = fabrica.getProductoDAO();

			productos = dao.consultaProducto(filtro);
		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("productos", productos);
		request.getRequestDispatcher("/CrudProducto.jsp").forward(request, response);
	}

	protected void registra(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String descripcion = request.getParameter("descripcion");
			String costo = request.getParameter("costo");
			String idServicio = request.getParameter("idServicio");

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			ProductoDAO dao = fabrica.getProductoDAO();

			Producto producto = new Producto();
			Servicio servicio = new Servicio();

			producto.setDescripcion(descripcion);
			producto.setCosto(Double.parseDouble(costo));
			servicio.setIdServicio(Integer.parseInt(idServicio));
			producto.setServicio(servicio);

			dao.insertaProducto(producto);
			productos = dao.consultaProducto(filtro);

		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("productos", productos);
		request.getRequestDispatcher("/CrudProducto.jsp").forward(request, response);
	}

	protected void elimina(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String idProducto = request.getParameter("idProducto");

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			ProductoDAO dao = fabrica.getProductoDAO();

			dao.eliminaProducto(Integer.parseInt(idProducto));
			productos = dao.consultaProducto(filtro);

		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("productos", productos);
		request.getRequestDispatcher("/CrudProducto.jsp").forward(request, response);
	}

	protected void actualiza(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.info("En actualizar habitación");
		try {
			String idProducto = request.getParameter("idProducto");
			String descripcion = request.getParameter("descripcion");
			String costo = request.getParameter("costo");
			String idServicio = request.getParameter("idServicio");

			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			ProductoDAO dao = fabrica.getProductoDAO();

			Producto producto = new Producto();
			Servicio servicio = new Servicio();

			producto.setIdProducto(Integer.parseInt(idProducto));
			producto.setDescripcion(descripcion);
			producto.setCosto(Double.parseDouble(costo));
			servicio.setIdServicio(Integer.parseInt(idServicio));
			producto.setServicio(servicio);

			dao.actualizaProducto(producto);
			productos = dao.consultaProducto(filtro);

		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("productos", productos);
		request.getRequestDispatcher("/CrudProducto.jsp").forward(request, response);
	}
}
