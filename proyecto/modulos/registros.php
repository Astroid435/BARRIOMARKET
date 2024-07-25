<style>
    .contenedorcategorias,
    .contenedorfabricantes {
        display: none;
        padding-top: 10px;
    }

    .contenedorproductos {
        display: block;
        padding-top: 10px;
    }

    .card {
        width: 18rem;
        height: 270px !important;
        margin: 1rem;
        border: none !important;
    }

    .btn-edit {
        background-color: #000;
        color: #fff;
    }

    .btn-delete {
        background-color: #f00;
        color: #fff;
    }
</style>
<center>
    <h1 style="font-size: 57px; font-weight: bold;">Registros</h1>
    <p style="color: #828282; width: 40%;">Esta es una lista donde puedes visualizar, editar y eliminar los Productos, Categorias y Fabricantes registrados</p>
    <div class="col-4" style="background-color: #F5F5F5; padding:7px; border-radius:5px;">
        <div class="row" style="margin-left: 0px; margin-right: 0px;">
            <div class="col-4 btn_SeleccionRegistro seleccionRegistro shadow-sm" onclick="selectRegistro(this, 1)" id="btn_verproductos">Productos</div>
            <div class="col-4 btn_SeleccionRegistro" onclick="selectRegistro(this, 2)" id="btn_verfabricantes">Fabricantes</div>
            <div class="col-4 btn_SeleccionRegistro" onclick="selectRegistro(this, 3)" id="btn_vercategorias">Categorias</div>
        </div>
    </div>
</center>

<div class="contenedorproductos" id="contenedorproductos">
    <center>
        <h6>Busqueda</h6>
        <input type="text" id="search" class="form-control" placeholder="Ej: Cuaderno" style="width: 18rem;">
    </center>
    <div class="container-fluid" style="padding-top:10px;">
        <div class="row justify-content-evenly">
            <?php
            include "conexion.php";
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

            ?>
                    <div class="col-md-4 shadow card" style="background: url('ImgProductos/66a2632e7b7ca.jpg');">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <span class="text-muted"><?php echo $nombrefabricante; ?></span>
                                <span class="text-muted"><?php echo $cantidad; ?> Unidades</span>
                            </div>
                            <h5 class="card-title"><?php echo $nombre; ?></h5>
                            <h6 class="card-subtitle mb-2 text-muted">$<?php echo $ValorVenta; ?></h6>
                            <ul class="list-styled" style="height:96px">
                                <li><?php echo $nombrecategoria; ?></li>
                                <?php
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
                                ?>
                                        <li class="text-muted"><?php echo $fila['Nombre']; ?></li>
                                <?php
                                    }
                                }
                                ?>
                            </ul>
                            <div class="container-fluid">
                                <div class="row justify-content-evenly">
                                    <form action="dashboard.php?mod=EditarProducto" method="post" class="col-6">
                                        <input type="text" name="idproducto" value="<?php echo $idproducto; ?>" hidden>
                                        <button class="btn btn-edit col-12" id="btn_edit" name="btn_edit" type="submit">Editar</button>
                                    </form>
                                    <form action="./codigo_productos.php" method="POST" class="col-6">
                                        <input type="text" name="idproducto" value="<?php echo $idproducto; ?>" hidden>
                                        <button class="btn btn-delete col-12" name="btn_delete" id="btn_delete" type="submit">Eliminar</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
            <?php
                }
                ?>

                <div class="container">
                    <div class="row justify-content-evenly">
                        <a href="dashboard.php?mod=AgregarProductos" class="col-4">
                            <button class="btn btn-edit button col-12" href="dashboard.php?mod=AgregarProductos">Agregar Producto</button>
                        </a>
                    </div>
                    <div class="row justify-content-evenly">
                        <a href="" class="col-4">
                            <button class="btn btn-edit button col-12">Productos faltantes</button>
                        </a>
                    </div>
                </div>

                <?php
            }else{
                ?> 
                    <center>
                        
                        <p class="text-muted" style="padding-top:13px;">No se encontro ningun producto</p>
                    </center>
                <div class="container">
                    <div class="row justify-content-evenly">
                        <a href="dashboard.php?mod=AgregarProductos" class="col-4">
                            <button class="btn btn-edit button col-12" href="dashboard.php?mod=AgregarProductos">Agregar Producto</button>
                        </a>
                    </div>
                    <div class="row justify-content-evenly">
                        <a href="" class="col-4">
                            <button class="btn btn-edit button col-12">Productos faltantes</button>
                        </a>
                    </div>
                </div>

                <?php
            }
            ?>
        </div>
    </div>
</div>


<div class="contenedorfabricantes" id="contenedorfabricantes">
    <center>
        <h6>Busqueda</h6>
        <input type="text" id="search" class="form-control" placeholder="Ej: Matel" style="width: 18rem;">
    </center>
    <div class="container-fluid" style="padding-top:10px;">
        <div class="row justify-content-evenly">
            <?php
            include "conexion.php";
            $consulta = mysqli_query($conexion, "SELECT * FROM fabricante;") or die($conexion . "Error en la consulta");
            $cantidad = mysqli_num_rows($consulta);
            if ($cantidad > 0) {
                while ($fila = mysqli_fetch_array($consulta)) {
                    $Nombre = $fila['Nombre'];
                    $idFabricante = $fila['idFabricante'];
            ?>
                    <div class="col-md-4 shadow card" style="">
                        <div class="card-body">
                            <h5 class="card-title"><?php echo $Nombre; ?></h5>
                            <span class="text-muted"><?php echo "Productos relacionados" ?></span>
                            <ul class="list-styled" style="height:96px">
                                <?php
                                    $consultaproductosconteo= mysqli_query($conexion,"SELECT * FROM productos where Fabricante_idFabricante = $idFabricante") or die("Error en la consulta:".$conexion);
                                    $cantidadproductos=mysqli_num_rows($consultaproductosconteo);
                                    if ($cantidadproductos>3){
                                        $consultaproductosmas= mysqli_query($conexion,"SELECT * FROM productos where Fabricante_idFabricante = $idFabricante LIMIT 3") or die("Error en la consulta:".$conexion);
                                        while($fila = mysqli_fetch_array($consultaproductosmas)){
                                            $nombrep=$fila['Nombre'];
                                            $masproductos = $cantidadproductos-3;
                                            ?>
                                                <li><?php echo $nombrep; ?></li>
                                            <?php
                                        }
                                        ?>
                                        <li class="text-muted"><?php echo $masproductos." Mas"; ?></li>                            
                                        <?php
                                    }else{
                                        $consultaproductosmenos= mysqli_query($conexion,"SELECT * FROM productos where Fabricante_idFabricante = $idFabricante") or die("Error en la consulta:".$conexion);
                                        while($fila = mysqli_fetch_array($consultaproductosmenos)){
                                            $nombrep=$fila['Nombre'];

                                            ?>
                                                <li><?php echo $nombrep; ?></li>
                                            <?php
                                        }
                                    }
                                ?>
                            </ul>
                            <div class="container-fluid">
                                <div class="row justify-content-evenly">
                                    <form action="dashboard.php?mod=EditarProducto" method="post" class="col-6">
                                        <input type="text" name="idproducto" value="<?php echo $idproducto; ?>" hidden>
                                        <button class="btn btn-edit col-12" id="btn_edit" name="btn_edit" type="submit">Editar</button>
                                    </form>
                                    <form action="./codigo_productos.php" method="POST" class="col-6">
                                        <input type="text" name="idproducto" value="<?php echo $idproducto; ?>" hidden>
                                        <button class="btn btn-delete col-12" name="btn_delete" id="btn_delete" type="submit">Eliminar</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
            <?php
                }
                ?>

                <div class="container">
                    <div class="row justify-content-evenly">
                        <a href="dashboard.php?mod=AgregarProductos" class="col-4">
                            <button class="btn btn-edit button col-12" href="dashboard.php?mod=AgregarProductos">Agregar Fabricante</button>
                        </a>
                    </div>
                </div>

                <?php
            }else{
                ?> 
                    <center>
                        
                        <p class="text-muted" style="padding-top:13px;">No se encontro ningun Fabrincate</p>
                    </center>
                <div class="container">
                    <div class="row justify-content-evenly">
                        <a href="dashboard.php?mod=AgregarProductos" class="col-4">
                            <button class="btn btn-edit button col-12" href="dashboard.php?mod=AgregarProductos">Agregar Fabricante</button>
                        </a>
                    </div>
                </div>

                <?php
            }
            ?>
        </div>
    </div>

</div>
<div class="contenedorcategorias" id="contenedorcategorias">
    <center>
        <h6>Busqueda</h6>
        <input type="text" id="search" placeholder="Ej: Cuaderno">
    </center>
</div>
<?php
?>
<script>
    function selectRegistro(element, id) {
        var registro = parseInt(id, 10);
        var buttons = document.querySelectorAll('.btn_SeleccionRegistro');
        buttons.forEach(function(btn) {
            btn.classList.remove('seleccionRegistro');
            btn.classList.remove('shadow-sm');
        });
        element.classList.add('seleccionRegistro');
        element.classList.add('shadow-sm');

        if (registro === 1) {
            document.getElementById('contenedorcategorias').style.display = "none";
            document.getElementById('contenedorfabricantes').style.display = "none";
            document.getElementById('contenedorproductos').style.display = "block";
        } else if (registro === 2) {
            document.getElementById('contenedorcategorias').style.display = "none";
            document.getElementById('contenedorfabricantes').style.display = "block";
            document.getElementById('contenedorproductos').style.display = "none";
        } else if (registro === 3) {
            document.getElementById('contenedorcategorias').style.display = "block";
            document.getElementById('contenedorfabricantes').style.display = "none";
            document.getElementById('contenedorproductos').style.display = "none";
        }
    }
</script>