
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
    $consulta_numero = mysqli_query($conexion,"SELECT * FROM productos WHERE Nombre = '$Nombre';") or die ($conexion."Error en la consulta");
    $cantidad_numero = mysqli_num_rows($consulta_numero);
      if($cantidad_numero>0){
        echo "<script>alert('El nombre del producto ya esta en uso');</script>";
        echo "<script>window.location='agregar_productos.php' ;</script>";
      }else{
        $registrar = mysqli_query($conexion, "INSERT INTO `productos` (`idProductos`, `Nombre`, `Cantidad`, `ValorCompra`, `ValorVenta`, `Descripcion`, `imagen`, `Fabricante_idFabricante`) VALUES (NULL, '$Nombre', '$Cantidad', '$ValorCompra', '$ValorVenta', '$Descripcion', NULL, '$fabricante')") or die($conexion);
        $consulta_numero = mysqli_query($conexion,"SELECT * FROM productos WHERE Nombre = '$Nombre';") or die ($conexion."Error en la consulta");
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
        echo "<script>window.location='agregar_productos.php' ;</script>";
        }
    }
?>