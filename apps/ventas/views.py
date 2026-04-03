from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from django.db import transaction
from django.http import JsonResponse
from django.shortcuts import redirect, get_object_or_404
from django.utils import timezone
from django.views.decorators.http import require_POST
from django.utils.decorators import method_decorator
from django.views.generic import ListView, DetailView, TemplateView, View

from .models import RegistroVenta, CantidadVenta
from apps.pedidos.models import RegistroPedido, CantidadPedido, Devolucion
from apps.productos.models import Productos


# ---------- Mixins ----------

class AdminRequeridoMixin(LoginRequiredMixin, UserPassesTestMixin):
    login_url = 'inicio'

    def test_func(self):
        return self.request.user.is_authenticated and self.request.user.rol.Nombre == 'Administrador'


class AutenticadoMixin(LoginRequiredMixin):
    login_url = 'inicio'


# ---------- Listado de ventas ----------

class VentaListView(AutenticadoMixin, ListView):
    template_name = 'Ventas/ListadoVentas.html'
    context_object_name = 'ventas'

    def get_queryset(self):
        return RegistroVenta.objects.all().order_by('-Fecha')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['devoluciones'] = Devolucion.objects.all().order_by('-fecha_cancelacion')
        return context


# ---------- Detalle de venta ----------

class VentaDetailView(AutenticadoMixin, DetailView):
    model = RegistroVenta
    template_name = 'Ventas/DetalleVenta.html'
    context_object_name = 'venta'
    pk_url_kwarg = 'idVenta'

    def get_queryset(self):
        return RegistroVenta.objects.prefetch_related('cantidadventa_set__Productos')


# ---------- Agregar Venta (desde pedido) ----------

class VentaCreateView(AdminRequeridoMixin, TemplateView):
    template_name = 'Ventas/AgregarVentas.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['ProductosTodos'] = Productos.objects.all()
        id_pedido = self.kwargs.get('idPedido')

        if id_pedido:
            pedido = get_object_or_404(
                RegistroPedido.objects.prefetch_related('CantidadPedido__Productos'),
                id=id_pedido
            )
            valor_total = sum([
                getattr(item.Productos, "ValorVenta", 0) * item.Cantidad
                for item in pedido.CantidadPedido.all()
                if getattr(item, "Productos_id", None)
            ])
            context['pedido'] = pedido
            context['ValorTotal'] = int(round(valor_total))

        return context

    def post(self, request, idPedido, *args, **kwargs):
        pedido = get_object_or_404(
            RegistroPedido.objects.prefetch_related('CantidadPedido__Productos'),
            id=idPedido
        )

        if request.headers.get('x-requested-with') == 'XMLHttpRequest':
            return self._handle_ajax(request, pedido)

        documento_cliente_post = request.POST.get('DocumentoCliente', pedido.Usuario.Documento)

        try:
            documento_cliente_int = int(documento_cliente_post)
        except (ValueError, TypeError):
            messages.error(request, "Documento de cliente inválido.")
            return redirect('AgregarVentaLink', idPedido=idPedido)

        valor_total_final = sum([
            item.Productos.ValorVenta * item.Cantidad
            for item in pedido.CantidadPedido.all()
            if item.Productos
        ])

        with transaction.atomic():
            nueva_venta = RegistroVenta.objects.create(
                Valor=int(round(valor_total_final)),
                ValorTotal=int(round(valor_total_final)),
                Fecha=timezone.now(),
                Usuario_DocumentoAdministrador=request.user,
                DocumentoCliente=documento_cliente_int
            )

            for item_pedido in pedido.CantidadPedido.all():
                if not item_pedido.Productos:
                    continue

                CantidadVenta.objects.create(
                    RegistroVenta=nueva_venta,
                    Productos=item_pedido.Productos,
                    Cantidad=item_pedido.Cantidad,
                )

                producto_stock = item_pedido.Productos
                producto_stock.Cantidad -= item_pedido.Cantidad
                producto_stock.save()

            pedido.delete()
            messages.success(request, "¡Venta registrada exitosamente!")
            return redirect('ListadoVenta')

    def _handle_ajax(self, request, pedido):
        return JsonResponse({'status': 'error'})


# ---------- Venta AJAX (ajustar cantidades) ----------

class VentaAjaxView(AdminRequeridoMixin, View):
    @method_decorator(require_POST)
    def dispatch(self, *args, **kwargs):
        return super().dispatch(*args, **kwargs)

    def post(self, request, idPedido, *args, **kwargs):
        pedido = get_object_or_404(
            RegistroPedido.objects.prefetch_related('CantidadPedido__Productos'),
            id=idPedido
        )
        detalle_id = request.POST.get('id')

        try:
            detalle = pedido.CantidadPedido.get(id=detalle_id)
        except CantidadPedido.DoesNotExist:
            return JsonResponse({'status': 'error', 'message': 'Item no encontrado'}, status=404)

        action_status = None
        if request.POST.get('menos'):
            if detalle.Cantidad <= 1:
                detalle.delete()
                action_status = 'deleted'
            else:
                detalle.Cantidad -= 1
                detalle.save()
                action_status = 'updated'
        elif request.POST.get('mas'):
            if detalle.Cantidad < detalle.Productos.Cantidad:
                detalle.Cantidad += 1
                detalle.save()
                action_status = 'updated'
            else:
                return JsonResponse({'status': 'limit', 'message': 'Cantidad máxima alcanzada'})
        elif request.POST.get('borrar'):
            detalle.delete()
            action_status = 'deleted'

        nuevos_items = pedido.CantidadPedido.all()
        total = sum([i.Productos.ValorVenta * i.Cantidad for i in nuevos_items])

        if action_status == 'updated':
            subtotal = detalle.Cantidad * detalle.Productos.ValorVenta
            return JsonResponse({
                'status': 'updated',
                'cantidad': detalle.Cantidad,
                'subtotal': int(round(subtotal)),
                'total_pedido': int(round(total))
            })
        elif action_status == 'deleted':
            return JsonResponse({
                'status': 'deleted',
                'total_pedido': int(round(total))
            })

        return JsonResponse({'status': 'error'})


# ---------- Añadir producto a un pedido (para venta) ----------

class AñadirProductoView(AdminRequeridoMixin, TemplateView):
    template_name = 'Ventas/añadirproducto.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['productos'] = Productos.objects.all()
        context['pedido'] = get_object_or_404(
            RegistroPedido, id=self.kwargs['idPedido']
        )
        return context


class AgregarProductoAVentaView(AdminRequeridoMixin, View):
    def get(self, request, idPedido, idProducto, *args, **kwargs):
        pedido = get_object_or_404(RegistroPedido, id=idPedido)
        producto = get_object_or_404(Productos, id=idProducto)

        item, created = CantidadPedido.objects.get_or_create(
            RegistroPedido=pedido,
            Productos=producto,
            defaults={'Cantidad': 1}
        )

        if not created:
            item.Cantidad += 1
            item.save()

        return redirect('AgregarVentaLink', idPedido=pedido.id)
