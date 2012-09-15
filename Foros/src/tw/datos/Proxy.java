package tw.datos;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;

import javax.microedition.io.Connector;
import javax.microedition.io.HttpConnection;

public class Proxy {

	// Acciones soportadas por el servlet

	private final static int ACCION_OBTENER_MENSAJES = 2;

	private final static int ACCION_OBTENER_TEMAS = 3;

	private final static int ACCION_OBTENER_FOROS = 4;

	private final static int ACCION_CAMBIAR_AVATAR = 5;

	private final static int RESPUESTA_OK = 0;

	// URL por defecto del servlet controlador para J2ME
	private final static String DEFAULT_SERVLET_URL = "http://localhost:8080/ForosTW/ControladorMicro";

	// URL del servlet al que se accede actualmente
	private String urlServlet = DEFAULT_SERVLET_URL;

	/**
	 * Descarga la lista de foros del servidor
	 * 
	 * @return Lista de foros. No contendrán información sobre los temas que
	 *         contienen.
	 * @throws IOException
	 *             Si ocurre un error en la conexión con el servidor
	 * 
	 */
	public Foro[] getForos() throws IOException {
		HttpConnection con = null;

		try {
			con = (HttpConnection) Connector.open(urlServlet);

			// Envia datos al servidor
			DataOutputStream dos = con.openDataOutputStream();
			dos.writeInt(ACCION_OBTENER_FOROS);
			dos.flush();
			dos.close();

			// Recibe datos del servidor
			DataInputStream dis = con.openDataInputStream();
			int resp = dis.readInt();
			if (resp != RESPUESTA_OK) {
				throw new IOException(dis.readUTF());
			}
			// Deserializa la lista de foros
			int numForos = dis.readInt();
			Foro[] foros = new Foro[numForos];
			for (int i = 0; i < numForos; i++) {
				foros[i] = Foro.deserialize(dis);
			}
			dis.close();

			return foros;

		} finally {
			if (con != null) {
				con.close();
			}
		}
	}

	/**
	 * Obtiene los datos de un foro y la lista de temas que contiene
	 * 
	 * @param id
	 *            Identificador del foro solicitado
	 * @return Datos del foro, conteniendo la lista de sus temas. Los temas no
	 *         tendrán información sobre los mensajes que contienen.
	 * @throws IOException
	 *             Si ocurre un error en la conexión con el servidor
	 */
	public Foro getForo(String id) throws IOException {
		// TODO: Descargar el foro con identificador id del servidor.
		HttpConnection con = null;

		try {
			con = (HttpConnection) Connector.open(urlServlet);

			// Envia datos al servidor
			DataOutputStream dos = con.openDataOutputStream();
			dos.writeInt(ACCION_OBTENER_TEMAS);
			dos.writeUTF(id);
			dos.flush();
			dos.close();

			// Recibe datos del servidor
			DataInputStream dis = con.openDataInputStream();
			int resp = dis.readInt();
			if (resp != RESPUESTA_OK) {
				throw new IOException(dis.readUTF());
			}
			// Deserializa el foro con su lista de temas
			Foro foro;
			foro = Foro.deserialize(dis);
			
			dis.close();

			return foro;

		} finally {
			if (con != null) {
				con.close();
			}
		}
	}

	/**
	 * Obtiene los datos de un tema y la lista de mensajes que contiene.
	 * 
	 * @param id
	 *            Identificador del tema solicitado
	 * @return Datos del tema, conteniendo la lista de sus mensajes.
	 * @throws IOException
	 *             Si ocurre un error en la conexión con el servidor
	 */
	public Tema getTema(String id) throws IOException {
		// TODO: Descargar el tema con identificador id del servidor.
		HttpConnection con = null;

		try {
			con = (HttpConnection) Connector.open(urlServlet);

			// Envia datos al servidor
			DataOutputStream dos = con.openDataOutputStream();
			dos.writeInt(ACCION_OBTENER_MENSAJES);
			dos.writeUTF(id);
			dos.flush();
			dos.close();

			// Recibe datos del servidor
			DataInputStream dis = con.openDataInputStream();
			int resp = dis.readInt();
			if (resp != RESPUESTA_OK) {
				throw new IOException(dis.readUTF());
			}
			// Deserializa el tema con su lista de mensajes
			Tema tema;
			tema = Tema.deserialize(dis);
			
			dis.close();

			return tema;

		} finally {
			if (con != null) {
				con.close();
			}
		}
	}

	/**
	 * Sube un nuevo avatar al servidor.
	 * 
	 * @param login
	 *            Login del usuario del que queremos cambiar el avatar
	 * @param password
	 *            Password del usuario del que queremos cambiar el avatar
	 * @param imagen
	 *            Bytes de la imagen que vamos a subir como avatar, en formato
	 *            PNG
	 * @throws IOException
	 *             Si ocurre un error en la conexión con el servidor
	 */
	public void cambiarAvatar(String login, String password, byte[] imagen)
			throws IOException {
		// TODO: Enviar imagen al servidor.
		HttpConnection con = null;

		try {
			con = (HttpConnection) Connector.open(urlServlet);

			// Envia datos al servidor
			DataOutputStream dos = con.openDataOutputStream();
			dos.writeInt(ACCION_CAMBIAR_AVATAR);
			dos.writeUTF(login);
			dos.writeUTF(password);
			dos.writeInt(imagen.length);
			for(int i=0;i<imagen.length;i++) dos.write(imagen[i]);
			dos.flush();
			dos.close();

			// Recibe datos del servidor
			DataInputStream dis = con.openDataInputStream();
			int resp = dis.readInt();
			if (resp != RESPUESTA_OK) {
				throw new IOException(dis.readUTF());
			}
			
			dis.close();

		} finally {
			if (con != null) {
				con.close();
			}
		}
	}

}
