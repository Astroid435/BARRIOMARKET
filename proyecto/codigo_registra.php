<html>
  <head>
  </head>
</html>
<?php
include "conexion.php";
if (isset($_POST["btn_registrar"])){
    $Correo = $_POST['Correo'];
    $PrimerNombre = $_POST['PrimerNombre'];
    $PrimerApellido = $_POST['PrimerApellido'];
    $Telefono = $_POST['Telefono'];
    $TipoDocumento = $_POST['TipoDocumento'];
    $Documento = $_POST['Documento'];
    $Rol = 1;
    $PreContraseña = $_POST['Contraseña'];
    $ConfirmacionContraseña = $_POST['ConfirmacionContraseña'];
    $Contraseña = md5($PreContraseña);
    $consulta_numero = mysqli_query($conexion,"SELECT * FROM usuario WHERE Documento = '$Documento';") or die ($conexion."Error en la consulta");
    $cantidad_numero = mysqli_num_rows($consulta_numero);
    $consulta_correo = mysqli_query($conexion,"SELECT * FROM usuario WHERE Correo = '$Correo';") or die ($conexion."Error en la consulta");
    $cantidad_correo = mysqli_num_rows($consulta_correo);
    if($PreContraseña!=$ConfirmacionContraseña){
        ?>
        <br>
        <h4>
        <?php
        echo "<script>alert('Las contraseñas no coinciden');</script>";
        echo "<script>window.location='registrar.php' ;</script>";
        ?>
        </h4>
        <?php
    }else{
      if($cantidad_numero>0){
        echo "<script>alert('El numero de indetificacion que proporcionas ya esta en uso');</script>";
        echo "<script>window.location='registrar.php' ;</script>";
      }else
          if($cantidad_correo>0){
            echo "<script>alert('El correo que proporcionas ya esta en uso');</script>";
            echo "<script>window.location='registrar.php' ;</script>";
          }else{
    $registrar = mysqli_query($conexion, "INSERT INTO `usuario` (`Documento`, `PrimerNombre`, `PrimerApellido`,`Telefono`, `Correo`, `Contraseña`, `TipoDocumento`, `Rol`) VALUES ('$Documento', '$PrimerNombre','$PrimerApellido','$Telefono', '$Correo', '$Contraseña', '$TipoDocumento', '$Rol')") or die($conexion);
    echo "<script>alert('Registro exitoso');</script>";
    echo "<script>window.location='index.php' ;</script>";
  }
    }

}
?>