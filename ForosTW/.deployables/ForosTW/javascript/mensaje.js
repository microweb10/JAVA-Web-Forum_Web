function insrSmil(smil) { //Funcion que inserta una secuencia de escape en el textarea

   if ((document.FormNuevoMensaje.texto.selectionStart)||(document.FormNuevoMensaje.texto.selectionStart == 0)) {   //Estamos en Mozilla
      mens = document.FormNuevoMensaje.texto;
      if (mens.selectionEnd == mens.value.length){ //si queremos insertar al final
         document.FormNuevoMensaje.texto.value += smil;
      }
      else{
         if (mens.selectionEnd == '0'){  //si queremos insertar al principio
            parte2 = mens.value.substring(0,mens.value.length);
            textoFin = smil + parte2;
            document.FormNuevoMensaje.texto.value = textoFin;
         }
         else{  //si queremos insertar por el interior
            parte1 = mens.value.substring(0,mens.selectionStart);
            parte2 = mens.value.substring(mens.selectionEnd,mens.value.length);
            textoFin = parte1 + smil + parte2;
            document.FormNuevoMensaje.texto.value = textoFin;
         }
      }
   }
   else{
      if (document.selection){   //Estamos en Explorer
         seleccion="";
         document.FormNuevoMensaje.texto.focus();
         seleccion = document.selection.createRange().text;
         document.selection.createRange().text = seleccion + smil;
         delete seleccion;
      }
      else document.FormNuevoMensaje.texto.value += smil;
   }
}

function formato(tipo){ // Funcion que pone en el textarea formato negrita,cursiva,subrayado en HTML
   if ((document.FormNuevoMensaje.texto.selectionStart)||(document.FormNuevoMensaje.texto.selectionStart == 0)) {   //Estamos en Mozilla
         mens = document.FormNuevoMensaje.texto;
	 parte1 = mens.value.substring(0,mens.selectionStart);
         parte2 = mens.value.substring(mens.selectionEnd,mens.value.length);
         seleccion = mens.value.substring(mens.selectionStart,mens.selectionEnd);
         resultado = "<" + tipo + ">" + seleccion + "</" + tipo + ">";
         textoFin = parte1 + resultado + parte2;
         document.FormNuevoMensaje.texto.value = textoFin;
   }
   else{
      if (document.selection){   //Estamos en Explorer
         seleccion="";
         document.FormNuevoMensaje.texto.focus();
         seleccion = document.selection.createRange().text;
         resultado = "<" + tipo + ">" + seleccion + "</" + tipo + ">";
         document.selection.createRange().text = resultado;
      }
      else document.FormNuevoMensaje.texto.value += "<" + tipo + ">" + "</" + tipo + ">";
   }
}

function insrUrl(){ // Funcion que inserta en el textarea un enlace en formato HTML
   dirurl = prompt("POR FAVOR, INTRODUZCA LA DIRECCION URL","");
   enlace = prompt("POR FAVOR, INTRODUCE EL NOMBRE DEL ENLACE A LA URL","");
   if ((document.FormNuevoMensaje.texto.selectionStart)||(document.FormNuevoMensaje.texto.selectionStart == 0)) {   //Estamos en Mozilla
      mens = document.FormNuevoMensaje.texto;
      parte1 = mens.value.substring(0,mens.selectionStart);
      parte2 = mens.value.substring(mens.selectionEnd,mens.value.length);
      seleccion = mens.value.substring(mens.selectionStart,mens.selectionEnd);
      resultado = parte1 + "<a href=\"" + dirurl + "\">" + enlace + "</a>" + seleccion + parte2;
      document.FormNuevoMensaje.texto.value = resultado;
   }
   else{
      if (document.selection){   //Estamos en Explorer
         document.FormNuevoMensaje.texto.focus();
         seleccion = document.selection.createRange().text;
         resultado = "<a href=\"" + dirurl + "\">" + enlace + "</a>" + seleccion;
         document.selection.createRange().text = resultado;
      }
      else document.FormNuevoMensaje.texto.value += "<a href=\"" + dirurl + "\">" + enlace + "</a>"

   }
}

function prevMensaje(){ // Funcion que muestra debajo del formulario como se quedaria el mensaje (Previsualizar)
   if ((document.FormNuevoMensaje.texto.selectionStart)||(document.FormNuevoMensaje.texto.selectionStart == 0)) {   //Estamos en Mozilla
      mens = document.FormNuevoMensaje.texto;
      if (!mens.value)
         alert("No hay texto para mostrar en el Mensaje. Por Favor Escriba Algo.");
      else{
         texto = mens.value;
         finaltext = "";
         i = 0;
         while(i<parseInt(texto.length)){
            if(texto.charAt(i)!='['){  // si no se detecta que pueda empezar una secuencia de smil continuamos copiando
	       finaltext += texto.charAt(i);
               i = i+1;
	    }
	    else{  // comprobamos que sea una secuencia de smil completa
	       if((texto.charAt(i+1)==':')&&(texto.charAt(i+2)=='-')&&(texto.charAt(i+4)==']')){
                  switch(texto.charAt(i+3)){   //comprobamos que dicha secuencia la tenemos
                     case ')': imagen = "<img src=\"smilies/feliz.gif\"></img>"; control=1; break;
		     case '(': imagen = "<img src=\"smilies/triste.gif\"></img>"; control=1; break;
		     case '/': imagen = "<img src=\"smilies/enojado.gif\"></img>"; control=1; break;
		     case '$': imagen = "<img src=\"smilies/durmiendo.gif\"></img>"; control=1; break;
		     case '%': imagen = "<img src=\"smilies/colorado.gif\"></img>"; control=1; break;
		     case '!': imagen = "<img src=\"smilies/exclamacion.gif\"></img>"; control=1; break;
		     default: control=0;
                  }
                  if(control == 1){ // si dicha secuencia la tenemos la insertamos
                     finaltext += imagen;
		     i = i+5; // avanzamos tantas posiciones como caracteres tiene la secuencia
                  }
		  else{  // si dicha secuencia no la tenemos continuamos copiando
                     finaltext += texto.charAt(i);
                     i = i+1;
	          }
               }
	       else{  // si no es una secuencia de smil continuamos copiando
                  finaltext += texto.charAt(i);
                  i = i+1;
	       }
            }
         }
         //cambiar contenido del div prevMensaje
         if (document.getElementById){
            mensajeprevio = document.getElementById("prevMensaje");
            mensajeprevio.innerHTML = finaltext;
         }
         else alert("No se puede previsualizar el mensaje. Detectadas Incompatibilidades.");
      }
   }
   else{
      if (document.selection){   //Estamos en Explorer
         mens = document.FormNuevoMensaje.texto;
	 if (!mens.firstChild)
            alert("No hay texto para mostrar en el Mensaje. Por Favor Escriba Algo.");
         else{
	    texto = mens.firstChild.nodeValue;
	    finaltext = "";
            i = 0;
            while(i<parseInt(texto.length)){
               if(texto.charAt(i)!='['){  // si no se detecta que pueda empezar una secuencia de smil continuamos copiando
	          finaltext += texto.charAt(i);
                  i = i+1;
	       }
	       else{  // comprobamos que sea una secuencia de smil completa
	          if((texto.charAt(i+1)==':')&&(texto.charAt(i+2)=='-')&&(texto.charAt(i+4)==']')){
                     switch(texto.charAt(i+3)){   //comprobamos que dicha secuencia la tenemos
                        case ')': imagen = "<img src=\"smilies/feliz.gif\"></img>"; control=1; break;
		        case '(': imagen = "<img src=\"smilies/triste.gif\"></img>"; control=1; break;
		        case '/': imagen = "<img src=\"smilies/enojado.gif\"></img>"; control=1; break;
		        case '$': imagen = "<img src=\"smilies/durmiendo.gif\"></img>"; control=1; break;
		        case '%': imagen = "<img src=\"smilies/colorado.gif\"></img>"; control=1; break;
		        case '!': imagen = "<img src=\"smilies/exclamacion.gif\"></img>"; control=1; break;
		        default: control=0;
                     }
                     if(control == 1){ // si dicha secuencia la tenemos la insertamos
                        finaltext += imagen;
		        i = i+5; // avanzamos tantas posiciones como caracteres tiene la secuencia
                     }
		     else{  // si dicha secuencia no la tenemos continuamos copiando
                        finaltext += texto.charAt(i);
                        i = i+1;
	             }
                  }
	          else{  // si no es una secuencia de smil continuamos copiando
                     finaltext += texto.charAt(i);
                     i = i+1;
	          }
               }
            }
            //cambiamos el contenido del div prevMensaje
            if (document.getElementById){
               mensajeprevio = document.getElementById("prevMensaje");
               mensajeprevio.innerHTML = finaltext;
            }
            else alert("No se puede previsualizar el mensaje. Detectadas Incompatibilidades.");
         }
      }
      else alert("No se puede previsualizar el mensaje. Detectadas Incompatibilidades.");
   }
}

