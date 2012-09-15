package tw.datos;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.util.Date;

public class Mensaje {
	/**
	 * identificador del mensaje
	 */
	private int id;
	/**
	 * identificador del tema en el que está el mensaje
	 */
	private int idTema;
	/**
	 * asunto del mensaje
	 */
	private String asunto;
	/**
	 * Contenido del mensaje
	 */
	private String texto;
	/**
	 * Fecha y hora en que se envió
	 */
	private java.util.Date fecha; 
	/**
	 * Identificador del usuario que lo envía
	 */
	private String autor;
	
	public Mensaje() {
		
	}

	public String getAsunto() {
		return asunto;
	}

	public void setAsunto(String asunto) {
		this.asunto = asunto;
	}

	public java.util.Date getFecha() {
		return fecha;
	}

	public void setFecha(java.util.Date fecha) {
		this.fecha = fecha;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdTema() {
		return idTema;
	}

	public void setIdTema(int idTema) {
		this.idTema = idTema;
	}

	public String getTexto() {
		return texto;
	}

	public void setTexto(String texto) {
		this.texto = texto;
	}

	public String getAutor() {
		return autor;
	}

	public void setAutor(String usuario) {
		this.autor = usuario;
	}
	
	public void serialize(DataOutputStream dos) throws IOException {
		dos.writeInt(id);
		dos.writeInt(idTema);
		dos.writeUTF(asunto);
		dos.writeUTF(texto);
		dos.writeLong(fecha.getTime());
		dos.writeUTF(autor);
	}
	
	public static Mensaje deserialize(DataInputStream dis) throws IOException {
		
		Mensaje msg = new Mensaje();
		
		msg.setId(dis.readInt());
		msg.setIdTema(dis.readInt());
		msg.setAsunto(dis.readUTF());
		msg.setTexto(dis.readUTF());
		msg.setFecha(new Date(dis.readLong()));
		msg.setAutor(dis.readUTF());
		
		return msg;
	}
	
}
