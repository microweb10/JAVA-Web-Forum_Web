//variables globales
var inc=75;    // pixeles que avanza el aviso (incremento de la propiedad left del aviso
var timer;     // variable del temporizador para la animacion
var timer2;    // variable del temporizador para las peticiones al servidor
var veloc=250;  // velocidad de la animacion (vel. de salida y parpadeo)
var petic=5000;   // cada cuanto hace peticiones al servidor (5 segundos)


      // Objeto para la animacion del aviso (reglas del aviso)
   if(document.styleSheets[0].cssRules)  // navegador Estardar
      reglas = document.styleSheets[0].cssRules;
   else if(document.styleSheets[0].rules)   // navegador Explorer
	    reglas = document.styleSheets[0].rules;
	else alert("El cambio de reglas no es compatible con su navegador");

       // Activamos Temporizador para las peticiones AJAX (Nuevos Mensajes)
   timer2 = setInterval("mensNuevos()",petic);
   
function mensNuevos() {

   if (window.XMLHttpRequest)           // Estamos en Mozilla...
      peticion = new XMLHttpRequest();
   else
      if (window.ActiveXObject)         // Estamos en Explorer...
         peticion = new ActiveXObject("Microsoft.XMLHTTP");
   peticion.onreadystatechange = atenderPeticion;
   peticion.open("GET","nuevos.txt",true);
   peticion.send(null);
}


function atenderPeticion() {
   if (peticion.readyState == 4) {
      //analizar respuesta
      if (peticion.status == 500)
         alert("el servidor ha respondido con un error");
      else{                       // Si la peticion es CORRECTA la procesamos
	 mensnuevos = peticion.responseText;
         if(mensnuevos.length){   // si hay mensajes nuevos para mostrar
	    array = mensnuevos.split(";");
	    parte1linkforo = "<a class=\"linkaviso\" href=\"foro.html\">";
	    parte1linktema = "<a class=\"linkaviso\" href=\"tema.html\">";
	    parte2link = "</a>";
            palabras = array[0].split("&");
            if (palabras[0] == "m")
	       tipo = "Mensaje";
	    else
	       tipo = "Tema";
            asunto = palabras[2];
            foro = palabras[3];
            linkforo = parte1linkforo + foro + parte2link;
            linktema = parte1linktema + asunto + parte2link;
            mensaje = "Nuevo " + tipo +" en el Foro " + linkforo + ". Asunto del mensaje: " + linktema + "  ";
	    //Cambiar el contenido del span mensajeAviso
	    if (document.getElementById){  // Comprobamos que funciona el DOM 1
               textoaviso = document.getElementById("mensajeAviso");
               textoaviso.innerHTML = mensaje;
	    }
	    else
               alert("El aviso dinamico no es compatible con su navegador./nNo podra visualizar los nuevos mensajes que lleguen al foro.");
            timer = setInterval("mostrarAviso(reglas)",veloc);
	 }
      }
   }
}

function mostrarAviso(reglas) {

   // Cambiamos el color del texto
   var col;
   col = reglas[1].style.color;
   if( (col == "#10148C") || (col == "#10148c") || (col == "rgb(16, 20, 140)") )
      reglas[1].style.color = "#FFFFA0"; // Amarillo
   else
      reglas[1].style.color = "#10148C"; // Azul Oscuro

   // Cambiamos la posicion del texto
   var x;
   x = parseInt(reglas[1].style.left);
   if (x<1){  // si el mensaje aun no esta mostrado por completo desplazamos
      x += inc;
      reglas[1].style.left = x+"px";
   }
}

function cerrarAviso(reglas,timer){

   clearInterval(timer);
   var x;
   x = 0;
   x -= 950;
   reglas[1].style.color = "#10148C";  // Azul Oscuro
   reglas[1].style.left = x+"px";      // Posicion Inicial (Escondido)

}
