
<style>
    
 
 .card {
      margin-bottom: 20px;
      border-radius: 3px black solid !important;
      margin-left: 20px;
      margin-right: 20px;
      box-shadow: 0 0 12px rgb(0, 0, 0, 0.2);
      border: transparent;
      height: 200px;
    }

    .card .card-link {
        padding-left: 30px;
        padding-right: 30px;
        padding-top: 10px;
        padding-bottom: 10px;
        background-color: #000;
        border-radius: 5px;
        color: #ffff;
        text-decoration: none;
    }

    .card .precio-nombre {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 20px;
    }

    .card .precio-nombre .card-text {
        margin-top: 15px;
    }
    .containertop{
        box-shadow: 0 0 7px rgb(0, 0, 0, 0.2);
        border: 0 0 4px black solid !important;
        border-radius: 10px;
        padding: 5px;
        width: 700px;
        display: flex !important;
        margin-left: 27%;
        margin-top: 25px;
        margin-bottom: 30px;
        text-align: center;
    }
    .containertop h3{
        margin-left: 37%;
    }
    .container-valor{
        background-color: green;
        margin-left: 12%;
        width: 820px;
        height: 800px;
    }
    .cont{
        width: 200px;
    }
    .cont label{
        font-size: 20px;
        color: black;
        font-weight: 500;
    }
    .container-precio{
        box-shadow: 0 0 7px rgb(0, 0, 0, 0.2);
        border: 0 0 4px black solid !important;
        border-radius: 10px;
    }
</style>
    <h1><strong>Registrar Venta</strong></h1>
    <p>Llene todos los campos para continuar</p>
    <div class="container">
    <div class="d-flex flex-wrap">
    <div class="card" style="width: 20rem;">
        <div class="card-body">
          <h6 class="card-subtitle mb-2 text-muted" style="font-size: 20px;">Norma 3 unidades</h6>
          <div class="precio-nombre"> 
            <h5 class="card-title" style="font-size: 40px; margin-left:-65px" >cuaderno </h5>
            <p class="card-text" id="precio">$10.000</p>
          </div>
          <a href="#" class="card-link">Eliminar </a>
        </div>
      </div>
      <div class="card" style="width: 20rem;">
        <div class="card-body">
          <h6 class="card-subtitle mb-2 text-muted" style="font-size: 20px;">Norma 3 unidades</h6>
          <div class="precio-nombre"> 
            <h5 class="card-title" style="font-size: 40px; margin-left:-65px" >colores </h5>
            <p class="card-text" id="precio">$10.000</p>
          </div>
          
          <a href="#" class="card-link">Eliminar </a>
        </div>
      </div>
      <div class="card" style="width: 20rem;">
        <div class="card-body">
          <h6 class="card-subtitle mb-2 text-muted" style="font-size: 20px;">Norma 3 unidades</h6>
          <div class="precio-nombre"> 
            <h5 class="card-title" style="font-size: 40px; margin-left:-65px" >lapiceros </h5>
            <p class="card-text" id="precio">$10.000</p>
          </div>
          
          <a href="#" class="card-link">Eliminar </a>
        </div>
      </div>
      <div>
        <div class="containertop">
            <h3>Añadir producto</h3>
        </div>
      </div>
      <div class="row">
        <div class="container-valor">
            <div class="cont col-md-4">
                <label for="">Precio Neto</label>
                <div class="container-precio">
                    <h4>$999.999</h4>
                </div>
            </div>
        </div>
        <div class="container-valor">
            <div class="cont col-md-4">
                <label for="">Precio Neto</label>
                
            </div>
        </div>
        <div class="container-valor">
            <div class="cont col-md-4">
                <label for="">Precio Neto</label>
                
            </div>
        </div>

      </div>
