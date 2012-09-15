package tw.datos;

import java.io.IOException;

import javax.microedition.io.Connector;
import javax.wireless.messaging.MessageConnection;
import javax.wireless.messaging.TextMessage;

import tw.MIDletForos;

public class RecepcionSMS extends Thread {

	MIDletForos midlet;
	
	MessageConnection mc;
	
	public RecepcionSMS(MIDletForos midlet, String url) throws IOException {
		mc = (MessageConnection) Connector.open(url);
		this.midlet = midlet;
	}
	
	public void run() {
		
		while(true) {
			// TODO: Recibe un SMS de la conexion mc y muestra los
			// mensajes del tema solicitado en la pantalla del
			// movil (el texto del mensaje será el identificador
			// del tema solicitado)
			try{
				TextMessage msg = (TextMessage) mc.receive();
				String idtema = msg.getPayloadText();
				midlet.verTema(idtema);
			} catch (IOException e) {
				e.printStackTrace();
			}	
		}
		
	}
	
}
