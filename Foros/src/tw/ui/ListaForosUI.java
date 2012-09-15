package tw.ui;

import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.List;

import tw.MIDletForos;
import tw.datos.Foro;

public class ListaForosUI extends List implements CommandListener {

	Foro [] foros;
	
	MIDletForos midlet;
	
	Command cmdSelec;
	Command cmdAtras;
	
	public ListaForosUI(MIDletForos midlet) {
		super("Foros", List.IMPLICIT);
		
		this.midlet = midlet;
		
		cmdSelec = new Command("Seleccionar", Command.SCREEN, 1);
		cmdAtras = new Command("Atras", Command.BACK, 1);
		
		this.addCommand(cmdSelec);
		this.addCommand(cmdAtras);
		
		this.setCommandListener(this);
	}
	
	public void setForos(Foro [] foros) {
		this.deleteAll();

		this.foros = foros;
		
		for(int i=0;i<foros.length;i++) {//rellenamos la pantalla con los titulos de los foros
			this.append(foros[i].getTitulo(), null);
		}
	}

	public void commandAction(Command cmd, Displayable disp) {
		if(cmd==List.SELECT_COMMAND || cmd==cmdSelec) {
			if(getSelectedIndex()>=0 && getSelectedIndex()<foros.length) {
				midlet.verForo(foros[this.getSelectedIndex()].getId() + "");				
			}
		} else if(cmd==cmdAtras) {
			midlet.verMenu();
		}
	}

}
