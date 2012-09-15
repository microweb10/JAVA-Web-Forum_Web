package tw.ui;

import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.List;

import tw.MIDletForos;

public class MenuPrincipalUI extends List implements CommandListener {

	MIDletForos midlet;
	
	int iVerForos;
	int iCaptura;
	int iSalir;

	Command cmdSelec;
	Command cmdSalir;
	
	public MenuPrincipalUI(MIDletForos midlet) {
		super("Foros", List.IMPLICIT);
		
		this.midlet = midlet;
		
		iVerForos = this.append("Ver foros", null);
		iCaptura = this.append("Cambiar avatar", null);
		iSalir = this.append("Salir", null);
		
		cmdSelec = new Command("Seleccionar", Command.OK, 1);
		cmdSalir = new Command("Salir", Command.EXIT, 1);
		
		this.addCommand(cmdSelec);
		this.addCommand(cmdSalir);
		
		this.setCommandListener(this);
	}

	public void commandAction(Command cmd, Displayable disp) {
		if(cmd==List.SELECT_COMMAND || cmd==cmdSelec) {
			 if(this.getSelectedIndex()==iVerForos) {
			 	 midlet.verForos();			
			 } else if(this.getSelectedIndex()==iCaptura) {
				 midlet.capturarFoto();
			 } else if(this.getSelectedIndex()==iSalir) {
				 midlet.salir();
			 }
		} else if(cmd==cmdSalir) {
			midlet.salir();
		}
	}

}
