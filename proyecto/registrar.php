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
                <div class="form col-md-5 registro">
                    <form action="codigo_registra.php" method="post">
                      <center>
                        <h3>Registrate</h3>
                        <h6>Llena todos los campos para continuar</h6>
                        <br>
                        <div class="form-group">
                            <label for="exampleFormControlInput1">Correo</label>
                            <input type="email" class="form-control" aria-describedby="emailHelp" id="exampleFormControlInput1" placeholder="Ej: name@example.com*" name="Correo" required>
                            <small id="emailHelp" class="form-text text-muted">No compartas tu correo con nadie</small>
                        </div>
                        <div class="row">
                            <label for="exampleInputEmail1">Nombres</label>
                            <div class="col">
                            <input type="text" class="form-control" placeholder="Primer nombre*" name="PrimerNombre" required>
                            </div>
                            <div class="col">
                            <input type="text" class="form-control" placeholder="Primer apellido*" name="PrimerApellido" required>
                            </div>
                        </div>
                        <br>
                        <div class="form-group">
                          <label for="exampleInputPassword1">Telefono</label>
                          <input type="doc" class="form-control" id="exampleInputEmail1" placeholder="Telefono*" name="Telefono" minlength="10" required>
                        </div>
                        <br>
                        <div class="row">
                          <label for="exampleFormControlSelect1">Tipo y número de documento</label>
                          <div class="col-4">
                          <select class="form-control" id="exampleFormControlSelect1" name="TipoDocumento" required>
                            <option>Seleccione*</option>
                            <option value="1">Tarjeta de identidad</option>
                            <option value="2">Cédula de ciudadanía</option>
                            <option value="3">Registro civil</option>
                          </select>
                          </div>
                          <div class="col-8">
                            <input type="doc" class="form-control" placeholder="Documento*" name="Documento" minlength="8" maxlength="15" required>
                          </div>  
                        </div>
                        <br>
                        <div class="row">
                            <label for="exampleInputEmail1">Contraseña*</label>
                            <div class="col">
                              <input type="password" class="form-control" placeholder="Contraseña*" name="Contraseña" minlength="8" minlength="100" required>
                            </div>
                            <div class="col">
                              <input type="password" class="form-control" placeholder="Confirmar contraseña*" name="ConfirmacionContraseña" minlength="8" minlength="100" required>
                            </div>
                        </div>
                        <br>
                        <button type="submit" class="btn_registrar" name="btn_registrar">Registrar</button>
                        <br><br>
                        <a href="recuperar.php">Recuperar cuenta.</a> | <a href="index.php"> ¿Ya tienes cuenta? </a>
                        </center>
                    </form>
                   </div>
                </div>
            </div>

           </div>
        </div>
    </body>
</html>