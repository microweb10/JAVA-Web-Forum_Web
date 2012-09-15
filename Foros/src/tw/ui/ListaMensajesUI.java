package tw.ui;

import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Form;
import javax.microedition.lcdui.Item;
import javax.microedition.lcdui.StringItem;

import tw.MIDletForos;
import tw.datos.Tema;

public class ListaMensajesUI extends Form implements CommandListener {

	Tema tema;
	
	MIDletForos midlet;
	
	Command cmdSelec;
	Command cmdAtras;
	
	public ListaMensajesUI(MIDletForos midlet) {
		super("MENSAJES DEL TEMA"); //foro.getTitulo()
		
		this.midlet = midlet;
		
		cmdAtras = new Command("Atras", Command.BACK, 1);
		
		this.addCommand(cmdAtras);
		
		this.setCommandListener(this);
	}
	
	public void setTema(Tema tema) {
		this.deleteAll();
		
		this.tema = tema;
		
		for(int i=0;i<tema.getMensajes().length;i++) {//rellenamos la pantalla con los mensajes del tema mostrando el autor y el texto del mensaje
			Item itemLogin = new StringItem("autor del mensaje:",tema.getMensajes()[i].getAutor());
			Item itemTexto = new StringItem("texto del mensaje:",tema.getMensajes()[i].getTexto());
			this.append(itemLogin);
			this.append(itemTexto);
		}
	}

	public void commandAction(Command cmd, Displayable disp) {
		if(cmd==cmdAtras) {
			midlet.verForo(tema.getIdForo() + "");
		}
	}

}
