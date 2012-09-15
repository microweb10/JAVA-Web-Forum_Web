package tw;

import java.io.IOException;

import javax.microedition.io.PushRegistry;
import javax.microedition.lcdui.Alert;
import javax.microedition.lcdui.AlertType;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Displayable;
import javax.microedition.midlet.MIDlet;
import javax.microedition.midlet.MIDletStateChangeException;

import tw.datos.Foro;
import tw.datos.Tema;
import tw.datos.Proxy;
import tw.datos.RecepcionSMS;
import tw.ui.BarraProgresoUI;
import tw.ui.CapturaFotoUI;
import tw.ui.ConfirmaFotoUI;
import tw.ui.ListaForosUI;
import tw.ui.ListaTemasUI;
import tw.ui.ListaMensajesUI;
import tw.ui.MenuPrincipalUI;

public class MIDletForos extends MIDlet {

	Display display = Display.getDisplay(this);

	/*
	 * Acceso al servidor remoto
	 */
	Proxy remoto;
	
	/*
	 * Pantallas de la aplicacion
	 */
	BarraProgresoUI uiProgreso = new BarraProgresoUI(this);
	ListaForosUI uiListaForos = new ListaForosUI(this);
	ListaTemasUI uiListaTemas = new ListaTemasUI(this);
	ListaMensajesUI uiListaMensajes = new ListaMensajesUI(this);
	MenuPrincipalUI uiMenuPrincipal = new MenuPrincipalUI(this);
	CapturaFotoUI uiCapturaFoto = new CapturaFotoUI(this);
	ConfirmaFotoUI uiConfirmaFoto = new ConfirmaFotoUI(this);
	
	public MIDletForos() {
		super();
		
		remoto = new Proxy();
	}

	/**
	 * Inicia la descarga de la lista de foros desde el servidor 
	 * para mostrarlos en el móvil
	 *
	 */
	public void verForos() {
		Thread t = new HiloVerForos();
		t.start();
	}

	/**
	 * Muestra la lista de foros (ya descargada) en el móvil
	 * @param foros Lista de foros
	 */
	public void verForos(Foro [] foros) {
		uiListaForos.setForos(foros);
		display.setCurrent(uiListaForos);
	}	

	/**
	 * Inicia la descarga de la lista de temas de un foro desde el
	 * servidor para mostrarlos en el móvil
	 * @param id Identificador del foro solicitado
	 */
	public void verForo(String id) {
		// TODO: Iniciar la descarga de los temas del foro. Esta
		// descarga debera hacerse siempre mediante un hilo, para no
		// bloquear la aplicación.
		Thread t = new HiloVerTemas(id);
		t.start();
	}
	/**
	 * Muestra la lista de temas (ya descargada) en el móvil
	 * @param foro con su Lista de temas
	 */
	public void verForo(Foro foro) {
		uiListaTemas.setForo(foro);
		display.setCurrent(uiListaTemas);
	}	
	
	/**
	 * Inicia la descarga de la lista de mensajes de un tema desde el
	 * servidor para mostrarlos en el móvil
	 * @param id Identificador del foro solicitado
	 */
	public void verTema(String id) {
		// TODO: Iniciar la descarga de los mensajes del tema. Esta
		// descarga debera hacerse siempre mediante un hilo, para no
		// bloquear la aplicación.
		Thread t = new HiloVerMensajes(id);
		t.start();
	}
	/**
	 * Muestra la lista de mensajes (ya descargada) en el móvil
	 * @param foro con su Lista de temas
	 */
	public void verTema(Tema tema) {
		uiListaMensajes.setTema(tema);
		display.setCurrent(uiListaMensajes);
	}
	
	/**
	 * Muestra el menú principal de la aplicación
	 *
	 */
	public void verMenu() {
		display.setCurrent(uiMenuPrincipal);
	}
	
	/**
	 * Abre la pantalla para la captura de una foto
	 *
	 */
	public void capturarFoto() {
		uiCapturaFoto.start();
		display.setCurrent(uiCapturaFoto);
	}
	
	/**
	 * Abre la pantalla para la confirmación del envío de la imagen
	 * capturada al servidor
	 * @param datos Bytes de la imagen, codificada en PNG
	 */
	public void confirmaCaptura(byte [] datos) {
		uiConfirmaFoto.setFoto(datos);
		display.setCurrent(uiConfirmaFoto);
	}

	/**
	 * Inicia el proceso de subida de una imagen al servidor, para
	 * establecerla como nuevo avatar
	 * @param login Login del usuario del que se va a cambiar el avatar
	 * @param password Password del usuario del que se va a cambiar el avatar
	 * @param datos Bytes de la imagen a subir, codificada en PNG
	 */
	public void subirFoto(String login, String password, byte [] datos) {
		Thread t = new HiloSubirFoto(login, password, datos);
		t.start();
	}
		
	/**
	 * Vuelve a mostrar el displayable especificado
	 * @param disp Displayable al que queremos volver
	 */
	public void volver(Displayable disp) {
		display.setCurrent(disp);
	}

	/**
	 * Sale de la aplicación
	 *
	 */
	public void salir() {
		try {
			this.destroyApp(true);
		} catch (MIDletStateChangeException e) { }

		this.notifyDestroyed();
	}
	
	protected void startApp() throws MIDletStateChangeException {
		verMenu();
		
		// Comprueba mensajes entrantes de aviso
		String [] conexiones = PushRegistry.listConnections(false);
		for(int i=0;i<conexiones.length;i++) {
			try {
				RecepcionSMS sms = new RecepcionSMS(this, conexiones[i]);
				sms.start();
			} catch (IOException e) {
				e.printStackTrace();
			}	
		}
	}

	protected void pauseApp() {
	}

	protected void destroyApp(boolean arg0) throws MIDletStateChangeException {
	}

	/**
	 * Hilo que realiza el proceso de subida de una foto al servidor
	 *
	 */
	class HiloSubirFoto extends Thread {
		String login;
		String password;
		byte [] datos;
		
		public HiloSubirFoto(String login, String password, byte [] datos) {
			this.login = login;
			this.password = password;
			this.datos = datos;
		}

		public void run() {
			try {
				// Muestra la barra de progreso
				uiProgreso.reset("Subiendo imagen", 10, 0, true);
				display.setCurrent(uiProgreso);

				// Sube el nuevo avatar al servidor
				remoto.cambiarAvatar(login, password, datos);
				
				// Detiene la barra de progreso
				uiProgreso.stop();
				
				// Vuelve al menu principal
				verMenu();
				
			} catch (IOException e) {
				Alert a = new Alert("Error", e.getMessage(), null, AlertType.ERROR); 
				display.setCurrent(a, uiConfirmaFoto);

				e.printStackTrace();
			}			
		}
	}

	/** 
	 * Hilo que descarga la lista de foros del servidor, y una vez 
	 * descargados los muestra en el móvil
	 *
	 */
	class HiloVerForos extends Thread {
		public void run() {
			try {

				// Muestra la barra de progreso
				uiProgreso.reset("Descargando datos", 10, 0, true);
				display.setCurrent(uiProgreso);

				// Descarga la lista de foros del servidor
				Foro [] foros = remoto.getForos();
				
				// Muestra la lista de foros en la pantalla del móvil
				verForos(foros);
				
				// Detiene la barra de progreso
				uiProgreso.stop();
				
			} catch (IOException e) {
				Alert a = new Alert("Error", e.getMessage(), null, AlertType.ERROR); 
				display.setCurrent(a, uiMenuPrincipal);
				
				e.printStackTrace();
			}
		}		
	}
	
	class HiloVerTemas extends Thread {
		String idforo;
		public HiloVerTemas(String idforo){
			this.idforo=idforo;
		}
		public void run() {
			try {

				// Muestra la barra de progreso
				uiProgreso.reset("Descargando datos", 10, 0, true);
				display.setCurrent(uiProgreso);

				// Descarga el foro con la lista de temas del servidor
				Foro foro = remoto.getForo(idforo);
				
				// Muestra la lista de temas en la pantalla del móvil
				verForo(foro);
				
				// Detiene la barra de progreso
				uiProgreso.stop();
				
			} catch (IOException e) {
				Alert a = new Alert("Error", e.getMessage(), null, AlertType.ERROR); 
				display.setCurrent(a, uiMenuPrincipal);
				
				e.printStackTrace();
			}
		}		
	}
	
	class HiloVerMensajes extends Thread {
		String idtema;
		public HiloVerMensajes(String idtema){
			this.idtema=idtema;
		}
		public void run() {
			try {

				// Muestra la barra de progreso
				uiProgreso.reset("Descargando datos", 10, 0, true);
				display.setCurrent(uiProgreso);

				// Descarga el tema con su lista de mensajes del servidor
				Tema tema = remoto.getTema(idtema);
				
				// Muestra la lista de mensajes en la pantalla del móvil
				verTema(tema);
				
				// Detiene la barra de progreso
				uiProgreso.stop();
				
			} catch (IOException e) {
				Alert a = new Alert("Error", e.getMessage(), null, AlertType.ERROR); 
				display.setCurrent(a, uiMenuPrincipal);
				
				e.printStackTrace();
			}
		}		
	}
}
