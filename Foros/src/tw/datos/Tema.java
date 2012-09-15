package tw.datos;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.util.Date;

public class Tema {
	
	/*--------------------- CAMPOS DEL OBJETO -----------------------------------------------------------*/
   /**
    * Identificador del tema
    */
   private int id;
   /**
    * Identificador del foro que contiene el tema
    */
   private int idForo;
   /**
    * Asunto del tema
    */
   private String asunto;
   /**
    * Identificador del usuario que creó el tema
    */
   private String autor;
   /**
    * Fecha y hora de creación del tema
    */
   private java.util.Date fecha;
   /**
    * Mensajes en el tema
    */
   private Mensaje [] mensajes;
   /**
    * Número de mensajes en el tema
    */
   private int numMensajes;
   /**
    * Identificador del último mensaje del tema
    */
   private int idUltMensaje;
   /**
    * identificador del autor del último mensaje del tema
    */
   private String autorUltMensaje;
   /**
    * Fecha del último mensaje del tema
    */
   private java.util.Date fechaUltMensaje;

   
   /*----------------------------- METODOS -------------------------------------------*/

   public Tema() {
	   
   }   
   
   /* METODOS GET/SET */
   
	public java.util.Date getFecha() {
		return fecha;
	}

	public void setFecha(java.util.Date fecha) {
		this.fecha = fecha;
	}


	public String getAutor() {
		return autor;
	}

	public void setAutor(String autor) {
		this.autor = autor;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdForo() {
		return idForo;
	}

	public void setIdForo(int idForo) {
		this.idForo = idForo;
	}

	public String getAsunto() {
		return asunto;
	}

	public void setAsunto(String titulo) {
		this.asunto = titulo;
	}

	public Mensaje [] getMensajes() {
		return mensajes;
	}

	public void setMensajes(Mensaje [] mensajes) {
		this.mensajes = mensajes;
	}

	public String getAutorUltMensaje() {
		return autorUltMensaje;
	}

	public void setAutorUltMensaje(String autorUltMensaje) {
		this.autorUltMensaje = autorUltMensaje;
	}

	public java.util.Date getFechaUltMensaje() {
		return fechaUltMensaje;
	}

	public void setFechaUltMensaje(java.util.Date fechaUltMensaje) {
		this.fechaUltMensaje = fechaUltMensaje;
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
	
	public void serialize(DataOutputStream dos) throws IOException {
		dos.writeInt(id);
		dos.writeInt(idForo);
		dos.writeUTF(asunto);
		dos.writeUTF(autor);
		dos.writeLong(fecha.getTime());
		
		if(mensajes==null) {
			dos.writeInt(0);
		} else {
			dos.writeInt(mensajes.length);

			for(int i=0;i<mensajes.length;i++) {
				mensajes[i].serialize(dos);
			}			
		}
		
		dos.writeInt(idUltMensaje);
		dos.writeUTF(autorUltMensaje);
		dos.writeLong(fechaUltMensaje.getTime());
	}
	
	public static Tema deserialize(DataInputStream dis) throws IOException {
		
		Tema tema  = new Tema();
		
		tema.setId(dis.readInt());
		tema.setIdForo(dis.readInt());
		tema.setAsunto(dis.readUTF()); 
		tema.setAutor(dis.readUTF()); 
		tema.setFecha(new Date(dis.readLong())); 

		int numMensajes = dis.readInt();
		Mensaje [] mensajes = new Mensaje[numMensajes];

		tema.setNumMensajes(numMensajes);

		for(int i=0;i<numMensajes;i++) {
			mensajes[i] = Mensaje.deserialize(dis);
		}
		tema.setMensajes(mensajes);
		
		tema.setIdUltMensaje(dis.readInt());
		tema.setAutorUltMensaje(dis.readUTF());
		tema.setFechaUltMensaje(new Date(dis.readLong()));
		
		return tema;
	} 
   
}
