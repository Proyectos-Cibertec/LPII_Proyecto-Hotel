function validarSoloNumerosEnteros(e) { // 1
	    tecla = (document.all) ? e.keyCode : e.which; // 2
	    if (tecla==8) return true; // 3
	    patron = /[0123456789]/;// Solo acepta números
	    te = String.fromCharCode(tecla); // 5
	    return patron.test(te); // 6
}