
<style>
    .container {
      margin-top: 35px;
    }
   
    #precio {
      font-size: 10px;
      font-weight: 400;

    }

    h2 {
      margin-bottom: 20px;
    }

    .inicio-log {
      color: white;
      background-color: black;
      width: 100%;
      height: 42px;
      border-radius: 10px;
      font-size: large;
      border: 1px black solid !important;
    }

    .card {
      margin-bottom: 20px;
      border-radius: 3px black solid !important;
      margin-left: 20px;
      margin-right: 20px;
      box-shadow: 0 0 12px rgb(0, 0, 0, 0.2);
      border: transparent;
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
  </style>

    <h2><strong>Carrito de compras</strong></h2>
    <p>En esta seccion se muestra los productos seleccionados para realizar el pedido</p>
    <div class="container">
    <div class="d-flex flex-wrap">
    <div class="card" style="width: 20rem;">
        <div class="card-body">
        <div class="d-flex justify-content-between">
            <span class="text-muted">Norma</span>
            <span class="text-muted">3 unidades</span>
          </div>
          <div class="precio-nombre"> 
            <h5 class="card-title" style="font-size: 40px; margin-left:-65px" >cuaderno </h5>
            <p class="card-text" id="precio">$10.000</p>
          </div>
          <a href="#" class="card-link">Eliminar </a>
        </div>
      </div>
      <div class="card" style="width: 20rem;">
        <div class="card-body">

          <div class="d-flex justify-content-between">
            <span class="text-muted">Norma</span>
            <span class="text-muted">3 unidades</span>
          </div>
          <div class="precio-nombre"> 
            <h5 class="card-title" style="font-size: 40px; margin-left:-65px" >colores </h5>
            <p class="card-text" id="precio">$10.000</p>
          </div>
          
          <a href="#" class="card-link">Eliminar </a>
        </div>
      </div>
      <div class="card" style="width: 20rem;">
        <div class="card-body">
        <div class="d-flex justify-content-between">
            <span class="text-muted">Norma</span>
            <span class="text-muted">3 unidades</span>
          </div>  
          <div class="precio-nombre"> 
            <h5 class="card-title" style="font-size: 40px; margin-left:-65px" >lapiceros </h5>
            <p class="card-text" id="precio">$10.000</p>
          </div>
          
          <a href="#" class="card-link">Eliminar </a>
        </div>
      </div>
      
      </div>
      <div class="col">
        <textarea type="text" class="form-control col-12" name="Descripcion" placeholder="Ej:" requirted maxlength="150"></textarea>
        </div>
    </div>
  </div>
