from flask import Blueprint, render_template, request, redirect, url_for, flash,  session
from flask_login import login_required, current_user, login_user, logout_user
from werkzeug.security import generate_password_hash, check_password_hash
from app import db, login_manager
from datetime import datetime
from models.usuario import Usuarios
from models.roles import Roles
from controllers.configuracion import require_permission
from controllers.log import registrar_log

users_bp = Blueprint("usuarios", __name__)


@login_manager.user_loader
def load_user(user_id):
    return Usuarios.query.get(int(user_id))
from functools import wraps


@users_bp.route('/')
def home():
    return render_template('home/home.html')

@users_bp.route('/register', methods=['GET', 'POST'])
@login_required
#@require_permission('Crear Usuarios')
def register():
    if request.method == 'POST':
     
        try:
            from controllers.configuracion import require_permission
            require_permission('Crear Usuario')
            nombre = request.form['nombre']
            identificacion = request.form['identificacion']
            email = request.form['email']
            contraseña = request.form['password']
            id_rol = int(request.form['id_rol'])
            telefono= request.form['telefono']
            

            # Verificar si el rol existe
            role = Roles.query.get(id_rol)
            if not role:
                flash('Rol no válido', 'danger')
                return redirect(url_for('usuarios.register'))
                
            # Verificar si el usuario ya existe
            existing_user = Usuarios.query.filter_by(email=email).first()
            if existing_user:
                flash('El nombre de email ya está en uso', 'warning')
                return redirect(url_for('usuarios.register'))    
            
            hashed_password = generate_password_hash(contraseña)

            new_user = Usuarios(nombre=nombre, identificacion=identificacion, email=email, contraseña=hashed_password, telefono=telefono, id_rol=id_rol, estado=1 )
            db.session.add(new_user)
            db.session.commit()
            registrar_log(current_user.id,"Registro", "Se crea Usuario id "+ str(nombre)+" correo "+str(email)+ " identificacion "+str(identificacion))  
            flash('Usuario registrado con éxito', 'success')
            return redirect(url_for('usuarios.listar_usuarios'))
        except Exception as e:
            db.session.rollback()  # Deshacer la transacción si ocurre un error
            print(f'Error en el registro: {str(e)}', 'danger')
        
    return render_template('auth/register.html', roles = Roles.query.filter(Roles.id != 99).all())

@users_bp.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        user = Usuarios.query.filter_by(email=username).first()
        hoy = datetime.now()

        if user:
            if user.estado != 1:
                flash('Usuario Bloqueado', 'danger')
            else:
                # Primero validar contraseña normal
                if check_password_hash(user.contraseña, password):
                    login_user(user)
                    registrar_log(current_user.id, "Login", "Inicia Sesion")
                    

                    user.codigo_temporal = None
                    user.fecha_temporal = None
                    db.session.commit()

                    session['username'] = username
                    session['role'] = user.rol.nombre
                    session.permanent = True
                    
                    return redirect(url_for('maquinas.listar_maquinas'))
                        

                # Si falla la contraseña normal, intentamos con código temporal
                elif user.codigo_temporal and check_password_hash(user.codigo_temporal, password):
                    if hoy <= user.fecha_temporal:
                        login_user(user) 
                        registrar_log(user.id, "Login", "Inicia Sesion por Codigo Temporal")
                        return redirect(url_for('api_mail.reset_password', id=user.id))
                    else:
                        flash('El código temporal ha expirado', 'danger')

                else:
                    flash('Usuario o contraseña incorrectos', 'danger')

        else:
            flash('Usuario No existe', 'danger')

    return render_template('auth/login.html')



@users_bp.route('/logout')
@login_required
def logout():
    registrar_log(current_user.id,"Cierra Sesion", "Cierra Sesion") 
    logout_user()
    return redirect(url_for('usuarios.home'))

@users_bp.route('/no_autorizado')
def no_autorizado():
    registrar_log(current_user.id,"No Autorizado", "Ingresa a lugar No permitido") 
    return render_template('no_autorizado.html', usuario=current_user.id), 403  # Código de estado HTTP 403 (Prohibido)

@users_bp.route('/admin')
@login_required
def home_admin():
    registrar_log(current_user.id,"Home-Admin", "Ingresa a Home-Admin") 
    return render_template('home/home_admin.html')

@users_bp.route('/usuario')
@login_required
def home_usuario():
    registrar_log(current_user.id,"Home-Usuario", "Ingresa a Home-Usuario") 
    return render_template('home/home_usuario.html')

# Mostrar lista de usuarios
@users_bp.route("/usuarios")
@login_required
#@require_permission('Administrar Usuarios')
def listar_usuarios():
    #usuarios = Usuarios.query.all()
    usuarios = Usuarios.query.filter(Usuarios.id != 4).all()
    #roles = Roles.query.all()
    roles = Roles.query.filter(Roles.id != 99).all()
    
    registrar_log(current_user.id,"Usuarios", "Visualiza Lista Usuarios")
    return render_template("usuarios/usuarios.html", usuarios=usuarios, roles=roles)

# Editar usuario
@users_bp.route("/editar_usuario/<int:id>", methods=["GET", "POST"])
@login_required
#@require_permission('Modificar Usuario')
def editar_usuario(id):
    usuario = Usuarios.query.get_or_404(id)
    roles = Roles.query.filter(Roles.id != 5).all()

    if request.method == "POST":
        usuario.nombre = request.form["nombre"]
        usuario.identificacion = request.form["identificacion"]
        usuario.email = request.form["email"]
        usuario.telefono = request.form["telefono"]
        usuario.id_rol = request.form["id_rol"]


        nueva_contraseña = request.form['contraseña']
        if nueva_contraseña:
            usuario.contraseña = generate_password_hash(nueva_contraseña)

        db.session.commit()

        registrar_log(current_user.id, "Usuarios","Edita Usuario")

        flash("Usuario actualizado correctamente.", "success")
        return redirect(url_for("usuarios.listar_usuarios"))

    return render_template("usuarios/editar_usuario.html", usuario=usuario, roles=roles)

# Eliminar usuario
@users_bp.route("/eliminar_usuario/<int:id>", methods=["POST"])
@login_required
#@require_permission('Administrar Usuarios')
def eliminar_usuario(id):
    usuario = Usuarios.query.get_or_404(id)
    db.session.delete(usuario)
    db.session.commit()

    registrar_log(current_user.id,"Usuarios", "Elimina Usuario")
    flash("Usuario eliminado correctamente.", "success")
    return redirect(url_for("usuarios.listar_usuarios"))

# inhabilitar usuario
@users_bp.route("/inhabilitar/<int:id>", methods=["POST"])
@login_required
#@require_permission('Inhabilitar Usuario')
def inhabilitar(id):
    usuario = Usuarios.query.get_or_404(id)
    usuario.estado=2
    db.session.commit()
    registrar_log(current_user.id,"Usuarios", "Inhabilita Usuario")
    flash("Usuario Inhabilitado correctamente.", "success")
    return redirect(url_for("usuarios.listar_usuarios"))

# habilitar usuario
@users_bp.route("/habilitar/<int:id>", methods=["POST"])
@login_required
#@require_permission('Habilitar Usuario')
def habilitar(id):
    usuario = Usuarios.query.get_or_404(id)
    usuario.estado=1
    db.session.commit()
    registrar_log(current_user.id,"Usuarios", "Habilita Usuario")
    flash("Usuario Habilitado correctamente.", "success")
    return redirect(url_for("usuarios.listar_usuarios"))



@users_bp.route('/editar_datos/<int:id>', methods=['GET', 'POST'])
@login_required
def editar_datos(id):
    # Obtener el usuario actual desde la sesión

    usuario = Usuarios.query.get_or_404(id)

    if request.method == 'POST':

        email = request.form.get('email')
        telefono = request.form.get('telefono')
        nueva_contraseña = request.form.get('contraseña')

        # Validar campos
        if not email:
            flash('Nombre y email son obligatorios.', 'danger')
            return redirect(url_for('usuarios.editar_datos'))


        usuario.email = email
        usuario.telefono = telefono

        if nueva_contraseña and nueva_contraseña.strip() != '':
            usuario.contraseña = generate_password_hash(nueva_contraseña)

        try:
            registrar_log(current_user.id,"Usuarios", "Edita Datos Usuario")
            db.session.commit()
            flash('✅ Tus datos fueron actualizados correctamente.', 'success')
        except Exception as e:
            db.session.rollback()
            flash(f'❌ Ocurrió un error: {str(e)}', 'danger')

        return redirect(url_for('usuarios.editar_datos'))

    return render_template('usuarios/cambiar_datos_usuario.html', usuario=usuario)
