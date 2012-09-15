function ordenarTabla(nomTabla,modo) {

 tbody = document.getElementById(nomTabla);
 filas = tbody.getElementsByTagName("tr");

 if(modo == "des"){ // Si queremos ordenar Descentdentemente

   if (filas.length > '2'){     // Vemos si existen filas en la tabla
      arrayOrd = new Array();   // creo un nuevo array donde iran las filas ya ordenadas
      i = 2;
      while (i<filas.length){  // Recorremos todas las filas (menos las 2 de cabecera)
	 j = 2;
	 maxim = 0;
	 while (j<filas.length){  // Obtengo el numero fila con el valor maximo de numero de mensajes
	    columnas = filas[j].getElementsByTagName("td");
            numMens = parseInt(columnas[2].firstChild.nodeValue);
	    if (numMens >= maxim){
	       maxim = numMens;
	       fila = j;
            }
	 j += 1;
	 }
	 // Obtengo la fila en si
	 columnas = filas[fila].getElementsByTagName("td");
	 // creamos una fila igual a la que tiene mayor numero de mensajes
	 // Primero todas las celdas
	 celda0 = document.createElement("td");
	 celda0.appendChild(columnas[0].firstChild);
	 celda1 = document.createElement("td");
	 celda1.appendChild(document.createTextNode(columnas[1].firstChild.nodeValue));
         celda2 = document.createElement("td");
	 celda2.appendChild(document.createTextNode(columnas[2].firstChild.nodeValue));
         celda3 = document.createElement("td");
	 celda3.appendChild(document.createTextNode(columnas[3].firstChild.nodeValue));
	 
	 // ahora lo meto en el array Ordenado en su posicion corrspondiente
	 arrayOrd[i-2] = document.createElement("tr");
	 arrayOrd[i-2].appendChild(celda0);
	 arrayOrd[i-2].appendChild(celda1);
	 arrayOrd[i-2].appendChild(celda2);
	 arrayOrd[i-2].appendChild(celda3);
	 // pongo el valor del numero de mensajes para esa fila en el documento a -1 para no volver a copiar la misma fila
	 columnas[2].firstChild.nodeValue = "-1";
         i += 1;
      }
      // ahora tengo que meter las filas ordenadas del array en el documento
      while (filas.length > '2') // Elimino las filas actuales
         tbody.removeChild(filas[2]);
      i = 0;
      while (i<arrayOrd.length){ // Introduzco ordenadas las filas en el documento
         tbody.appendChild(arrayOrd[i]);
         i += 1;
      }
   }
 }
 else
 if (modo == "asc"){    // Si queremos ordenar Ascendentemente
   if (filas.length > '2'){     // Vemos si existen filas en la tabla
      arrayOrd = new Array();   // creo un nuevo array donde iran las filas ya ordenadas
      i = 2;
      while (i<filas.length){  // Recorremos todas las filas (menos las 2 de cabecera)
         j = 2;
         minim = -1;
         while (j<filas.length){  // Obtengo el numero fila con el valor minimo de numero de mensajes
            columnas = filas[j].getElementsByTagName("td");
            numMens = parseInt(columnas[2].firstChild.nodeValue);
            if (minim == -1){
               minim = numMens;
	       fila = j;
            }else
	       if ((numMens != -1)&&(numMens < minim)){
                  minim = numMens;
	          fila = j;
	       }
	    j += 1;
         }
         // Obtengo la fila en si
         columnas = filas[fila].getElementsByTagName("td");
         // creamos una fila igual a la que tiene mayor numero de mensajes
         // Primero todas las celdas
         celda0 = document.createElement("td");
         celda0.appendChild(columnas[0].firstChild);
         celda1 = document.createElement("td");
         celda1.appendChild(document.createTextNode(columnas[1].firstChild.nodeValue));
         celda2 = document.createElement("td");
         celda2.appendChild(document.createTextNode(columnas[2].firstChild.nodeValue));
         celda3 = document.createElement("td");
         celda3.appendChild(document.createTextNode(columnas[3].firstChild.nodeValue));

         // ahora lo meto en el array Ordenado en su posicion corrspondiente
         arrayOrd[i-2] = document.createElement("tr");
         arrayOrd[i-2].appendChild(celda0);
         arrayOrd[i-2].appendChild(celda1);
         arrayOrd[i-2].appendChild(celda2);
         arrayOrd[i-2].appendChild(celda3);

        // pongo el valor del numero de mensajes para esa fila en el documento a -1 para no volver a copiar la misma fila
        columnas[2].firstChild.nodeValue = "-1";
        i += 1;
      }
      // ahora tengo que meter las filas ordenadas del array en el documento
      while (filas.length > '2') // Elimino las filas actuales
      tbody.removeChild(filas[2]);
      i = 0;
      while (i<arrayOrd.length){ // Introduzco ordenadas las filas en el documento
         tbody.appendChild(arrayOrd[i]);
         i += 1;
      }
   }
 }
}
