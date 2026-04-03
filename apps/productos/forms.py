from django import forms
from .models import Productos, Categoria, Subcategoria, Fabricante


class ProductoForm(forms.ModelForm):
    class Meta:
        model = Productos
        fields = ['Nombre', 'Cantidad', 'ValorCompra', 'ValorVenta', 'Descripcion', 'imagen', 'Fabricante']
        widgets = {
            'Nombre': forms.TextInput(attrs={'class': 'form-control'}),
            'Cantidad': forms.NumberInput(attrs={'class': 'form-control'}),
            'ValorCompra': forms.NumberInput(attrs={'class': 'form-control'}),
            'ValorVenta': forms.NumberInput(attrs={'class': 'form-control'}),
            'Descripcion': forms.Textarea(attrs={'class': 'form-control', 'rows': 3}),
            'imagen': forms.FileInput(attrs={'class': 'form-control'}),
            'Fabricante': forms.Select(attrs={'class': 'form-control'}),
        }


class CategoriaForm(forms.ModelForm):
    class Meta:
        model = Categoria
        fields = ['Nombre']
        widgets = {
            'Nombre': forms.TextInput(attrs={'class': 'form-control'}),
        }


class SubcategoriaForm(forms.ModelForm):
    class Meta:
        model = Subcategoria
        fields = ['Nombre', 'Categoria']
        widgets = {
            'Nombre': forms.TextInput(attrs={'class': 'form-control'}),
            'Categoria': forms.Select(attrs={'class': 'form-control'}),
        }


class FabricanteForm(forms.ModelForm):
    class Meta:
        model = Fabricante
        fields = ['Nombre', 'Telefono']
        widgets = {
            'Nombre': forms.TextInput(attrs={'class': 'form-control'}),
            'Telefono': forms.TextInput(attrs={'class': 'form-control'}),
        }
