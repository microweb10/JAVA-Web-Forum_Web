package tw.ui;

import javax.microedition.lcdui.Canvas;
import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Graphics;
import javax.microedition.media.Manager;
import javax.microedition.media.MediaException;
import javax.microedition.media.Player;
import javax.microedition.media.control.VideoControl;

import tw.MIDletForos;

public class CapturaFotoUI extends Canvas implements CommandListener, Runnable {

	MIDletForos midlet;
	
	Command cmdCaptura;
	Command cmdCancelar;
	
	VideoControl vc;
	Player p; 

	public CapturaFotoUI(MIDletForos midlet) {

		this.midlet = midlet;
		
		// Crea comandos
		cmdCaptura = new Command("Captura", Command.SCREEN, 1);
		cmdCancelar = new Command("Cancelar", Command.CANCEL, 1);
		
		this.addCommand(cmdCaptura);
		this.addCommand(cmdCancelar);
		
		this.setCommandListener(this);

		try {

			// Crea reproductor
			p = Manager.createPlayer("capture://video");
			p.realize();

			// Crea control de video
			vc = (VideoControl)p.getControl("VideoControl");
			vc.initDisplayMode(VideoControl.USE_DIRECT_VIDEO, this);
			vc.setDisplayLocation(0,0);
			vc.setDisplaySize(this.getWidth(), this.getHeight());
			vc.setVisible(true);

		} catch(Exception e) {
			System.err.println("Error al crear video");
		}

	}

	public void start() {
		// Comienza la reproducción
		try {
			p.start();
		} catch(Exception e) {
			System.err.println("Error al reproducir");
		}		
	}
	
	public void stop() {
		// Detiene la reproducción
		try {
			p.stop();
			p.deallocate();
		} catch (MediaException e) {
			System.err.println("Error al detener");
		}
	}
	
	public byte [] snap() {
		// Captura una imagen del video tomado por la cámara
		try {
			return vc.getSnapshot(null);
		} catch (MediaException e) {
			return null;
		}
	}
	
	protected void paint(Graphics g) {
		// Dibuja fondo blanco
		g.setColor(0x00ffffff);
		g.fillRect(0,0,getWidth(), getHeight());
	}

	public void commandAction(Command cmd, Displayable disp) {
		if(cmd == cmdCaptura) {
			Thread t = new Thread(this);
			t.start();
		} else if(cmd == cmdCancelar) {
			this.stop();
			midlet.verMenu();
		}
	}

	public void run() {
		byte [] datos = this.snap();
		this.stop();
		midlet.confirmaCaptura(datos);		
	}	

}
