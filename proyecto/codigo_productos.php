
<?php
include "conexion.php";
session_start();
if (isset($_POST["btn_producto"])){
    $subcategorias=$_SESSION["SubcategoriaSeleccionadoId"];
    $fabricante=$_SESSION["fabricanteSeleccionadoId"];
    $Nombre = $_POST['Nombre'];
    $Cantidad = $_POST['Cantidad'];
    $ValorVenta = $_POST['ValorVenta'];
    $ValorCompra = $_POST['ValorCompra'];
    $Descripcion = $_POST['Descripcion'];
    $target_dir = "ImgProductos/";
    $uploadOk = 1;
    $imageFileType = strtolower(pathinfo($_FILES["imagen"]["name"], PATHINFO_EXTENSION));
    $newFileName = uniqid() . '.' . $imageFileType; // Genera un nuevo nombre único
    $target_file = $target_dir . $newFileName;
    $check = getimagesize($_FILES["imagen"]["tmp_name"]);
    if($check !== false) {
        echo "El archivo es una imagen - " . $check["mime"] . ".";
        $uploadOk = 1;
    } else {
        echo "El archivo no es una imagen.";
        $uploadOk = 0;
    }
        // Verificar el tamaño del archivo
    if ($_FILES["imagen"]["size"] > 50000000) {
        echo "Lo siento, tu archivo es demasiado grande.";
        $uploadOk = 0;
    }
    // Permitir ciertos formatos de archivo
    if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"&& $imageFileType != "gif" ) {
        echo "Lo siento, solo se permiten archivos JPG, JPEG, PNG y GIF.";
        $uploadOk = 0;
    }
    // Verificar si $uploadOk es 0 debido a un error
    if ($uploadOk == 0) {
        echo "Lo siento, tu archivo no fue subido.";
        // Si todo está bien, intentar subir el archivo
    } else {
        if (move_uploaded_file($_FILES["imagen"]["tmp_name"], $target_file)) {
            echo "El archivo ". htmlspecialchars(basename($_FILES["imagen"]["name"])) . " ha sido subido.";
        } else {
            echo "Lo siento, hubo un error subiendo tu archivo.";
        }
    }
    $consulta_numero = mysqli_query($conexion,"SELECT * FROM productos WHERE Nombre = '$Nombre';") or die ($conexion."Error en la consulta");
    $cantidad_numero = mysqli_num_rows($consulta_numero);
    if($cantidad_numero>0){
        echo "<script>alert('El nombre del producto ya esta en uso');</script>";
        echo "<script>window.location='dashboard.php?mod=AgregarProductos' ;</script>";
    }else{
        $sql= "INSERT INTO `productos` (`idProductos`, `Nombre`, `Cantidad`, `ValorCompra`, `ValorVenta`, `Descripcion`, `imagen`, `Fabricante_idFabricante`) VALUES (NULL, '$Nombre', '$Cantidad', '$ValorCompra', '$ValorVenta', '$Descripcion', '$target_file', '$fabricante')";
        $registrarproducto = mysqli_query($conexion, $sql);
        if (!$registrarproducto) {
            die("$fabricante" . mysqli_error($conexion));
        }
        $consulta = $conexion->prepare("SELECT * FROM productos WHERE Nombre = '$Nombre';");
        $consulta->execute();
        $resultados = $consulta->get_result();
        while ($fila = $resultados->fetch_assoc()) {
            $IdProducto=$fila['idProductos'];
            $cantidadSubcategorias=count($subcategorias);
            $i=0;
            while ($i<=($cantidadSubcategorias-1)){
                $IdSubcategoria=$subcategorias[$i];
                $registrar = mysqli_query($conexion, "INSERT INTO `productoscategoria` (`Productos_idProductos`, `Subcategoria_idSubcategoria`) VALUES ('$IdProducto', '$IdSubcategoria')") or die($conexion);
                $i=$i+1;
            }
        }
        unset($_SESSION['SubcategoriaSeleccionadoId']);
        unset($_SESSION['fabricanteSeleccionadoId']);
        unset($_SESSION['CategoriaSeleccionadoId']);
        ?>
            <script>
                localStorage.clear();
            </script>
        <?php
        echo "<script>alert('Producto registrado correctamente');</script>";
        echo "<script>window.location='dashboard.php?mod=AgregarProductos';</script>";
    }
}

    if (isset($_POST["btn_delete"])){
        $idproductoeliminar=$_POST['idproducto'];
        echo $idproductoeliminar;
        $eliminarcategorias = mysqli_query($conexion, "DELETE FROM `productoscategoria` where `productoscategoria` . `Productos_idProductos` = '$idproductoeliminar'") or die ($conexion."Error en la consulta");
        $eiminarproducto=mysqli_query($conexion, "DELETE FROM productos WHERE `productos`.`idProductos` = $idproductoeliminar");
        echo "<script>alert('Producto eliminado correctamente');</script>";
        echo "<script>window.location='dashboard.php?mod=registros';</script>";
    }
    if (isset($_POST["btn_editar_producto"])){
        $subcategorias=$_SESSION["SubcategoriaSeleccionadoId"];
        $fabricante=$_SESSION["fabricanteSeleccionadoId"];
        $idproducto=$_POST["idproducto"];
        $Nombre = $_POST['Nombre'];
        $Cantidad = $_POST['Cantidad'];
        $ValorVenta = $_POST['ValorVenta'];
        $ValorCompra = $_POST['ValorCompra'];
        $Descripcion = $_POST['Descripcion'];
        $imagen=$_POST['imagen'];
        $target_dir = "ImgProductos/";
        $uploadOk = 1;
        $imageFileType = strtolower(pathinfo($_FILES["imagen"]["name"], PATHINFO_EXTENSION));
        $newFileName = uniqid() . '.' . $imageFileType; // Genera un nuevo nombre único
        $target_file = $target_dir . $newFileName;
            $check = getimagesize($_FILES["imagen"]["tmp_name"]);
            if($check !== false) {
                echo "El archivo es una imagen - " . $check["mime"] . ".";
                $uploadOk = 1;
            } else {
                echo "El archivo no es una imagen.";
                $uploadOk = 0;
            }
        
                // Verificar el tamaño del archivo
                if ($_FILES["imagen"]["size"] > 50000000) {
                    echo "Lo siento, tu archivo es demasiado grande.";
                    $uploadOk = 0;
                }
    
                // Permitir ciertos formatos de archivo
                if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
                && $imageFileType != "gif" ) {
                    echo "Lo siento, solo se permiten archivos JPG, JPEG, PNG y GIF.";
                    $uploadOk = 0;
                }
    
                // Verificar si $uploadOk es 0 debido a un error
                if ($uploadOk == 0) {
                    echo "Lo siento, tu archivo no fue subido.";
                // Si todo está bien, intentar subir el archivo
                } else {
                    if (move_uploaded_file($_FILES["imagen"]["tmp_name"], $target_file)) {
                        echo "El archivo ". htmlspecialchars(basename($_FILES["imagen"]["name"])) . " ha sido subido.";
                        $imagen=$target_file;
                    } else {
                        echo "Lo siento, hubo un error subiendo tu archivo.";
                    }
                }
        $consulta_numero = mysqli_query($conexion,"SELECT * FROM productos WHERE Nombre = '$Nombre';") or die ($conexion."Error en la consulta");
        $consulta_producto = mysqli_query($conexion,"SELECT * FROM productos WHERE idProductos = '$idproducto';") or die ($conexion."Error en la consulta");
        $cantidad_numero = mysqli_num_rows($consulta_numero);
        if($fila=mysqli_fetch_array($consulta_producto)){
          if($cantidad_numero>0 && $Nombre!=$fila['Nombre']){
            echo "<script>alert('El nombre del producto ya esta en uso');</script>";
            echo "<script>window.location='modulos/agregar_productos.php' ;</script>";
          }else{
            $actualizar = mysqli_query($conexion, "UPDATE `productos` SET `Nombre` = '$Nombre', `Cantidad` = '$Cantidad', `ValorCompra` = '$ValorCompra', `ValorVenta` = '$ValorVenta', `Descripcion` = '$Descripcion', `imagen` = '$imagen', `Fabricante_idFabricante` = '$fabricante' WHERE `productos`.`idProductos` = $idproducto") or die($conexion);
            $eliminarsubcategorias = mysqli_query($conexion, "DELETE FROM `productoscategoria` where `productoscategoria` . `Productos_idProductos` = '$idproducto'") or die ($conexion."Error en la consulta");
            $cantidadSubcategorias=count($subcategorias);
                $i=0;
                while ($i<=($cantidadSubcategorias-1)){
                    $IdSubcategoria=$subcategorias[$i];
                    $registrar = mysqli_query($conexion, "INSERT INTO `productoscategoria` (`Productos_idProductos`, `Subcategoria_idSubcategoria`) VALUES ('$idproducto', '$IdSubcategoria')") or die($conexion);
                    $i=$i+1;
                }
            }
            unset($_SESSION['SubcategoriaSeleccionadoId']);
            unset($_SESSION['fabricanteSeleccionadoId']);
            unset($_SESSION['CategoriaSeleccionadoId']);
            ?>
                <script>
                    localStorage.clear();
                </script>
            <?php
            echo "<script>alert('Producto editado correctamente');</script>";
            echo "<script>window.location='dashboard.php?mod=AgregarProductos';</script>";
            }
        }
    
?>

