import json

from django.contrib.auth.mixins import LoginRequiredMixin
from django.http import JsonResponse
from django.views.generic import View

from .models import RegistroFalta


class RegistrarFaltanteView(LoginRequiredMixin, View):
    login_url = 'inicio'

    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body)
        except json.JSONDecodeError:
            return JsonResponse({'success': False, 'error': 'Datos inválidos.'})

        nombre = data.get('nombre_producto', '').strip()

        if not nombre:
            return JsonResponse({
                'success': False, 'error': 'El nombre del producto es obligatorio.'
            })

        faltante, creado = RegistroFalta.objects.get_or_create(
            NombreProducto=nombre,
            defaults={'Contador': 1}
        )

        if not creado:
            faltante.Contador += 1
            faltante.save()

        return JsonResponse({
            'success': True,
            'nombre': faltante.NombreProducto,
            'contador': faltante.Contador,
            'mensaje': 'Contador actualizado' if not creado else 'Producto registrado'
        })


class ListaFaltantesView(LoginRequiredMixin, View):
    login_url = 'inicio'

    def get(self, request, *args, **kwargs):
        faltantes = RegistroFalta.objects.all().order_by('-Contador')
        data = [
            {"NombreProducto": f.NombreProducto, "Contador": f.Contador}
            for f in faltantes
        ]
        return JsonResponse(data, safe=False)
