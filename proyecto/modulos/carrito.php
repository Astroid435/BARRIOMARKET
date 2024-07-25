
<style>

   
    h2 {
      margin-bottom: 20px;
    }

    .card {
      box-shadow: 0 0 12px rgb(0, 0, 0, 0.2);
      border: transparent;
      padding: 20px;
    }

    .card .card-link {
        background-color: #000;
        border-radius: 5px;
        color: #ffff;
        text-decoration: none;
    }

    .card .precio-nombre {
        display: flex;

    }

    .card .precio-nombre .card-text {
        margin-top: 15px;
    }
  </style>

    <h2><strong>Carrito de compras</strong></h2>
    <p>En esta seccion se muestra los productos seleccionados para realizar el pedido</p>
    <div class="containe-flex">
    <div class="row justify-content-evenly">
      <div class="card" style="width: 20rem;">
        <div class="card-body">
        <div class="d-flex justify-content-between">
            <span class="text-muted">Norma</span>
            <span class="text-muted">3 unidades</span>
          </div>  
          <div class="precio-nombre"> 
            <h1 class="card-title">lapiceros </h1>
            <p class="card-text" id="precio">$10.000</p>
          </div>
          <a href="#">
            <button class="button btn card-link col-12">Eliminar</button>
          </a>
        </div>
      </div>
      <div class="card" style="width: 20rem;">
        <div class="card-body">
        <div class="d-flex justify-content-between">
            <span class="text-muted">Norma</span>
            <span class="text-muted">3 unidades</span>
          </div>  
          <div class="precio-nombre"> 
            <h1 class="card-title">lapiceros </h1>
            <p class="card-text" id="precio">$10.000</p>
          </div>
          <a href="#">
            <button class="button btn card-link col-12">Eliminar</button>
          </a>
        </div>
      </div>
      <div class="card" style="width: 20rem;">
        <div class="card-body">
        <div class="d-flex justify-content-between">
            <span class="text-muted">Norma</span>
            <span class="text-muted">3 unidades</span>
          </div>  
          <div class="precio-nombre"> 
            <h1 class="card-title">lapiceros </h1>
            <p class="card-text" id="precio">$10.000</p>
          </div>
          <a href="#">
            <button class="button btn card-link col-12">Eliminar</button>
          </a>
        </div>
      </div>
      
      </div>
      <div class="justify-content-between">
        <center>
        <div class="col-5">
          <textarea type="text" class="form-control" name="Descripcion" placeholder="Ej:" requirted maxlength="150"></textarea>
          
        </div>
      </center>
      </div>
    </div>
  </div>
