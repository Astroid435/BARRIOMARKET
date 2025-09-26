from django import forms
from django.contrib.auth.forms import UserCreationForm, UserChangeForm
from .models import Usuario
import re  
from django.core.exceptions import ValidationError 


class MyUserCreationForm(forms.ModelForm):
    Correo = forms.EmailField(
        widget=forms.EmailInput(attrs={'class': 'form-control', 'placeholder': 'Ej: name@example.com'}),
        error_messages={
            'required': 'El correo electrónico es obligatorio',
            'invalid': 'Ingrese un correo electrónico válido'
        }
    )
    password1 = forms.CharField(
        label='Contraseña', 
        widget=forms.PasswordInput(attrs={'class': 'form-control col-6', 'placeholder': 'Contraseña'}),
        error_messages={
            'required': 'La contraseña es obligatoria'
        }
    )
    password2 = forms.CharField(
        label='Confirma Contraseña', 
        widget=forms.PasswordInput(attrs={'class': 'form-control col-6', 'placeholder': 'Confirmar contraseña'}),
        error_messages={
            'required': 'Debe confirmar la contraseña'
        }
    )
    
    class Meta:
        model = Usuario
        fields = ['Correo', 'Primer_nombre', 'Primer_apellido', 'Documento', 'Telefono', 'password1', 'password2']
        help_texts = {k:"" for k in fields}  # Remover los help_texts
        widgets = {
            'Primer_nombre': forms.TextInput(attrs={'class': 'form-control col-6', 'placeholder': 'Primer Nombre'}),
            'Primer_apellido': forms.TextInput(attrs={'class': 'form-control col-6', 'placeholder': 'Primer Apellido'}),
            'Documento': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Documento'}),
            'Telefono': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Teléfono'}),
        }
        error_messages = {
            'Primer_nombre': {
                'required': 'El primer nombre es obligatorio',
                'max_length': 'El nombre es demasiado largo'
            },
            'Primer_apellido': {
                'required': 'El primer apellido es obligatorio',
                'max_length': 'El apellido es demasiado largo'
            },
            'Documento': {
                'required': 'El documento es obligatorio',
                'unique': 'Este documento ya está registrado'
            },
            'Telefono': {
                'required': 'El teléfono es obligatorio'
            }
        }

    def clean_Correo(self):
        correo = self.cleaned_data.get('Correo')
        if Usuario.objects.filter(Correo=correo).exists():
            raise ValidationError('Este correo electrónico ya está registrado')
        return correo

    def clean_Primer_nombre(self):
        primer_nombre = self.cleaned_data.get('Primer_nombre')
        if not primer_nombre:
            raise ValidationError('El primer nombre es obligatorio')
        
        if not re.match(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$', primer_nombre):
            raise ValidationError('El nombre solo puede contener letras y espacios')
            
        if len(primer_nombre) < 2:
            raise ValidationError('El nombre debe tener al menos 2 caracteres')
            
        return primer_nombre.strip()

    def clean_Primer_apellido(self):
        primer_apellido = self.cleaned_data.get('Primer_apellido')
        if not primer_apellido:
            raise ValidationError('El primer apellido es obligatorio')
            
        if not re.match(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$', primer_apellido):
            raise ValidationError('El apellido solo puede contener letras y espacios')
            
        if len(primer_apellido) < 2:
            raise ValidationError('El apellido debe tener al menos 2 caracteres')
            
        return primer_apellido.strip()

    def clean_Documento(self):
        documento = self.cleaned_data.get('Documento')
        if not documento:
            raise ValidationError('El documento es obligatorio')
            
        if not documento.isdigit():
            raise ValidationError('El documento solo puede contener números')
            
        if len(documento) < 6:
            raise ValidationError('El documento debe tener al menos 6 dígitos')
            
        if Usuario.objects.filter(Documento=documento).exists():
            raise ValidationError('Este documento ya está registrado')
            
        return documento

    def clean_Telefono(self):
        telefono = self.cleaned_data.get('Telefono')
        if not telefono:
            raise ValidationError('El teléfono es obligatorio')
            
        if not telefono.isdigit():
            raise ValidationError('El teléfono solo puede contener números')
            
        if len(telefono) < 7 or len(telefono) > 15:
            raise ValidationError('El teléfono debe tener entre 7 y 15 dígitos')
            
        return telefono

    def clean_password2(self):
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        errors = []

        if not password1 or not password2:
            raise ValidationError("Debe completar ambos campos de contraseña")
            
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
    Correo = forms.EmailField(
        widget=forms.EmailInput(attrs={'class': 'form-control'}),
        error_messages={
            'required': 'El correo electrónico es obligatorio',
            'invalid': 'Ingrese un correo electrónico válido'
        }
    )
    password1 = forms.CharField(
        label='Contraseña', 
        widget=forms.PasswordInput(attrs={'class': 'form-control col-6'}),
        required=False
    )
    password2 = forms.CharField(
        label='Confirma Contraseña', 
        widget=forms.PasswordInput(attrs={'class': 'form-control col-6'}),
        required=False
    )
    
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
        error_messages = {
            'Primer_nombre': {
                'required': 'El primer nombre es obligatorio',
                'max_length': 'El nombre es demasiado largo'
            },
            'Primer_apellido': {
                'required': 'El primer apellido es obligatorio',
                'max_length': 'El apellido es demasiado largo'
            },
            'Documento': {
                'required': 'El documento es obligatorio'
            },
            'Telefono': {
                'required': 'El teléfono es obligatorio'
            }
        }

    def clean_password2(self):
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        
        # Solo validar si se proporcionó alguna contraseña
        if password1 or password2:
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