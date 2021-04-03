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

import dao.PersonaDAO;
import entidad.Persona;
import fabricas.Fabrica;

@WebServlet("/persona")
public class ServletPersona extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final Log log = LogFactory.getLog(ServletPersona.class); 
	
	private List<Persona> personas = new ArrayList<Persona>();

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String metodo = request.getParameter("metodo");
		log.info("Método llamado: " + metodo);
		
		switch (metodo) {	
			case "consultaXDNI_JSON":
				consultaXDNI_JSON(request, response);
				break;
		}
	}
	
	protected void consultaXDNI_JSON(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String filtro = request.getParameter("filtro");
			
			Fabrica fabrica = Fabrica.getFabrica(Fabrica.MYSQL);
			PersonaDAO dao = fabrica.getPersonaDAO();
			
			personas = dao.consultaXDni(filtro);
			
			JsonArrayBuilder array = Json.createArrayBuilder();
			for (Persona persona : personas) {
				JsonObject item = Json.createObjectBuilder()
						.add("idPersona", persona.getId())
						.add("nombres", persona.getNombres())
						.add("apellidos", persona.getApellidos())
						.add("dni", persona.getDni())
						.add("direccion", persona.getDireccion())
						.add("telefono", persona.getTelefono())
						.add("fechaNacimiento", persona.getFechaNacimiento()).build();
				
				array.add(item);
			}
			
			response.setContentType("application/json;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print(array.build());	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
