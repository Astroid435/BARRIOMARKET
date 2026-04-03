import re
import random

from django.conf import settings
from django.contrib import messages
from django.contrib.auth import login as auth_login
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from django.contrib.auth.views import LoginView
from django.core.mail import send_mail
from django.shortcuts import redirect
from django.utils.timezone import now
from django.views.generic import TemplateView, FormView

from .forms import MyUserCreationForm
from .models import Usuario


# ---------- Mixins ----------

class NoAutenticadoMixin(UserPassesTestMixin):
    login_url = 'inicio'

    def test_func(self):
        return not self.request.user.is_authenticated


class AdminRequeridoMixin(LoginRequiredMixin, UserPassesTestMixin):
    login_url = 'inicio'

    def test_func(self):
        return self.request.user.is_authenticated and self.request.user.rol.Nombre == 'Administrador'


class AutenticadoMixin(LoginRequiredMixin):
    login_url = 'inicio'


# ---------- Helpers ----------

def generate_code():
    digits = [str(random.randint(0, 9)) for _ in range(4)]
    repeat_digit = random.choice(digits)
    code = digits + [repeat_digit, repeat_digit]
    random.shuffle(code)
    return ''.join(code)


def send_recovery_email(user_email, code):
    subject = 'Recuperación de contraseña'
    message = f"""
    <html>
    <head>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');
            body {{
                font-family: 'Poppins', sans-serif;
                background-color: #f8f8f8;
                color: #333333;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }}
            .email-container {{
                width: 100%;
                max-width: 600px;
                background-color: #ffffff;
                padding: 40px;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                text-align: center;
                border: 1px solid #e1e1e1;
            }}
            h1 {{ font-size: 32px; color: #333333; font-weight: 600; margin-bottom: 20px; }}
            p {{ font-size: 16px; color: #666666; line-height: 1.6; margin-bottom: 20px; }}
            .code {{
                font-size: 28px; font-weight: 600; color: #ffffff;
                background-color: #333333; padding: 15px; border-radius: 8px;
                display: inline-block; margin-top: 20px; letter-spacing: 1px;
            }}
            .footer {{ margin-top: 30px; font-size: 14px; color: #999999; }}
            .footer a {{ color: #333333; text-decoration: none; }}
        </style>
    </head>
    <body>
        <div class="email-container">
            <h1>Recuperación de Contraseña</h1>
            <p>Hola,</p>
            <p>Hemos recibido una solicitud para recuperar tu contraseña. Tu código de recuperación es:</p>
            <p class="code">{code}</p>
            <p>Este código es válido por 10 minutos.</p>
            <p class="footer">Si no solicitaste este cambio, por favor ignora este mensaje.</p>
        </div>
    </body>
    </html>
    """
    email_from = settings.EMAIL_HOST_USER
    recipient_list = [user_email]
    send_mail(subject, message, email_from, recipient_list, html_message=message)


# ---------- Vistas ----------

class AuthView(NoAutenticadoMixin, TemplateView):
    template_name = 'auth.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        login_form = AuthenticationForm()
        login_form.fields['username'].widget.attrs.update({
            'class': 'form-control', 'placeholder': 'Correo'
        })
        login_form.fields['password'].widget.attrs.update({
            'class': 'form-control', 'placeholder': 'Contraseña'
        })
        context['login_form'] = login_form
        context['register_form'] = MyUserCreationForm()
        return context

    def post(self, request, *args, **kwargs):
        if 'btn_login' in request.POST:
            login_form = AuthenticationForm(request, data=request.POST)
            if login_form.is_valid():
                auth_login(request, login_form.get_user())
                return redirect('/inicio')
            context = self.get_context_data()
            context['login_form'] = login_form
            return self.render_to_response(context)

        elif 'btn_register' in request.POST:
            register_form = MyUserCreationForm(request.POST)
            if register_form.is_valid():
                register_form.save()
                return redirect('/inicio')
            context = self.get_context_data()
            context['register_form'] = register_form
            return self.render_to_response(context)

        return self.render_to_response(self.get_context_data())


class RegisterView(NoAutenticadoMixin, FormView):
    template_name = 'registro.html'
    form_class = MyUserCreationForm
    success_url = '/inicio'

    def form_valid(self, form):
        form.save()
        return super().form_valid(form)


class PerfilView(AutenticadoMixin, TemplateView):
    template_name = 'Perfil.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        if self.request.user.es_administrador:
            context['usuarios'] = Usuario.objects.all()
        return context

    def post(self, request, *args, **kwargs):
        nombre = request.POST.get('nombre')
        apellido = request.POST.get('apellido')
        telefono = request.POST.get('Telefono')
        documento = request.POST.get('Documento')

        if not all([nombre, apellido, telefono, documento]):
            messages.error(request, "Por favor, completa todos los campos.")
            return redirect('/Perfil')

        errors = []
        if not re.match(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$', nombre):
            errors.append("El nombre solo puede contener letras y espacios.")
        if not re.match(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$', apellido):
            errors.append("El apellido solo puede contener letras y espacios.")
        if len(nombre) < 2:
            errors.append("El nombre debe tener al menos 2 caracteres.")
        if len(apellido) < 2:
            errors.append("El apellido debe tener al menos 2 caracteres.")
        if not telefono.isdigit():
            errors.append("El teléfono solo puede contener números.")
        if len(telefono) < 7 or len(telefono) > 15:
            errors.append("El teléfono debe tener entre 7 y 15 dígitos.")
        if not documento.isdigit():
            errors.append("El documento solo puede contener números.")
        if len(documento) < 6:
            errors.append("El documento debe tener al menos 6 dígitos.")
        if Usuario.objects.filter(Documento=documento).exclude(id=request.user.id).exists():
            errors.append("Este documento ya está registrado por otro usuario.")

        if errors:
            for error in errors:
                messages.error(request, error)
            return redirect('/Perfil')

        usuario = request.user
        usuario.Primer_nombre = nombre.strip()
        usuario.Primer_apellido = apellido.strip()
        usuario.Telefono = telefono
        usuario.Documento = documento
        usuario.save()
        messages.success(request, "Datos actualizados correctamente.")

        return redirect('/Perfil')


class CustomLoginView(LoginView):
    form_class = AuthenticationForm
    template_name = 'login.html'

    def get_form(self, form_class=None):
        form = super().get_form(form_class)
        form.fields['username'].widget.attrs.update({
            'class': 'form-control', 'placeholder': 'Correo'
        })
        form.fields['password'].widget.attrs.update({
            'class': 'form-control', 'placeholder': 'Contraseña'
        })
        return form


class SolicitarCorreoView(TemplateView):
    template_name = 'CambioContrasena/SolicitudCorreo.html'

    def post(self, request, *args, **kwargs):
        email = request.POST.get('Correo', '')
        try:
            user = Usuario.objects.get(Correo=email)
            code = generate_code()
            send_recovery_email(user.Correo, code)
            request.session['reset_code'] = code
            request.session['reset_email'] = email
            request.session['code_generated_time'] = now().timestamp()
            return redirect('/CambioContrasena/Codigo')
        except Usuario.DoesNotExist:
            pass
        return self.render_to_response({})


class SolicitarCodigoView(TemplateView):
    template_name = 'CambioContrasena/SolicitudCodigo.html'

    def post(self, request, *args, **kwargs):
        entered_code = request.POST.get('code', '')
        generated_code = request.session.get('reset_code')
        email = request.session.get('reset_email')
        code_time = request.session.get('code_generated_time')

        if generated_code and email:
            if entered_code == generated_code and now().timestamp() - code_time < 600:
                return redirect('/CambioContrasena/Cambio')
        return self.render_to_response({})


class SolicitarContrasenaView(TemplateView):
    template_name = 'CambioContrasena/SolicitudContrasena.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['Errores'] = []
        return context

    def post(self, request, *args, **kwargs):
        errores = []
        contrasena = request.POST.get('Contrasena')
        ccontrasena = request.POST.get('CContrasena')
        email = request.session.get('reset_email')

        if not email:
            return redirect('/CambioContrasena/')

        if contrasena and ccontrasena:
            if contrasena == ccontrasena:
                if len(contrasena) < 8:
                    errores.append("La contraseña debe tener al menos 8 caracteres")
                if not re.search(r'[A-Z]', contrasena):
                    errores.append("La contraseña debe tener al menos una letra mayúscula")
                if not re.search(r'\d', contrasena):
                    errores.append("La contraseña debe tener al menos un número")
                if not re.search(r'[@$!%*?&]', contrasena):
                    errores.append(
                        "La contraseña debe tener al menos un carácter especial (@, $, !, %, *, ?, &)"
                    )
                if not errores:
                    try:
                        usuario = Usuario.objects.get(Correo=email)
                    except Usuario.DoesNotExist:
                        return redirect('/CambioContrasena/')
                    usuario.set_password(contrasena)
                    usuario.save()
                    request.session.pop('reset_email', None)
                    request.session.pop('reset_code', None)
                    request.session.pop('code_generated_time', None)
                    return redirect('/login')
            else:
                errores.append("Las contraseñas no coinciden")

        return self.render_to_response({'Errores': errores})
