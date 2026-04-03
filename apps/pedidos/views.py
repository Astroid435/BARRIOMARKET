import json

from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from django.db import transaction
from django.http import JsonResponse
from django.shortcuts import redirect, get_object_or_404
from django.utils import timezone
from django.views.generic import TemplateView, ListView, View

from .models import RegistroPedido, CantidadPedido, Devolucion, Carrito
from apps.productos.models import Productos
from apps.compras.models import RegistroEncargo, CantidadEncargo


# ---------- Mixins ----------

class AutenticadoMixin(LoginRequiredMixin):
    login_url = 'inicio'


class AdminRequeridoMixin(LoginRequiredMixin, UserPassesTestMixin):
    login_url = 'inicio'

    def test_func(self):
        return self.request.user.is_authenticated and self.request.user.rol.Nombre == 'Administrador'


# ---------- Carrito ----------

class CarritoView(AutenticadoMixin, TemplateView):
    template_name = 'carrito.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        listadocarrito = []
        valor_todo = 0

        if self.request.user.is_authenticated:
            carrito = Carrito.objects.filter(Usuario=self.request.user.id)
            for carro in carrito:
                cantidadventa = carro.Productos.ValorVenta
                cantidad = carro.Cantidad
                cantidad_total = cantidadventa * cantidad
                valor_todo += cantidad_total
                listadocarrito.append({
                    'idCarrito': carro.id,
                    'Nombre': carro.Productos.Nombre,
                    'ValorUnitario': cantidadventa,
                    'ValorTotal': cantidad_total,
                    'Cantidad': cantidad,
                    'NombreFabricante': carro.Productos.Fabricante.Nombre,
                })

        context['listadocarrito'] = listadocarrito
        context['ValorTodo'] = valor_todo
        return context

    def post(self, request, *args, **kwargs):
        if request.headers.get('x-requested-with') == 'XMLHttpRequest':
            carrito_id = request.POST.get('id')
            try:
                carrito = Carrito.objects.get(id=carrito_id, Usuario=request.user)
            except Carrito.DoesNotExist:
                return JsonResponse({'status': 'error', 'message': 'No encontrado'}, status=404)

            if request.POST.get('menos'):
                if carrito.Cantidad == 1:
                    carrito.delete()
                    return JsonResponse({'status': 'deleted'})
                else:
                    carrito.Cantidad -= 1
                    carrito.save()
                    return JsonResponse({'status': 'updated', 'cantidad': carrito.Cantidad})

            elif request.POST.get('mas'):
                if carrito.Cantidad < carrito.Productos.Cantidad:
                    carrito.Cantidad += 1
                    carrito.save()
                    return JsonResponse({'status': 'updated', 'cantidad': carrito.Cantidad})
                else:
                    return JsonResponse({'status': 'limit'})

            elif request.POST.get('borrar'):
                carrito.delete()
                return JsonResponse({'status': 'deleted'})

            return JsonResponse({'status': 'error'})

        return self.render_to_response(self.get_context_data())


# ---------- Generar Pedido ----------

class GenerarPedidoView(AutenticadoMixin, View):
    def post(self, request, *args, **kwargs):
        carrito = Carrito.objects.filter(Usuario=request.user)

        if request.user.rol.Nombre == "Cliente":
            if request.POST.get('Observaciones') and request.POST.get('ValorTotal'):
                with transaction.atomic():
                    pedido = RegistroPedido.objects.create(
                        Fecha=timezone.now(),
                        Observaciones=request.POST.get('Observaciones'),
                        ValorTotal=request.POST.get('ValorTotal'),
                        Usuario=request.user,
                        Estado="sin_atender"
                    )
                    for carro in carrito:
                        CantidadPedido.objects.create(
                            Productos=carro.Productos,
                            RegistroPedido=pedido,
                            Cantidad=carro.Cantidad
                        )
                        producto = carro.Productos
                        producto.Cantidad -= carro.Cantidad
                        producto.save()
                        carro.delete()
                return redirect('/Pedidos/')
        else:
            if request.POST.get('ValorTotal'):
                with transaction.atomic():
                    encargo = RegistroEncargo.objects.create(
                        Fecha=timezone.now(),
                        Valor=request.POST.get('ValorTotal'),
                        Usuario=request.user,
                    )
                    for carro in carrito:
                        CantidadEncargo.objects.create(
                            Productos=carro.Productos,
                            RegistroEncargo=encargo,
                            Cantidad=carro.Cantidad
                        )
                        producto = carro.Productos
                        producto.Cantidad += carro.Cantidad
                        producto.save()
                        carro.delete()
                return redirect('/Compras/')

        return redirect('/Carrito/')

    def get(self, request, *args, **kwargs):
        return redirect('/Carrito/')


# ---------- Listado de Pedidos ----------

class PedidoListView(AutenticadoMixin, ListView):
    template_name = 'pedidos/pedidos.html'
    context_object_name = 'lista_pedidos'

    def get_queryset(self):
        if self.request.user.rol.Nombre == "Administrador":
            return RegistroPedido.objects.prefetch_related(
                'CantidadPedido__Productos'
            ).all().order_by('-Fecha')
        return RegistroPedido.objects.prefetch_related(
            'CantidadPedido__Productos'
        ).filter(Usuario=self.request.user).order_by('-Fecha')

    def post(self, request, *args, **kwargs):
        if request.user.rol.Nombre == "Administrador":
            pedido_id = request.POST.get('id')
            pedido = get_object_or_404(RegistroPedido, id=pedido_id)

            if 'aceptar' in request.POST:
                pedido.Estado = 'atendido'
                pedido.save()
            elif 'rechazar' in request.POST:
                CantidadPedido.objects.filter(RegistroPedido=pedido).delete()
                pedido.delete()

        return redirect('/Pedidos/')


# ---------- Pedidos AJAX ----------

class PedidosAjaxView(AutenticadoMixin, TemplateView):
    template_name = 'pedidos/_parcial_listado.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        estado = self.request.GET.get('estado')

        if self.request.user.rol.Nombre == "Administrador":
            pedidos = RegistroPedido.objects.all().order_by('-Fecha')
        else:
            pedidos = RegistroPedido.objects.filter(
                Usuario=self.request.user
            ).order_by('-Fecha')

        if estado in ['atendido', 'sin_atender']:
            pedidos = pedidos.filter(Estado=estado)

        context['lista_pedidos'] = pedidos
        return context


# ---------- Cancelar Pedido ----------

class CancelarPedidoView(AutenticadoMixin, View):
    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body)
        except json.JSONDecodeError:
            return JsonResponse({"success": False, "error": "Datos inválidos."})

        pedido_id = data.get("id")
        motivo = data.get("motivo")

        try:
            pedido = RegistroPedido.objects.get(id=pedido_id)
        except RegistroPedido.DoesNotExist:
            return JsonResponse({"success": False, "error": "Pedido no encontrado."})

        Devolucion.objects.create(
            pedido=pedido,
            usuario=request.user,
            motivo=motivo,
            valor=pedido.ValorTotal
        )

        pedido.delete()
        return JsonResponse({"success": True})
