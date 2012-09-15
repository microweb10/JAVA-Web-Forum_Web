package tw.ui;

import javax.microedition.lcdui.Form;

import javax.microedition.lcdui.Gauge;

import tw.MIDletForos;

public class BarraProgresoUI extends Form implements Runnable {

	Gauge barra;

	MIDletForos midlet;
	
	Thread tAuto;

	private static final long CICLO = 250;

	public BarraProgresoUI(MIDletForos midlet) {
		super("Progreso");

		this.midlet = midlet;

		barra = new Gauge("", false, 100, 0);
		this.append(barra);
	}

	/**
	 * Inicializa la barra de progreso y la pone en funcionamiento
	 * @param etiq Texto que se muestra junto a la barra
	 * @param valorMax Valor maximo de la barra
	 * @param valor Valor inicial de la barra
	 * @param auto Si es <code>true</code> la barra avanza automáticamente 
	 * cada cierto numero de milisegundos de forma cíclica. En caso contrario,
	 * se deberá llamar a <code>update</code> cada vez que queramos que avance.
	 */
	public void reset(String etiq, int valorMax, int valor, boolean auto) {
		barra.setLabel(etiq);
		barra.setMaxValue(valorMax);
		barra.setValue(valor);

		if (auto) {
			tAuto = new Thread(this);
			tAuto.start();
		} else {
			tAuto = null;
		}
	}

	/**
	 * Hace avanzar un posición la barra de progreso
	 */
	public void update() {
		int valor = barra.getValue();
		int valorMax = barra.getMaxValue();
		
		valor = (valor + 1) % valorMax;

		barra.setValue(valor);
	}

	/**
	 * Detiene el avance de la barra de progreso, en caso de ser automática
	 */
	public void stop() {
		tAuto = null;
	}

	public void run() {
		while (tAuto == Thread.currentThread()) {
			update();
			
			try {
				Thread.sleep(CICLO);
			} catch (InterruptedException e) {
			}
		}
	}
}