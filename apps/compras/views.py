from datetime import timedelta, datetime, time

from django.contrib.auth.mixins import LoginRequiredMixin
from django.db.models import Sum
from django.utils import timezone
from django.views.generic import ListView, TemplateView

from .models import RegistroEncargo, CantidadEncargo


# ---------- Listado de compras ----------

class CompraListView(LoginRequiredMixin, ListView):
    template_name = 'compras/compras.html'
    context_object_name = 'lista_compras'
    login_url = 'inicio'

    def get_queryset(self):
        return RegistroEncargo.objects.all().order_by('-Fecha')


# ---------- Compras AJAX ----------

class ComprasAjaxView(LoginRequiredMixin, TemplateView):
    template_name = 'compras/_parcial_listado.html'
    login_url = 'inicio'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        fecha = self.request.GET.get('fecha')
        compras = RegistroEncargo.objects.all().order_by('-Fecha')
        hoy = timezone.localdate()

        if fecha == 'hoy':
            inicio = datetime.combine(hoy, time.min)
            fin = datetime.combine(hoy, time.max)
            compras = compras.filter(Fecha__range=(inicio, fin))
        elif fecha == 'semana':
            inicio_semana = hoy - timedelta(days=hoy.weekday())
            inicio = datetime.combine(inicio_semana, time.min)
            fin = datetime.combine(hoy, time.max)
            compras = compras.filter(Fecha__range=(inicio, fin))
        elif fecha == 'mes':
            inicio_mes = hoy.replace(day=1)
            inicio = datetime.combine(inicio_mes, time.min)
            fin = datetime.combine(hoy, time.max)
            compras = compras.filter(Fecha__range=(inicio, fin))

        total_general = compras.aggregate(total=Sum('Valor'))['total'] or 0

        productos_data = CantidadEncargo.objects.filter(
            RegistroEncargo__in=compras
        ).values('Productos__Nombre').annotate(
            total_cantidad=Sum('Cantidad')
        ).order_by('-total_cantidad')

        mas_comprado = productos_data.first() if productos_data else None
        menos_comprado = productos_data.last() if productos_data else None

        context['lista_compras'] = compras
        context['total_general'] = total_general
        context['mas_comprado'] = mas_comprado
        context['menos_comprado'] = menos_comprado
        return context
