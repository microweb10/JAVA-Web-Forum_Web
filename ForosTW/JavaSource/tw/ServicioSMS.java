package tw;

import java.io.IOException;

import com.sun.kvem.midp.io.j2se.wma.Message;
import com.sun.kvem.midp.io.j2se.wma.client.PhoneNumberNotAvailableException;
import com.sun.kvem.midp.io.j2se.wma.client.WMAClient;

public class ServicioSMS {

	private final static int PUERTO = 6442;
	
	WMAClient wtkClient;
	
	private static ServicioSMS instance = null;
	
	public ServicioSMS() {
        System.setProperty("kvem.home", "/usr/local/WTK2.2");
        
        // Con el primer parametro a null asigna automaticamente un numero de telefono al servidor
        // Tambien podemos especificar nosotros un numero, p.ej. "+5559999".
        wtkClient = new WMAClient(null, WMAClient.SEND_ONLY);
        
        try {
			wtkClient.connect();
		} catch (IOException e1) {
			e1.printStackTrace();
		} catch (PhoneNumberNotAvailableException e1) {
			e1.printStackTrace();
		}
        

	}

	public void sendTextMsg(String numero, String texto) {
		System.out.println("SMS: Enviando mensaje \"" + texto + "\" al numero " + numero);

		Message message = new Message(texto);
        message.setToAddress("sms://" + numero + ":" + PUERTO);
        message.setFromAddress("sms://" + wtkClient.getPhoneNumber());        
        try {
            wtkClient.send(message);
        } catch (Exception e) {
            System.err.println("Error enviando SMS: ");
            e.printStackTrace();
        }
		
	}
	
	public void sendBinaryMsg(String numero, byte [] datos) {
		System.out.println("SMS: Enviando mensaje binario al numero " + numero);

		Message message = new Message(datos);
        message.setToAddress("sms://" + numero + ":" + PUERTO);
        message.setFromAddress("sms://" + wtkClient.getPhoneNumber());        
        try {
            wtkClient.send(message);
        } catch (Exception e) {
            System.err.println("Error enviando SMS: ");
            e.printStackTrace();
        }
		
	}
	
	public static ServicioSMS getInstance() {
		if(instance==null) {
			instance = new ServicioSMS();
		}
		return instance;
	}
}
