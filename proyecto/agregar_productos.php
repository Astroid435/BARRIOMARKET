<?php
session_start(); // Iniciar la sesión

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['fabricanteSeleccionado'])) {
    // Guardar el fabricante seleccionado en una variable de sesión
    $_SESSION['fabricanteSeleccionadoId'] = $_POST['fabricanteSeleccionadoId'];
}
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['CategoriaSeleccionado'])) {
    // Guardar el fabricante seleccionado en una variable de sesión
    $_SESSION['CategoriaSeleccionadoId'] = $_POST['CategoriaSeleccionadoId'];
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barrio Market</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <script src="js/jQuery1.9.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="style/estilo_dashboard.css">
    <meta charset="utf-8">
</head>

<body>
    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
        <symbol id="bootstrap" viewBox="0 0 118 94">
            <title>Bootstrap</title>
            <path fill-rule="evenodd" clip-rule="evenodd" d="M24.509 0c-6.733 0-11.715 5.893-11.492 12.284.214 6.14-.064 14.092-2.066 20.577C8.943 39.365 5.547 43.485 0 44.014v5.972c5.547.529 8.943 4.649 10.951 11.153 2.002 6.485 2.28 14.437 2.066 20.577C12.794 88.106 17.776 94 24.51 94H93.5c6.733 0 11.714-5.893 11.491-12.284-.214-6.14.064-14.092 2.066-20.577 2.009-6.504 5.396-10.624 10.943-11.153v-5.972c-5.547-.529-8.934-4.649-10.943-11.153-2.002-6.484-2.28-14.437-2.066-20.577C105.214 5.894 100.233 0 93.5 0H24.508zM80 57.863C80 66.663 73.436 72 62.543 72H44a2 2 0 01-2-2V24a2 2 0 012-2h18.437c9.083 0 15.044 4.92 15.044 12.474 0 5.302-4.01 10.049-9.119 10.88v.277C75.317 46.394 80 51.21 80 57.863zM60.521 28.34H49.948v14.934h8.905c6.884 0 10.68-2.772 10.68-7.727 0-4.643-3.264-7.207-9.012-7.207zM49.948 49.2v16.458H60.91c7.167 0 10.964-2.876 10.964-8.281 0-5.406-3.903-8.178-11.425-8.178H49.948z"></path>
        </symbol>
        <symbol id="home" viewBox="0 0 16 16">
            <path d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z"></path>
        </symbol>
        <symbol id="speedometer2" viewBox="0 0 16 16">
            <path d="M8 4a.5.5 0 0 1 .5.5V6a.5.5 0 0 1-1 0V4.5A.5.5 0 0 1 8 4zM3.732 5.732a.5.5 0 0 1 .707 0l.915.914a.5.5 0 1 1-.708.708l-.914-.915a.5.5 0 0 1 0-.707zM2 10a.5.5 0 0 1 .5-.5h1.586a.5.5 0 0 1 0 1H2.5A.5.5 0 0 1 2 10zm9.5 0a.5.5 0 0 1 .5-.5h1.5a.5.5 0 0 1 0 1H12a.5.5 0 0 1-.5-.5zm.754-4.246a.389.389 0 0 0-.527-.02L7.547 9.31a.91.91 0 1 0 1.302 1.258l3.434-4.297a.389.389 0 0 0-.029-.518z"></path>
            <path fill-rule="evenodd" d="M0 10a8 8 0 1 1 15.547 2.661c-.442 1.253-1.845 1.602-2.932 1.25C11.309 13.488 9.475 13 8 13c-1.474 0-3.31.488-4.615.911-1.087.352-2.49.003-2.932-1.25A7.988 7.988 0 0 1 0 10zm8-7a7 7 0 0 0-6.603 9.329c.203.575.923.876 1.68.63C4.397 12.533 6.358 12 8 12s3.604.532 4.923.96c.757.245 1.477-.056 1.68-.631A7 7 0 0 0 8 3z"></path>
        </symbol>
        <symbol id="table" viewBox="0 0 16 16">
            <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm15 2h-4v3h4V4zm0 4h-4v3h4V8zm0 4h-4v3h3a1 1 0 0 0 1-1v-2zm-5 3v-3H6v3h4zm-5 0v-3H1v2a1 1 0 0 0 1 1h3zm-4-4h4V8H1v3zm0-4h4V4H1v3zm5-3v3h4V4H6zm4 4H6v3h4V8z"></path>
        </symbol>
        <symbol id="people-circle" viewBox="0 0 16 16">
            <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"></path>
            <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"></path>
        </symbol>
        <symbol id="grid" viewBox="0 0 16 16">
            <path d="M1 2.5A1.5 1.5 0 0 1 2.5 1h3A1.5 1.5 0 0 1 7 2.5v3A1.5 1.5 0 0 1 5.5 7h-3A1.5 1.5 0 0 1 1 5.5v-3zM2.5 2a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zm6.5.5A1.5 1.5 0 0 1 10.5 1h3A1.5 1.5 0 0 1 15 2.5v3A1.5 1.5 0 0 1 13.5 7h-3A1.5 1.5 0 0 1 9 5.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zM1 10.5A1.5 1.5 0 0 1 2.5 9h3A1.5 1.5 0 0 1 7 10.5v3A1.5 1.5 0 0 1 5.5 15h-3A1.5 1.5 0 0 1 1 13.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zm6.5.5A1.5 1.5 0 0 1 10.5 9h3a1.5 1.5 0 0 1 1.5 1.5v3a1.5 1.5 0 0 1-1.5 1.5h-3A1.5 1.5 0 0 1 9 13.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3z"></path>
        </symbol>
    </svg>
    <header>
        <div class="px-3 py-2 text-black">
            <div class="container">
                <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
                    <a href="/" class="d-flex align-items-center my-2 my-lg-0 me-lg-auto text-black text-decoration-none">
                        Barrio Market/SYS Fatima
                    </a>

                    <ul class="nav col-12 col-lg-auto my-2 justify-content-center my-md-0 text-small">
                        <li>
                            <a href="#" class="nav-link text-black">
                                <svg class="bi d-block mx-auto mb-1" width="24" height="24">
                                    <use xlink:href="#home"></use>
                                </svg>
                                Home
                            </a>
                        </li>
                        <li>
                            <a href="#" class="nav-link text-black">
                                <svg class="bi d-block mx-auto mb-1" width="24" height="24">
                                    <use xlink:href="#grid"></use>
                                </svg>
                                Productos
                            </a>
                        </li>
                        <li>
                            <a href="#" class="nav-link text-black">
                                <img src="style/carrito.png" alt="" width="24" height="24" class="bi d-block mx-auto mb-1">
                                Carrito
                            </a>
                        </li>
                        <li>
                            <a href="#" class="nav-link text-black">
                                <svg class="bi d-block mx-auto mb-1" width="24" height="24">
                                    <use xlink:href="#people-circle"></use>
                                </svg>
                                Perfil
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </header>
    <form action="agregar_productos.php" method="post">
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
    <button id="btnCrearSubcategoria">Crear Subcategoría</button>

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
                        <button type="submit" class="btn button btn-fcs col-8" name="fabricanteSeleccionado" style="background-color:#000; color:#fff;">Seleccionar</button>
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
                <form method="post" action="agregar_productos.php" class="col-md-4">
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
                        <button id="btnCrearCategoria" class="btn btn_consulta col-md-12 btn-fcsm">+</button>
                    </div>
                </div>
            </div>
            <center>
                <div class="container">
                    <form id="registerForm" method="POST" action="">
                        <input type="hidden" name="CategoriaSeleccionadoId" id="CategoriaSeleccionadoId">
                        <button type="submit" class="btn button btn-fcs col-8" name="CategoriaSeleccionado" id="btnAñadirSubcategoria" style="background-color:#000; color:#fff;">Seleccionar</button>
                    </form>
                </div>
            </center>
        </div>
    </div>

    <div id="VentanaCrearCategoria" class="modal">
        <div class="modal-content">
            <span class="close closeCC col-1" style="position: absolute;">&times;</span>
            <p>Contenido de Crear Categoría</p>
        </div>
    </div>


    <div id="VentanaSubcategoria" class="modal">
        <div class="modal-content">
            <span class="close closeAS col-1" style="position: absolute;">&times;</span>
            <p>Contenido de Añadir Subcategoría</p>
        </div>
    </div>

    <div id="VentanaCrearSubcategoria" class="modal">
        <div class="modal-content">
            <span class="close closeCS col-1" style="position: absolute;">&times;</span>
            <p>Contenido de Crear Subcategoría</p>
        </div>
    </div>
    <?php
    if (isset($_SESSION['fabricanteSeleccionado'])) {
        echo "<center>Fabricante seleccionado: " . htmlspecialchars($_SESSION['fabricanteSeleccionadoId']) . "</center>";
    }
    ?>
    <?php
    if (isset($_POST['btn_fabricante'])) {
        $nombre = $_POST['nombre'];
        $telefono = $_POST['telefono'];
        $consulta_numero = mysqli_query($conexion, "SELECT * FROM fabricante WHERE Nombre = '$nombre';") or die($conexion . "Error en la consulta");
        $cantidad_numero = mysqli_num_rows($consulta_numero);
        if ($cantidad_numero > 0) {
            echo "<script>alert('Ese fabricante ya existe');</script>";
        } else {
            $registrar = mysqli_query($conexion, "INSERT INTO `fabricante` (`idFabricante`, `Nombre`, `Telefono`) VALUES (NULL, '$nombre', '$telefono');") or die($conexion);
            echo "<script>alert('Se registro correctamente');</script>";
            echo "<script>window.location='dashboard.php' ;</script>";
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
    <script src="script.js"></script>
</body>

</html>