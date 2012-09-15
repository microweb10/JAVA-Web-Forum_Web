package tw.ui;

import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Form;
import javax.microedition.lcdui.Image;
import javax.microedition.lcdui.TextField;

import tw.MIDletForos;

public class ConfirmaFotoUI extends Form implements CommandListener {

	MIDletForos midlet;
	
	Command cmdAceptar;
	Command cmdCancelar;
	
	TextField txtLogin;
	TextField txtPassword;
	
	byte [] datos;
	
	public ConfirmaFotoUI(MIDletForos midlet) {
		super("Confirmacion");

		this.midlet = midlet;

		cmdAceptar = new Command("OK", Command.OK, 1);
		cmdCancelar = new Command("Cancelar", Command.CANCEL, 1);
		
		this.addCommand(cmdAceptar);
		this.addCommand(cmdCancelar);
		
		this.setCommandListener(this);
	}

	public void setFoto(byte [] datos) {
		this.deleteAll();

		this.datos = datos;
		
		this.txtLogin = new TextField("Login", "", 32, TextField.ANY);
		this.txtPassword = new TextField("Password", "", 32, TextField.ANY | TextField.PASSWORD);
		
		Image img = Image.createImage(datos,0,datos.length);
		this.append(img);
		this.append("Introducir el login y password");
		this.append(txtLogin);
		this.append(txtPassword);
	}
	
	public void commandAction(Command cmd, Displayable disp) {
		if(cmd==cmdAceptar) {
			midlet.subirFoto(txtLogin.getString(), txtPassword.getString(), datos);
		} else if(cmd==cmdCancelar) {
			midlet.capturarFoto();
		}
	}

}
