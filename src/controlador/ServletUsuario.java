package controlador;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.TrabajadorDAO;
import dao.UsuarioDAO;
import entidad.Enlace;
import entidad.Trabajador;
import entidad.Usuario;
import fabricas.Fabrica;

@WebServlet("/usuario")
public class ServletUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String metodo = request.getParameter("metodo");

		switch (metodo) {
		case "login":
			login(request, response);
			break;
		case "logout":
			logout(request, response);
			break;
		}

	}
	
	protected void logout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//Se obtiene la session
		HttpSession  session = request.getSession();
		
		//Se destruye la session
		session.invalidate();
		
		//elimina los elementos del cache del browser
		response.setHeader("Cache-control", "no-cache");
		response.setHeader("Expires", "0");
		response.setHeader("Pragma", "no-cache");

		//se envia un mensaje al login.jsp
		String mensaje = "El usuario cerró sesión";
		request.setAttribute("mensaje", mensaje);
		request.getRequestDispatcher("/login.jsp").forward(request, response);
	}

	protected void login(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String user = request.getParameter("loginuser");
		String clave = request.getParameter("loginpassword");

		Usuario bean = new Usuario();
		bean.setUsuario(user);
		bean.setPassword(clave);

		Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
		UsuarioDAO dao = fabrica.getUsuarioDAO();

		try {
			Usuario usuario = dao.login(bean);

			// Existe dos opociones: El usuario exista y que no exista en la BD
			if (usuario == null) { // NO EXISTE
				String mensaje = "El usuario no existe";
				request.setAttribute("mensaje", mensaje);
				request.getRequestDispatcher("/login.jsp").forward(request, response);

			} else { // EXISTE
				// Los datos de usuario que ingresa al sistema se guardan en sesión
				List<Enlace> enlaces = dao.traerEnlacesDeUsuario(usuario.getIdUsuario());

				// Se trae los datos del empleado que se ha logeado
				TrabajadorDAO trabajadorDAO = fabrica.getTrabajadorDAO();
				Trabajador trabajador = trabajadorDAO.obtenerTrabajadorPorIDUsuario(usuario.getIdUsuario());

				HttpSession session = request.getSession();
				session.setAttribute("objUsuario", usuario);
				session.setAttribute("objTrabajador", trabajador);
				session.setAttribute("objMenus", enlaces);
				response.sendRedirect("home.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
