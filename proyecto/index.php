<html lang="es">
    <head>
        <title>Barrio Market</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <script src="js/jQuery1.9.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="style/estilos_login.css">
        <meta charset="utf-8">
    </head>
    <body>
        <div class="container-fluid main">
            <div class="form-content">
                    <div class="form col-md-5 inicio">
                        <form action="index.php" method="post">
                            <center>
                            <?php
                                    session_start();
                                    include "conexion.php";
                                    if(isset($_POST['btn_ingresar'])){
                                        $Correo = $_POST['Correo'];
                                        $PreContraseña = $_POST['Contraseña'];
                                        $Contraseña = md5($PreContraseña);
                                        $consulta = mysqli_query($conexion, "SELECT * FROM usuario WHERE Correo = '$Correo' AND Contraseña = '$Contraseña'"); 
                                        $Resultado = mysqli_num_rows($consulta);
                                        if ($Resultado == 1) {
                                            while ($fila = mysqli_fetch_array($consulta)) {
                                                $_SESSION['PrimerNombre'] = $fila['PrimerNombre'];
                                                $_SESSION['PrimerApellido'] = $fila['PrimerApellido'];
                                                $_SESSION['Telefono'] = $fila['Telefono'];
                                                $_SESSION['Documento'] = $fila['Documento'];
                                                $_SESSION['Correo'] = $fila['Correo'];
                                                $_SESSION['Rol'] = $fila['Rol'];
                                                echo "<script>window.location='dashboard.php';</script>";
                                                exit();
                                            }
                                        } else {
                                            echo "Usuario y/o Contraseña no existen";
                                            exit();
                                        }
                                        
                                    }
                            ?>
                            <h3>Ingresa</H3>
                            <h6>Llena todos los campos para continuar</h6>
                            <br>
                            <div class="form-group">
                                <label for="exampleInputEmail1">Correo</label>
                                <input type="email" class="form-control" aria-describedby="emailHelp" id="exampleFormControlInput1" placeholder="Ej: name@example.com" name="Correo" required>
                            </div>
                            <br>
                            <div class="form-group">
                                <label for="exampleInputPassword1">Contraseña</label>
                                <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Contraseña" name="Contraseña">
                            </div>
                            <br>
                            <button type="submit" class="btn_ingresar" name="btn_ingresar">Ingresar</button>
                            <br><br>
                            <a href="recuperar.php">¿Has olvidado tu contraseña?</a> | <a href="registrar.php"> ¿No tienes cuenta?<br>Regístrate </a>
                            </center>
                        </form>
                    </div>
                </center>
            </div>
        </div>
    </body>
</html>