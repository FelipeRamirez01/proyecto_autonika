from flask import Blueprint, render_template, request, redirect, url_for, flash, current_app
from flask_login import login_required, current_user
from functools import wraps
from app import db
import os
from models.roles import Roles, Permisos, RolPermiso
from models.datos_app import Datos_app
from controllers.log import registrar_log

config_bp = Blueprint('config', __name__)

def require_permission(*permission_names):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            permisos_usuario = db.session.query(Permisos.nombre).join(RolPermiso).filter(
                RolPermiso.rol_id == current_user.id_rol
            ).all()

            permisos_usuario = [permiso.nombre for permiso in permisos_usuario]

            # Verifica si el usuario tiene al menos uno de los permisos requeridos
            if not any(p in permisos_usuario for p in permission_names):
                flash("No tienes permiso para acceder a esta función.", "danger")
                return redirect(url_for('main.no_autorizado'))

            return func(*args, **kwargs)
        return wrapper
    return decorator

@config_bp.route('')
@login_required
@require_permission('Configuracion')
def configuracion():
    registrar_log(current_user.id,"Configuracion", "Visualiza opciones de configuracion") 
    return render_template('config/configuracion.html')

@config_bp.route("/datos_conjunto", methods=["GET", "POST"])
@login_required
@require_permission('Configuracion')
def gestionar_datos_conjunto():
    datos = Datos_app.query.first()  # Solo debe existir un registro
    if request.method == "POST":

        print(request.files)
                # Guardar archivos PDF
        base_dir = os.path.abspath(os.path.join(current_app.root_path, '..'))
        carpeta_config = os.path.join(base_dir, 'static', 'configuracion')
        os.makedirs(carpeta_config, exist_ok=True)

        terminos_pdf = request.files.get("terminos_pdf")
        politicas_pdf = request.files.get("politicas_pdf")

        if terminos_pdf and terminos_pdf.filename.endswith(".pdf"):
            filename = "terminos_condiciones.pdf"
            ruta_terminos = os.path.join(carpeta_config, filename)
            terminos_pdf.save(ruta_terminos)
            datos.terminos_pdf = filename

        if politicas_pdf and politicas_pdf.filename.endswith(".pdf"):
            filename = "politicas_privacidad.pdf"
            ruta_politicas = os.path.join(carpeta_config, filename)
            politicas_pdf.save(ruta_politicas)
            datos.politicas_pdf = filename

        if datos:
            datos.nombre = request.form["nombre"]
            datos.direccion = request.form["direccion"]
            datos.telefono = request.form["telefono"]
            datos.nit = request.form["nit"]
            datos.numero_cuenta = request.form["numero_cuenta"]
            datos.codigo_cuenta = request.form["codigo_cuenta"]

        else:
            datos = Datos_app(
                nombre=request.form["nombre"],
                direccion=request.form["direccion"],
                telefono=request.form["telefono"],
                nit=request.form["nit"],
                numero_cuenta=request.form["numero_cuenta"],
                codigo_cuenta=request.form["codigo_cuenta"],
                terminos_pdf="terminos_condiciones.pdf" if terminos_pdf else None,
                politicas_pdf="politicas_privacidad.pdf" if politicas_pdf else None
            )
            db.session.add(datos)

        db.session.commit()
        registrar_log(current_user.id,"Configuracion","Modifica Datos del conjunto") 
        flash("Datos del conjunto actualizados correctamente", "success")
        return redirect(url_for("config.gestionar_datos_conjunto"))
    return render_template("config/datos_conjunto.html", datos=datos)

@config_bp.route('/eliminar_pdf/<string:tipo>', methods=['POST','GET' ])
@login_required
@require_permission('Configuracion')
def eliminar_pdf(tipo):
    datos = Datos_app.query.first()
    base_dir = os.path.abspath(os.path.join(current_app.root_path, '..'))
    carpeta_config = os.path.join(base_dir, 'static', 'configuracion')

    if tipo == 'terminos' and datos and datos.terminos_pdf:
        ruta = os.path.join(carpeta_config, datos.terminos_pdf)
        if os.path.exists(ruta):
            os.remove(ruta)
        datos.terminos_pdf = None

    elif tipo == 'politicas' and datos and datos.politicas_pdf:
        ruta = os.path.join(carpeta_config, datos.politicas_pdf)
        if os.path.exists(ruta):
            os.remove(ruta)
        datos.politicas_pdf = None

    db.session.commit()
    registrar_log(current_user.id, "Configuracion", f"Elimina archivo PDF: {tipo}")
    flash(f"Archivo de {tipo} eliminado correctamente.", "info")
    return redirect(url_for('config.gestionar_datos_conjunto'))

# Listar todos los roles
@config_bp.route('/roles', methods=['GET', 'POST'])
@login_required
@require_permission('Ver Roles')
def listar_roles():

    #roles = Roles.query.all()
    roles = Roles.query.filter(Roles.id != 99).all()
    permisos = Permisos.query.order_by(Permisos.tipo.asc()).all()
    registrar_log(current_user.id,"Roles","Lista Roles")
    
    return render_template('roles/gestionar_roles.html', roles=roles, permisos=permisos)


@config_bp.route('/roles/crear', methods=['GET', 'POST'])
@login_required
@require_permission('Crear Roles')
def gestionar_roles():
    if request.method == 'POST':
        nombre = request.form.get('nombre')
        permisos_seleccionados = request.form.getlist('permisos')

        if not nombre:
            flash("El nombre del rol es obligatorio.", "danger")
            return redirect(url_for('config.gestionar_roles'))

        nuevo_rol = Roles(nombre=nombre)
        permisos = Permisos.query.filter(Permisos.id.in_(permisos_seleccionados)).all()
        nuevo_rol.permisos.extend(permisos)

        db.session.add(nuevo_rol)
        db.session.commit()
        registrar_log(current_user.id,"Roles", "Crea rol id: "+ str(nuevo_rol.id)+" Nombre: "+str(nombre)) 
        flash("Rol creado correctamente.", "success")
        return redirect(url_for('config.gestionar_roles'))

    #roles = Roles.query.all()
    roles = Roles.query.filter(Roles.id != 99).all()

    permisos = Permisos.query.order_by(Permisos.tipo.asc()).all()
    return render_template('roles/crear_rol.html', roles=roles, permisos=permisos)

# Editar el rol que se desea
@config_bp.route('/roles/editar/<int:id>', methods=['GET', 'POST'])
@login_required
@require_permission('Modificar Roles')
def editar_rol(id):
    rol = Roles.query.get_or_404(id)
    permisos = Permisos.query.all()  # Obtener todos los permisos disponibles

    if request.method == 'POST':
        nuevo_nombre = request.form.get('nombre')
        permisos_seleccionados = request.form.getlist('permisos')

        if not nuevo_nombre:
            flash('El nombre del rol no puede estar vacío', 'danger')
            return redirect(url_for('config.editar_rol', id=id))

        # Actualizar el nombre del rol
        rol.nombre = nuevo_nombre

        # Actualizar permisos asociados al rol
        rol.permisos.clear()
        for permiso_id in permisos_seleccionados:
            permiso = Permisos.query.get(permiso_id)
            if permiso:
                rol.permisos.append(permiso)

        db.session.commit()
        registrar_log(current_user.id,"Roles", "Edita rol id: "+ str(rol.id)+" Nombre: "+str(rol.nombre)) 
        flash('Rol actualizado correctamente', 'success')
        return redirect(url_for('config.listar_roles'))

    return render_template('roles/editar_rol.html', rol=rol, permisos=permisos)
# Elimina el rol seleccionado
@config_bp.route('/roles/eliminar_rol/<int:rol_id>', methods=['POST'])
@login_required
@require_permission('Eliminar Roles')
def eliminar_rol(rol_id):
    if request.method == 'POST':
        rol = Roles.query.get_or_404(rol_id)
        registrar_log(current_user.id,"Roles", "Elimina rol id: "+ str(rol.id)+" Nombre: "+str(rol.nombre)) 
        db.session.delete(rol)
        db.session.commit() 
        flash('Rol eliminado correctamente.', 'success')
        return redirect(url_for('config.gestionar_roles'))


