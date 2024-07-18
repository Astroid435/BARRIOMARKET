<?php 
include "conexion.php";
if(isset($_POST['btn_edit'])){
    $idproducto=$_POST['idproducto'];
            $consulta = mysqli_query($conexion, "SELECT * FROM productos;") or die($conexion . "Error en la consulta");
            $cantidad = mysqli_num_rows($consulta);
            if ($cantidad > 0) {
                while ($fila = mysqli_fetch_array($consulta)) {
                    $nombre = $fila['Nombre'];
                    $ValorVenta = $fila['ValorVenta'];
                    $idfabricante = $fila['Fabricante_idFabricante'];
                    $cantidad = $fila['Cantidad'];
                    $idproducto = $fila['idProductos'];
                    $imagen= $fila['imagen'];
                    $var = 1;
                    $consultafabricante = mysqli_query($conexion, "SELECT * FROM `fabricante` WHERE `idFabricante` = $idfabricante;") or die($conexion . "Error en la consulta");
                    if ($fila = mysqli_fetch_array($consultafabricante)) {
                        $nombrefabricante = $fila['Nombre'];
                    }
                    $consultasubcategorias = mysqli_query($conexion, "SELECT * FROM `productoscategoria` WHERE `Productos_idProductos` = $idproducto;") or die($conexion . "Error en la consulta");
                    if ($fila = mysqli_fetch_array($consultasubcategorias)) {
                        $idsubcategoria = $fila['Subcategoria_idSubcategoria'];
                        $consultacategoria = mysqli_query($conexion, "SELECT * FROM `subcategoria` WHERE `idSubcategoria` = $idsubcategoria;") or die($conexion . "Error en la consulta");
                        if ($fila = mysqli_fetch_array($consultacategoria)) {
                            $idcategoria = $fila['idCategoria'];
                            $consultanombrecategoria = mysqli_query($conexion, "SELECT * FROM `categoria` WHERE `idCategoria` = $idcategoria;") or die($conexion . "Error en la consulta");
                            if ($fila = mysqli_fetch_array($consultanombrecategoria)) {
                                $nombrecategoria = $fila['Nombre'];
                            }
                        }
                    }

                                $consultasubcategorias2 = mysqli_query($conexion, "SELECT * FROM `productoscategoria` WHERE `Productos_idProductos` = $idproducto;") or die($conexion . "Error en la consulta");
                                $subsubcategorias = array();
                                while ($fila = mysqli_fetch_array($consultasubcategorias2)) {
                                    $idsubcategoria = $fila['Subcategoria_idSubcategoria'];
                                    array_push($subsubcategorias, $idsubcategoria);
                                }
                                if (!empty($subsubcategorias)) {
                                    $subcategorias = implode(',', $subsubcategorias);
                                    $consultanombresubcategoria = mysqli_query($conexion, "SELECT * FROM `subcategoria` WHERE `idSubcategoria` IN ($subcategorias)") or die($conexion . "Error en la consulta");
                                    while ($fila = mysqli_fetch_array($consultanombresubcategoria)) {

                                    }
                                }


                }
            }

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['fabricanteSeleccionado'])) {
    // Guardar el fabricante seleccionado en una variable de sesión
    $_SESSION['fabricanteSeleccionadoId'] = $_POST['fabricanteSeleccionadoId'];
}
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['CategoriaSeleccionado'])) {
    // Guardar el fabricante seleccionado en una variable de sesión
    $_SESSION['CategoriaSeleccionadoId'] = $_POST['CategoriaSeleccionadoId'];
}
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['SubcategoriaSeleccionadas'])) {
        // Obtener el array de subcategorías seleccionadas
        $subcategoriasSeleccionadas = json_decode($_POST['SubcategoriaSeleccionadoId'], true);

        // Guardar el array en la sesión
        $_SESSION['SubcategoriaSeleccionadoId'] = $subcategoriasSeleccionadas;
    }
}
?>

<form action="./codigo_productos.php" method="post" id="AgregarProductos" enctype="multipart/form-data">
    <div class="container">
        <h1 style="font-size: 57px; font-weight: bold;">Registro de producto</h1>
        <h6 style="color: #828282;">Llena todos los campos para continuar</h6>
        <br>
        <div class="row">
            <div class="col-md-6">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-6">
                            <label for="exampleInputEmail1">Nombre</label>
                            <div class="col">
                                <input type="text" class="form-control" placeholder="Ej: Cartulina*" name="Nombre" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="exampleInputEmail1">Cantidad Producto</label>
                            <div class="col">
                                <input type="text" class="form-control" placeholder="Ej: 34*" name="Cantidad" required>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-6">
                            <label for="exampleInputEmail1">Valor venta</label>
                            <div class="col">
                                <input type="text" class="form-control" placeholder="Ej: 2500*" name="ValorVenta" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="exampleInputEmail1">Valor Compra</label>
                            <div class="col">
                                <input type="text" class="form-control" placeholder="Ej: 2000*" name="ValorCompra" required>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12">
                            <label for="exampleInputEmail1">Descripcion</label>
                            <div class="col">
                                <textarea type="text" class="form-control col-12" name="Descripcion" placeholder="Ej: Papel grueso especializado en pliegues para origami" requirted maxlength="150"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <center>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div id="btnAñadirFabricante" class="btn btn-fcs button col-12">Añadir fabricante</div>
                            </div>
                        </div>
                    </div>
                </center>
                <center>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div id="btnAñadirCategoria" class="btn button btn-fcs col-12">Añadir Categoria-Subcategoria</div>
                            </div>
                        </div>
                    </div>
                </center>
                <center>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <button type="submit" class="btn button btn-fcs col-12" id="btn_registro" name="btn_producto">Registrar</button>
                            </div>
                        </div>
                </center>

            </div>
            <div class="col-md-6">
                <label class="upload-container" for="imagen" id="upload-label">
                    <div class="upload-icon" id="upload-icon">+</div>
                    <div class="upload-text" id="upload-text">Agregar imagen de producto</div>
                    <input type="file" id="imagen" name="imagen" accept="image/*">
                </label>
            </div>
        </div>
    </div>
</form>


<div id="VentanaFabricante" class="modal">
    <div class="modal-content">
        <div class="container-fluid">
            <div class="row">
                <span class="close closeAF col-1" style="position: absolute;">&times;</span>
                <center>
                    <h1 class="titulo">Fabricantes</h1>
                </center>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <?php
                include "conexion.php";

                $consulta = $conexion->prepare("SELECT * FROM fabricante");
                $consulta->execute();
                $resultados = $consulta->get_result();

                while ($fila = $resultados->fetch_assoc()) {
                ?>
                    <div class="col-md-4 mb-3">
                        <div class="btn btn_consulta btn_fabricantes col-md-12 btn-fcsm button" name="btn_selector" onclick="selectFabricante(this, '<?php echo $fila['idFabricante']; ?>')">
                            <?php echo htmlspecialchars($fila['Nombre']); ?>
                        </div>
                    </div>
                <?php
                }
                ?>
                <div class="col-md-4 mb-3">
                    <div id="btnCrearFabricante" class="btn btn_consulta col-md-12 btn-fcsm button">+</div>
                </div>
            </div>
        </div>

        <center>
            <div class="container">
                <form id="registerForm" method="POST" action="">
                    <input type="hidden" name="fabricanteSeleccionadoId" id="fabricanteSeleccionadoId">
                    <button type="submit" class="btn button btn-fcs col-8" name="fabricanteSeleccionado" style="background-color:#000; color:#fff;" onclick="guardarYReiniciar()">Seleccionar</button>
                </form>
            </div>
        </center>
    </div>
</div>


<div id="VentanaCrearFabricante" class="modal">
    <div class="modal-content">
        <div class="container-fluid">
            <div class="row">
                <span class="close closeCF col-1" style="position: absolute;">&times;</span>
                <center>
                    <h1 class="titulo">Crear fabricante</h1>
                </center>
            </div>
        </div>
        <center>
            <form method="post" action="dashboard.php?mod=AgregarProductos" class="col-md-4">
                <label for="exampleInputEmail1">Nombre</label>
                <input type="text" class="form-control" name="nombre" placeholder="Ej: Matel">
                <label for="exampleInputEmail1">Telefono</label>
                <input type="text" class="form-control" name="telefono" placeholder="Ej: 3242974388">
                <button type="submit" class="btn btn_consulta col-md-12 btn-fcsm" name="btn_fabricante">Crear</button>
            </form>
        </center>
    </div>
</div>


<div id="VentanaCategoria" class="modal">
    <div class="modal-content">
        <div class="container-fluid">
            <div class="row">
                <span class="close closeAC col-1" style="position: absolute;">&times;</span>
                <center>
                    <h1 class="titulo">Categorias</h1>
                </center>
            </div>
        </div>
        <div class="container-fluid">
            <div class="row">
                <?php
                include "conexion.php";

                $consulta = $conexion->prepare("SELECT * FROM categoria");
                $consulta->execute();
                $resultados = $consulta->get_result();

                while ($fila = $resultados->fetch_assoc()) {
                ?>
                    <div class="col-md-4 mb-3">
                        <div class="btn btn_consulta col-md-12 btn-fcsm button btn_selectorSubcategoria" name="btn_selectorSubcategoria" onclick="selectCategoria(this, '<?php echo $fila['idCategoria']; ?>')">
                            <?php echo htmlspecialchars($fila['Nombre']); ?>
                        </div>
                    </div>
                <?php
                }
                ?>
                <div class="col-md-4">
                    <button id="btnCrearCategoria" class="btn btn_consulta col-md-12 btn-fcsm button">+</button>
                </div>
            </div>
        </div>
        <center>
            <div class="container">
                <form id="registerForm" method="POST" action="">
                    <input type="hidden" name="CategoriaSeleccionadoId" id="CategoriaSeleccionadoId">
                    <button type="submit" class="btn button btn-fcs col-8" name="CategoriaSeleccionado" id="btnAñadirSubcategoria" style="background-color:#000; color:#fff;" onclick="guardarYReiniciar()">Seleccionar</button>
                </form>
            </div>
        </center>
    </div>
</div>


<div id="VentanaCrearCategoria" class="modal">
    <div class="modal-content">
        <div class="container-fluid">
            <div class="row">
                <span class="close closeCF col-1" style="position: absolute;">&times;</span>
                <center>
                    <h1 class="titulo">Crear categoria</h1>
                </center>
            </div>
        </div>
        <center>
            <form method="post" action="dashboard.php?mod=AgregarProductos" class="col-md-4">
                <label for="exampleInputEmail1">Nombre</label>
                <input type="text" class="form-control" name="nombre" placeholder="Ej: Matel">
                <button type="submit" class="btn btn_consulta col-md-12 btn-fcsm" name="btn_categoria">Crear</button>
            </form>
        </center>
    </div>
</div>


<div id="VentanaSubcategoria" class="modal">
    <div class="modal-content">
        <div class="container-fluid">
            <div class="row">
                <span class="close closeAS col-1" style="position: absolute;">&times;</span>
                <center>
                    <h1 class="titulo">Subcategoria</h1>
                </center>
            </div>
        </div>
        <div class="container-fluid">
            <div class="row">
                <?php
                include "conexion.php";
                $categoria = $_SESSION['CategoriaSeleccionadoId'];
                $consulta = $conexion->prepare("SELECT * FROM subcategoria WHERE idCategoria = ?");
                $consulta->bind_param("i", $categoria);
                $consulta->execute();
                $resultados = $consulta->get_result();

                while ($fila = $resultados->fetch_assoc()) {
                ?>
                    <div class="col-md-4 mb-3">
                        <div class="btn btn_consulta col-md-12 btn-fcsm button btn_Subcategoria" name="btn_Subcategoria" onclick="selectSubcategoria(this, '<?php echo $fila['idSubcategoria']; ?>')">
                            <?php echo htmlspecialchars($fila['Nombre']); ?>
                        </div>
                    </div>
                <?php
                }
                ?>
                <div class="col-md-4">
                    <button id="btnCrearSubcategoria" class="btn btn_consulta col-md-12 btn-fcsm button">+</button>
                </div>
            </div>
        </div>
        <center>
            <div class="container">
                <form id="registerForm" method="POST" action="">
                    <input type="hidden" name="SubcategoriaSeleccionadoId" id="SubcategoriaSeleccionadoId">
                    <button type="submit" class="btn button btn-fcs col-8" name="SubcategoriaSeleccionadas" id="SubcategoriaSeleccionadas" style="background-color:#000; color:#fff;" onclick="guardarYReiniciar()">Seleccionar</button>
                </form>
            </div>
        </center>
    </div>
</div>


<div id="VentanaCrearSubcategoria" class="modal">
    <div class="modal-content">
    <div class="container-fluid">
            <div class="row">
                <span class="close closeCF col-1" style="position: absolute;">&times;</span>
                <center>
                    <h1 class="titulo">Crear subcategoria</h1>
                </center>
            </div>
        </div>
        <center>
            <form method="post" action="dashboard.php?mod=AgregarProductos" class="col-md-4">
                <label for="exampleInputEmail1">Nombre</label>
                <input type="text" class="form-control" name="nombre" placeholder="Ej: Matel">
                <button type="submit" class="btn btn_consulta col-md-12 btn-fcsm" name="btn_subcategoria">Crear</button>
            </form>
        </center>
    </div>
</div>


<?php
if (isset($_POST['btn_fabricante'])) {
    $nombre = $_POST['nombre'];
    $telefono = $_POST['telefono'];
    $consulta_numero = mysqli_query($conexion,  "SELECT * FROM fabricante WHERE Nombre = '$nombre';") or die($conexion . "Error en la consulta");
    $cantidad_numero = mysqli_num_rows($consulta_numero);
    if ($cantidad_numero > 0) {
        echo "<script>alert('Ese fabricante ya existe');</script>";
    } else {
        $registrar = mysqli_query($conexion, "INSERT INTO `fabricante` (`idFabricante`, `Nombre`, `Telefono`) VALUES (NULL, '$nombre', '$telefono');") or die($conexion);
        echo "<script>alert('Se registro correctamente');</script>";
        echo "<script>window.location='dashboard.php?mod=AgregarProductos' ;</script>";
    }
}
if (isset($_POST['btn_categoria'])) {
    $nombre = $_POST['nombre'];
    $consulta_numero = mysqli_query($conexion,  "SELECT * FROM categoria WHERE Nombre = '$nombre';") or die($conexion . "Error en la consulta");
    $cantidad_numero = mysqli_num_rows($consulta_numero);
    if ($cantidad_numero > 0) {
        echo "<script>alert('Esta categoria ya existe');</script>";
    } else {
        $registrar = mysqli_query($conexion, "INSERT INTO `categoria` (`idCategoria`, `Nombre`) VALUES (NULL, '$nombre');") or die($conexion);
        echo "<script>alert('Se registro correctamente');</script>";
        echo "<script>window.location='dashboard.php?mod=AgregarProductos' ;</script>";
    }
}
if (isset($_POST['btn_subcategoria'])) {
    $nombre = $_POST['nombre'];
    $categoria = $_SESSION['CategoriaSeleccionadoId'];
    $consulta_numero = mysqli_query($conexion,  "SELECT * FROM subcategoria WHERE Nombre = '$nombre' and idCategoria =  $categoria;") or die($conexion . "Error en la consulta");
    $cantidad_numero = mysqli_num_rows($consulta_numero);
    if ($cantidad_numero > 0) {
        echo "<script>alert('Esta subcategoria ya existe');</script>";
    } else {
        $registrar = mysqli_query($conexion, "INSERT INTO `subcategoria` (`idSubcategoria`, `Nombre`, `idCategoria`) VALUES (NULL, '$nombre', '$categoria');") or die($conexion);
        echo "<script>alert('Se registro correctamente');</script>";
        echo "<script>window.location='dashboard.php?mod=AgregarProductos' ;</script>";
    }
}
?>

<script>
    function selectFabricante(element, id) {

        document.getElementById('fabricanteSeleccionadoId').value = id;

        var buttons = document.querySelectorAll('.btn_fabricantes');
        buttons.forEach(function(btn) {
            btn.classList.remove('selected');
        });

        // Agregar la clase 'selected' al botón de fabricante seleccionado
        element.classList.add('selected');

    }

    function selectCategoria(element, id) {

        document.getElementById('CategoriaSeleccionadoId').value = id;

        var buttons = document.querySelectorAll('.btn_selectorSubcategoria');
        buttons.forEach(function(btn) {
            btn.classList.remove('selected');
        });

        // Agregar la clase 'selected' al botón de fabricante seleccionado
        element.classList.add('selected');

    }
    var subcategoriasSeleccionadas = [];

    function selectSubcategoria(element, id) {
        var index = subcategoriasSeleccionadas.indexOf(id);

        if (index === -1) { // No está en el array, agregarlo
            if (subcategoriasSeleccionadas.length < 3) {
                subcategoriasSeleccionadas.push(id);
                element.classList.add('selected');
            } else {
                alert('Solo puedes seleccionar hasta 3 subcategorías.');
            }
        } else { // Está en el array, quitarlo
            subcategoriasSeleccionadas.splice(index, 1);
            element.classList.remove('selected');
        }

        // Actualizar el valor del campo oculto
        var inputElement = document.getElementById('SubcategoriaSeleccionadoId');
        inputElement.value = JSON.stringify(subcategoriasSeleccionadas);
    }
</script>
<script>
    document.getElementById('imagen').addEventListener('change', function(event) {
        var input = event.target;
        var label = document.getElementById('upload-label');
        var icon = document.getElementById('upload-icon');
        var text = document.getElementById('upload-text');
        var file = input.files[0];
        if (file) {
            var reader = new FileReader();
            reader.onload = function(e) {
                label.style.backgroundImage = 'url(' + e.target.result + ')';
                icon.style.display = 'none';
                text.style.display = 'none';
            }
            reader.readAsDataURL(file);
        }
    });

    document.getElementById('boton-subir').addEventListener('click', function() {
        var input = document.getElementById('imagen');
        if (input.files.length === 0) {
            alert('Por favor, selecciona una imagen primero.');
        } else {
            document.getElementById('formulario-imagen').submit();
        }
    });
</script>
<script>
    window.onclick = function(event) {
        for (let modalKey in modals) {
            if (event.target == modals[modalKey]) {
                modals[modalKey].style.display = "none";
            }
        }
    }

    window.addEventListener('load', function() {
        if (localStorage.getItem('showModal') === 'true') {
            document.getElementById('VentanaSubcategoria').style.display = 'flex';
            localStorage.removeItem('showModal'); // Limpiar la bandera para que no se muestre de nuevo
        }
    });

    // Botón que establece la bandera en localStorage y muestra el modal
    document.getElementById('btnAñadirSubcategoria').addEventListener('click', function() {
        localStorage.setItem('showModal', 'true');
        document.getElementById('uploadModal').style.display = 'flex';
    });
</script>

    <?php
}


?>