from django import forms
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.forms import ReadOnlyPasswordHashField

from .models import Rol, Usuario


class UsuarioAdminCreationForm(forms.ModelForm):
	password1 = forms.CharField(label='Contraseña', widget=forms.PasswordInput)
	password2 = forms.CharField(label='Confirmar contraseña', widget=forms.PasswordInput)

	class Meta:
		model = Usuario
		fields = ('Correo', 'Documento', 'Primer_nombre', 'Primer_apellido', 'Telefono', 'rol')

	def clean_password2(self):
		password1 = self.cleaned_data.get('password1')
		password2 = self.cleaned_data.get('password2')
		if password1 and password2 and password1 != password2:
			raise forms.ValidationError('Las contraseñas no coinciden.')
		return password2

	def save(self, commit=True):
		user = super().save(commit=False)
		user.set_password(self.cleaned_data['password1'])
		if commit:
			user.save()
		return user


class UsuarioAdminChangeForm(forms.ModelForm):
	password = ReadOnlyPasswordHashField(label='Contraseña')

	class Meta:
		model = Usuario
		fields = (
			'Correo',
			'password',
			'Documento',
			'Primer_nombre',
			'Primer_apellido',
			'Telefono',
			'rol',
			'is_active',
			'is_staff',
			'is_superuser',
			'groups',
			'user_permissions',
		)


@admin.register(Rol)
class RolAdmin(admin.ModelAdmin):
	list_display = ('id', 'Nombre')
	search_fields = ('Nombre',)


@admin.register(Usuario)
class UsuarioAdmin(UserAdmin):
	model = Usuario
	form = UsuarioAdminChangeForm
	add_form = UsuarioAdminCreationForm
	ordering = ('Correo',)
	list_display = (
		'Correo',
		'Primer_nombre',
		'Primer_apellido',
		'rol',
		'is_staff',
		'is_superuser',
		'is_active',
	)
	search_fields = ('Correo', 'Documento', 'Primer_nombre', 'Primer_apellido')
	fieldsets = (
		(None, {'fields': ('Correo', 'password')}),
		('Información personal', {
			'fields': ('Documento', 'Primer_nombre', 'Primer_apellido', 'Telefono', 'rol')
		}),
		('Permisos', {
			'fields': ('is_active', 'is_staff', 'is_superuser', 'groups', 'user_permissions')
		}),
		('Acceso', {'fields': ('last_login',)}),
	)
	add_fieldsets = (
		(None, {
			'classes': ('wide',),
			'fields': (
				'Correo',
				'Documento',
				'Primer_nombre',
				'Primer_apellido',
				'Telefono',
				'rol',
				'password1',
				'password2',
				'is_active',
				'is_staff',
				'is_superuser',
			),
		}),
	)
