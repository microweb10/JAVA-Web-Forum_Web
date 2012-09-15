package tw.datos;

import java.util.Date;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;

public class Foro {
	
	/*------------------------------- CAMPOS ----------------------------------------*/	 
	
	/**
	 * identificador del foro
	 */
	private int id;
	/**
	 * nombre del foro
	 */
	private String titulo;
	/**
	 * Texto con la descripcion que debe aparecer en la página principal
	 */
	private String descripcion;
	/**
	 * Lista con los temas dentro del foro
	 */
	private Tema [] temas;
	/**
	 * número de temas en el foro
	 */
	private int numTemas;
	/**
	 * Número de mensajes en el foro
	 */
	private int numMensajes;
	/**
	 * Identificador del último mensaje
	 */
	private int idUltMensaje;
	/**
	 * identificador del usuario que envió el último mensaje
	 */
	private String userUltMensaje;
	/**
	 * Fecha en que se envió el último mensaje
	 */
	private java.util.Date fechaUltMensaje;
	

	/*------------------------- METODOS ------------------------------------------------------*/
	
	public Foro() {
		
	}
		
	/* METODOS GET/SET */
	

	public java.util.Date getFechaUltMensaje() {
		return fechaUltMensaje;
	}

	public void setFechaUltMensaje(java.util.Date fechaUltMensaje) {
		this.fechaUltMensaje = fechaUltMensaje;
	}

	public String getUserUltMensaje() {
		return userUltMensaje;
	}

	public void setUserUltMensaje(String userUltMensaje) {
		this.userUltMensaje = userUltMensaje;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdUltMensaje() {
		return idUltMensaje;
	}

	public void setIdUltMensaje(int idUltMensaje) {
		this.idUltMensaje = idUltMensaje;
	}

	public int getNumMensajes() {
		return numMensajes;
	}

	public void setNumMensajes(int numMensajes) {
		this.numMensajes = numMensajes;
	}


	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public Tema [] getTemas() {
		return temas;
	}

	public void setTemas(Tema [] temas) {
		this.temas = temas;
	}

	public int getNumTemas() {
		return numTemas;
	}

	public void setNumTemas(int numTemas) {
		this.numTemas = numTemas;
	}
	
	public void serialize(DataOutputStream dos) throws IOException {
		dos.writeInt(id);
		dos.writeUTF(titulo);
		dos.writeUTF(descripcion);

		if(temas==null) {
			dos.writeInt(0);
		} else {
			dos.writeInt(temas.length);

			for(int i=0;i<temas.length;i++) {
				temas[i].serialize(dos);
			}			
		}
		
		dos.writeInt(numMensajes);
		dos.writeInt(idUltMensaje);
		dos.writeUTF(userUltMensaje);
		dos.writeLong(fechaUltMensaje.getTime());
	}
	
	public static Foro deserialize(DataInputStream dis) throws IOException {
		
		Foro foro = new Foro();
		
		foro.setId(dis.readInt());
		foro.setTitulo(dis.readUTF()); 
		foro.setDescripcion(dis.readUTF()); 

		int numTemas = dis.readInt(); 
		Tema [] temas = new Tema[numTemas];

		foro.setNumTemas(numTemas);
		for(int i=0;i<numTemas;i++) { 
			temas[i] = Tema.deserialize(dis);
		}
		foro.setTemas(temas); 
		
		foro.setNumMensajes(dis.readInt());
		foro.setIdUltMensaje(dis.readInt());
		foro.setUserUltMensaje(dis.readUTF());
		foro.setFechaUltMensaje(new Date(dis.readLong()));
		
		return foro;
	} 

}
