package tw.ui;

import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.List;

import tw.MIDletForos;
import tw.datos.Foro;

public class ListaTemasUI extends List implements CommandListener {

	Foro foro;
	
	MIDletForos midlet;
	
	Command cmdSelec;
	Command cmdAtras;
	
	public ListaTemasUI(MIDletForos midlet) {
		super("TEMAS DEL FORO", List.IMPLICIT); //foro.getTitulo()
		
		this.midlet = midlet;
		
		cmdSelec = new Command("Seleccionar", Command.SCREEN, 1);
		cmdAtras = new Command("Atras", Command.BACK, 1);
		
		this.addCommand(cmdSelec);
		this.addCommand(cmdAtras);
		
		this.setCommandListener(this);
	}
	
	public void setForo(Foro foro) {
		this.deleteAll();
		
		this.foro = foro;
		
		for(int i=0;i<foro.getTemas().length;i++) {//rellenamos la pantalla con los titulos de los temas del foro
			this.append(foro.getTemas()[i].getAsunto(), null);
		}
	}

	public void commandAction(Command cmd, Displayable disp) {
		if(cmd==List.SELECT_COMMAND || cmd==cmdSelec) {
			if(getSelectedIndex()>=0 && getSelectedIndex()<foro.getTemas().length) {
				midlet.verTema(foro.getTemas()[this.getSelectedIndex()].getId() + "");				
			}
		} else if(cmd==cmdAtras) {
			midlet.verForos();
		}
	}

}
