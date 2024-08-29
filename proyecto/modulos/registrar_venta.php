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

  .containertop2 {
    justify-content: center;
    width: 100%;
  }

  .containertop {
    box-shadow: 0 0 7px rgb(0, 0, 0, 0.2);
    border: 0 0 4px black solid !important;
    border-radius: 10px;
    padding: 5px;
    width: 700px;
    display: flex !important;
    margin-top: 25px;
    margin-bottom: 30px;
    text-align: center;
    margin-left: 200px;
  }

  .containertop h3 {
    margin-left: 37%;
  }

  .container-valor {
    background-color: green;
    width: 820px;
    height: 800px;
  }

  .cont {
    width: 200px;
    margin: 30px;
  }

  .cont label {
    font-size: 20px;
    color: black;
    font-weight: 500;
  }

  .container-precio {
    box-shadow: 0 0 7px rgb(0, 0, 0, 0.2);
    border: 0 0 4px black solid !important;
    border-radius: 10px;
    width: 190px;
  }

  .container-precio h4 {
    text-align: left;
    color: grey !important;
    padding: 5px;
  }

  .row {
    justify-content: center;
  }

  .container-doc {
    width: 730px;
  }

  .container-doc {
    font-size: 20px;
    color: black;
    font-weight: 500;

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
          <h5 class="card-title" style="font-size: 40px; margin-left:-65px">cuaderno </h5>
          <p class="card-text" id="precio">$10.000</p>
        </div>
        <a href="#" class="card-link">Eliminar </a>
      </div>
    </div>
    <div class="card" style="width: 20rem;">
      <div class="card-body">
        <h6 class="card-subtitle mb-2 text-muted" style="font-size: 20px;">Norma 3 unidades</h6>
        <div class="precio-nombre">
          <h5 class="card-title" style="font-size: 40px; margin-left:-65px">colores </h5>
          <p class="card-text" id="precio">$10.000</p>
        </div>

        <a href="#" class="card-link">Eliminar </a>
      </div>
    </div>
    <div class="card" style="width: 20rem;">
      <div class="card-body">
        <h6 class="card-subtitle mb-2 text-muted" style="font-size: 20px;">Norma 3 unidades</h6>
        <div class="precio-nombre">
          <h5 class="card-title" style="font-size: 40px; margin-left:-65px">lapiceros </h5>
          <p class="card-text" id="precio">$10.000</p>
        </div>

        <a href="#" class="card-link">Eliminar </a>
      </div>
    </div>
    <div class="containertop2">
      <div class="containertop">
        <h3>Añadir producto</h3>
      </div>
    </div>
    <div class="container">
      <div class="row">
        <div class="cont col-md-4">
          <label for="">Precio Neto</label>
          <div class="container-precio">
            <input type="text" placeholder="$999.000" class="form-control">
          </div>
        </div>
        <div class="cont col-md-4">
          <label for="">Precio Final</label>
          <div class="container-precio">
            <input type="text" placeholder="$999.000" class="form-control">
          </div>
        </div>
        <div class="cont col-md-4">
          <label for="">Descuento</label>
          <div class="container-precio">
            <input type="text" placeholder="$999.000" class="form-control">
          </div>
        </div>
        <div class="container-doc">
          <label for="">Documendo Cliente</label>
          <input type="text" placeholder="Ej: 1054689234" class="form-control">

        </div>

      </div>
    </div>