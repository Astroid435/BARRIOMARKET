from django import forms
from django.contrib.auth.forms import UserCreationForm, UserChangeForm
from .models import Usuario
import re  
from django.core.exceptions import ValidationError 

class MyUserCreationForm(forms.ModelForm):
    Correo = forms.EmailField(widget=forms.EmailInput(attrs={'class': 'form-control', 'placeholder': 'Ej: name@example.com'}))
    password1 = forms.CharField(label='Contraseña', widget=forms.PasswordInput(attrs={'class': 'form-control col-6', 'placeholder': 'Contraseña'}))
    password2 = forms.CharField(label='Confirma Contraseña', widget=forms.PasswordInput(attrs={'class': 'form-control col-6', 'placeholder': 'Cornfirmar contraseña'}))
    
    class Meta:
        model = Usuario
        fields = ['Correo', 'Primer_nombre', 'Primer_apellido', 'Documento', 'Telefono', 'password1', 'password2']
        help_texts = {k:"" for k in fields}  # Remover los help_texts
        widgets = {
            'Primer_nombre': forms.TextInput(attrs={'class': 'form-control col-6', 'placeholder': 'Primer Nombre'}),
            'Primer_apellido': forms.TextInput(attrs={'class': 'form-control col-6', 'placeholder': 'Primer Apellido'}),
            'Documento': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Documento'}),
            'Telefono': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Telefono'}),
        }

    def clean_password2(self):
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        errors = []

        if password1 != password2:
            errors.append("Las contraseñas no coinciden")
            
        if len(password1) < 8:
            errors.append("La contraseña debe tener al menos 8 caracteres")

        if not re.search(r'[A-Z]', password1):
            errors.append("La contraseña debe tener al menos una letra mayúscula")

        if not re.search(r'\d', password1):
            errors.append("La contraseña debe tener al menos un número")

        if not re.search(r'[@$!%*?&]', password1):
            errors.append("La contraseña debe tener al menos un carácter especial (@, $, !, %, *, ?, &)")
            
        if errors:
            raise ValidationError(errors)

        return password2
    
    
    def save(self, commit=True):
        user = super(MyUserCreationForm, self).save(commit=False)
        user.rol_id = 1  # Asigna el rol_id como 1
        user.set_password(self.cleaned_data["password1"])
        if commit:
            user.save()
        return user

class MyUserChangeForm(UserChangeForm):
    Correo = forms.EmailField(widget=forms.EmailInput(attrs={'class': 'form-control'}))
    password1 = forms.CharField(label='Contraseña', widget=forms.PasswordInput(attrs={'class': 'form-control col-6'}))
    password2 = forms.CharField(label='Confirma Contraseña', widget=forms.PasswordInput(attrs={'class': 'form-control col-6'}))
    
    class Meta:
        model = Usuario
        fields = ['Correo', 'Primer_nombre', 'Primer_apellido', 'Documento', 'Telefono', 'password1', 'password2']
        help_texts = {k:"" for k in fields}  # Remover los help_texts
        widgets = {
            'Primer_nombre': forms.TextInput(attrs={'class': 'form-control col-6'}),
            'Primer_apellido': forms.TextInput(attrs={'class': 'form-control col-6'}),
            'Documento': forms.TextInput(attrs={'class': 'form-control'}),
            'Telefono': forms.TextInput(attrs={'class': 'form-control'}),
        }
        