<div class="container Fatima mt-5">
      <center>
        <h1 class="text-white SYS">SYS Fatima</h1>
        <h4 class="text-white">Papeleria y otros servicios</h4>
        <br>
        <a href="agregar_productos.php">
          <button class="btn-primary btn">Ver productos</button>
        </a>
      </center>
    </div>
    <div class="row" id="productos_destacados">
      <h2>Productos destacados</h2>
    </div>
    <div class="container">
      <div class="row">
        <?php
                include "conexion.php";
                $consulta=mysqli_query($conexion,"SELECT * FROM productos LIMIT 8;") or die ($conexion."Error en la consulta");
                $cantidad = mysqli_num_rows($consulta);
                if($cantidad > 0){
                while($fila=mysqli_fetch_array($consulta)){
                  ?>
                  <div class="producto1 col-md-4">
                    <img src="<?php echo $fila['imagen'];?>" height="200px" width="100%">
                    <div class="container-info">
                      <p id="nom_produ"><strong><?php echo $fila['Nombre'];?></strong></p>
                      <p id="info_produ"><?php echo $fila['Descripcion'];?></p>
                      <p id="info_produ"><strong>$<?php echo $fila['ValorVenta'];?></strong></p>
                    </div>
                  </div>
                  <?php
                }
              }
        ?>
        <hr>
      </div>
      <div class="row" id="categoria">
      <h2>Categorias</h2>
    </div>
      <div class="container" id="categoriasresumen">
        <div class="row">
                    <?php
                    include "conexion.php";
                    $dep=1;
                    if ($dep==1){
                      $consulta = $conexion->prepare("SELECT * FROM categoria limit 3");
                      $consulta->execute();
                      $resultados = $consulta->get_result();
  
                      while ($fila = $resultados->fetch_assoc()) {
                      ?>
                          <div class="col-md-4 mb-3">
                              <div class="btn btn_consulta btn_fabricantes col-md-12 btn-fcsm button" name="btn_selector" onclick="selectFabricante(this, '<?php echo $fila['idCategoria']; ?>')">
                                  <?php echo htmlspecialchars($fila['Nombre']); ?>
                              </div>
                          </div>
                      <?php
                      }
                      ?>
                      <center>
                      <div class="col-md-3 mb-3">
                          <div class="btn btn_consulta btn_fabricantes col-md-12 btn-fcsm button" id="btn_vermas">
                              Ver mas
                          </div>
                      </div>
                      </center>
                    <?php
                    }
                    ?>
                </div>
            </div>
            <div class="container" id="categoriastodas">
              <div class="row">
                    <?php
                    include "conexion.php";
                    $dep=1;
                    if ($dep==1){
                      $consulta = $conexion->prepare("SELECT * FROM categoria");
                      $consulta->execute();
                      $resultados = $consulta->get_result();
  
                      while ($fila = $resultados->fetch_assoc()) {
                      ?>
                          <div class="col-md-4 mb-3">
                              <div class="btn btn_consulta btn_fabricantes col-md-12 btn-fcsm button" name="btn_selector" onclick="selectFabricante(this, '<?php echo $fila['idCategoria']; ?>')">
                                  <?php echo htmlspecialchars($fila['Nombre']); ?>
                              </div>
                          </div>
                      <?php
                      }
                      ?>
                      <center>
                      <div class="col-md-3 mb-3">
                          <div class="btn btn_consulta btn_fabricantes col-md-12 btn-fcsm button" id="btn_vermenos">
                              Ver menos
                          </div>
                      </div>
                      </center>
                    <?php
                    }
                    ?>
                </div>
            </div>
        </div>
      </div>
    </div>
    <script>
      verMenos=document.getElementById('btn_vermenos');
      verMenos.onclick = function(){
        document.getElementById('categoriastodas').style.display = "none";
        document.getElementById('categoriasresumen').style.display = "block";
      }
      verMas=document.getElementById('btn_vermas');
      verMas.onclick = function(){
        document.getElementById('categoriastodas').style.display = "block";
        document.getElementById('categoriasresumen').style.display = "none";
      }
    </script>