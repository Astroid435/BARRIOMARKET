// Obtener los elementos del DOM
const modals = {
    VentanaFabricante: document.getElementById("VentanaFabricante"),
    VentanaCrearFabricante: document.getElementById("VentanaCrearFabricante"),
    VentanaSubcategoria: document.getElementById("VentanaSubcategoria"),
    VentanaCrearSubcategoria: document.getElementById("VentanaCrearSubcategoria"),
    VentanaCategoria: document.getElementById("VentanaCategoria"),
    VentanaCrearCategoria: document.getElementById("VentanaCrearCategoria")
};

const buttons = {
    btnAñadirFabricante: document.getElementById("btnAñadirFabricante"),
    btnCrearFabricante: document.getElementById("btnCrearFabricante"),
    btnAñadirCategoria: document.getElementById("btnAñadirCategoria"),
    btnCrearCategoria: document.getElementById("btnCrearCategoria"),
    btnAñadirSubcategoria: document.getElementById("btnAñadirSubcategoria"),
    btnCrearSubcategoria: document.getElementById("btnCrearSubcategoria")
};

const closes = {
    closeAF: document.querySelector(".closeAF"),
    closeCF: document.querySelector(".closeCF"),
    closeAC: document.querySelector(".closeAC"),
    closeCC: document.querySelector(".closeCC"),
    closeAS: document.querySelector(".closeAS"),
    closeCS: document.querySelector(".closeCS")
};

// Abrir el modal cuando se haga clic en el botón
buttons.btnAñadirFabricante.onclick = function() {
    modals.VentanaFabricante.style.display = "block";
}
buttons.btnCrearFabricante.onclick = function() {
    modals.VentanaCrearFabricante.style.display = "block";
}
buttons.btnAñadirCategoria.onclick = function() {
    modals.VentanaCategoria.style.display = "block";
}
buttons.btnCrearCategoria.onclick = function() {
    modals.VentanaCrearCategoria.style.display = "block";
}
buttons.btnAñadirSubcategoria.onclick = function() {
    modals.VentanaSubcategoria.style.display = "block";
}


buttons.btnCrearSubcategoria.onclick = function() {
    modals.VentanaCrearSubcategoria.style.display = "block";
}

// Cerrar el modal cuando se haga clic en el botón de cierre
closes.closeAF.onclick = function() {
    modals.VentanaFabricante.style.display = "none";
}

closes.closeCF.onclick = function() {
    modals.VentanaCrearFabricante.style.display = "none";
}

closes.closeAC.onclick = function() {
    modals.VentanaCategoria.style.display = "none";
}

closes.closeCC.onclick = function() {
    modals.VentanaCrearCategoria.style.display = "none";
}

closes.closeAS.onclick = function() {
    modals.VentanaSubcategoria.style.display = "none";
}

closes.closeCS.onclick = function() {
    modals.VentanaCrearSubcategoria.style.display = "none";
}

// Cerrar el modal cuando se haga clic fuera del contenido del modal
window.onclick = function(event) {
    for (let modalKey in modals) {
        if (event.target == modals[modalKey]) {
            modals[modalKey].style.display = "none";
        }
    }
}