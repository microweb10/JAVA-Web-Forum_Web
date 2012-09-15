package tw;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class for Servlet: ControladorMicro
 *
 */
 public class ControladorMicro extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {

		private static final long serialVersionUID = 1L;

		private final static int ACCION_OBTENER_MENSAJES = 2;

		private final static int ACCION_OBTENER_TEMAS = 3;

		private final static int ACCION_OBTENER_FOROS = 4;

		private final static int ACCION_CAMBIAR_AVATAR = 5;

		private final static int RESPUESTA_OK = 0;

		private final static int RESPUESTA_ERROR = 1;

		protected void doGet(HttpServletRequest request,
				HttpServletResponse response) throws ServletException, IOException {

			DataInputStream dis = new DataInputStream(request.getInputStream());
			DataOutputStream dos = new DataOutputStream(response.getOutputStream());

			int accion = dis.readInt();

			switch (accion) {

			case ACCION_OBTENER_MENSAJES:

				try {
					String temaId = dis.readUTF();
					Tema tema = Tema.buscarTema(temaId);

					if (tema == null) {
						dos.writeInt(RESPUESTA_ERROR);
						dos.writeUTF("No se encuentra el tema solicitado");
					} else {
						dos.writeInt(RESPUESTA_OK);
						tema.serialize(dos);
					}				
				} catch(Exception e) {
					dos.writeInt(RESPUESTA_ERROR);
					dos.writeUTF("Error del servidor al obtener mensajes");				
				}

				break;

			case ACCION_OBTENER_TEMAS:

				try {
					String foroId = dis.readUTF();
					Foro foro = Foro.buscarForo(foroId);

					if (foro == null) {
						dos.writeInt(RESPUESTA_ERROR);
						dos.writeUTF("No se encuentra el foro solicitado");
					} else {
						dos.writeInt(RESPUESTA_OK);
						foro.serialize(dos);
					}				
				} catch(Exception e) {
					dos.writeInt(RESPUESTA_ERROR);
					dos.writeUTF("Error del servidor al obtener mensajes");				
				}

				break;

			case ACCION_OBTENER_FOROS:

				try {
					List foros = Foros.getListaForos();

					if (foros == null) {
						dos.writeInt(RESPUESTA_ERROR);
						dos.writeUTF("No hay ningun foro");
					} else {
						dos.writeInt(RESPUESTA_OK);
						dos.writeInt(foros.size());
						
						Iterator iter = foros.iterator();
						while(iter.hasNext()) {
							Foro foro = (Foro)iter.next();
							foro.serialize(dos);
						}
					}				
				} catch(Exception e) {
					dos.writeInt(RESPUESTA_ERROR);
					dos.writeUTF("Error del servidor al obtener foros");				
				}

				break;

			case ACCION_CAMBIAR_AVATAR:

					try {
						String login = dis.readUTF();
						String password = dis.readUTF();

						Usuario user = Usuario.autentificar(login, password);

						if(user==null) {
							dos.writeInt(RESPUESTA_ERROR);
							dos.writeUTF("Login y password incorrectos");												
						} else {
							int imgSize = dis.readInt();
							byte [] imagen = new byte[imgSize];
							for(int i=0;i<imagen.length;i++) {
								imagen[i] = (byte)dis.read();							
							}

							ServletContext sc = getServletContext();
							String filename = sc.getRealPath("/fotos") + "/" + user.getId() + ".png";
							
							FileOutputStream fos = new FileOutputStream(filename);
							for(int i=0;i<imagen.length;i++) {
								fos.write(imagen[i]);							
							}
							fos.flush();
							fos.close();
							
							dos.writeInt(RESPUESTA_OK);							
						}
						
					} catch(Exception e) {
						dos.writeInt(RESPUESTA_ERROR);
						dos.writeUTF("Error del servidor al subir el avatar");				
					}					

				break;

			}

			dos.flush();
			dos.close();
		}

		protected void doPost(HttpServletRequest request,
				HttpServletResponse response) throws ServletException, IOException {
			doPost(request, response);
		}
   	  	    
}