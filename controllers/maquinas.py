from flask import Blueprint, render_template, request, redirect, url_for, flash,  session, jsonify, abort
from flask_login import login_required, current_user, login_user, logout_user
from app import db, login_manager
from models.maquinas import Maquina, Reporte, Moldeo, Apilado, Secador, Horno, Descargue, TemperaturaHorno

from datetime import datetime,timedelta


maquinas_bp = Blueprint("maquinas", __name__)

@maquinas_bp.route('/')
@login_required
def index():
    maquinas = Maquina.query.all()
    return render_template('maquinas/index.html', maquinas=maquinas)

@maquinas_bp.route('/nueva_maquina', methods=['GET', 'POST'])
@login_required
def nueva_maquina():
    if request.method == 'POST':

        nombre = request.form.get('nombre', '').strip()
        ubicacion = request.form['ubicacion']
        temperatura_max = request.form['temperatura_max']
        temperatura_min = request.form['temperatura_min']
        velocidad = request.form['velocidad']
        produccion_min = request.form['produccion_min']
        tipo = request.form['tipo']

        nueva = Maquina(
            nombre=nombre,
            ubicacion=ubicacion,
            temperatura_max=temperatura_max,
            temperatura_min=temperatura_min,
            velocidad=velocidad,
            produccion_min=produccion_min,
            tipo=tipo
        )
        db.session.add(nueva)
        db.session.commit()

    return render_template('maquinas/nueva_maquina.html')

@maquinas_bp.route('/<int:id>', methods=['GET'])
#@login_required
def ver_maquina(id):
    
    maquina = Maquina.query.get_or_404(id)
    tipo = maquina.tipo
    
    if tipo == "horno":
        horno = Horno.query.filter_by(maquina_id=id).first()

        print(f"Horno encontrado: {horno.id}")

        fecha_str = request.args.get('fecha')
        if fecha_str:
            try:
                fecha = datetime.strptime(fecha_str, '%Y-%m-%d').date()
            except ValueError:
                fecha = datetime.now().date()
        else:
            fecha = datetime.now().date()

       # Trunca a la medianoche
        inicio_dia = datetime.combine(fecha, datetime.min.time())
        fin_dia = inicio_dia + timedelta(days=1)

        temp_dia = TemperaturaHorno.query.filter(
            TemperaturaHorno.horno_id == horno.id,
            TemperaturaHorno.fecha >= inicio_dia,
            TemperaturaHorno.fecha < fin_dia
        ).first()     

        temperaturas = []
        if temp_dia:
            temperaturas = [getattr(temp_dia, f"temperatura_{i}") for i in range(1, 41)]

        return render_template('maquinas/detalle_horno.html',
                               maquina=maquina,
                               horno=horno,
                               fecha=fecha.strftime('%Y-%m-%d'),
                               temperaturas=temperaturas)

    elif tipo == 'moldeo':
        datos_especificos = Moldeo.query.filter_by(id_maquina=id).first()
        return render_template('maquinas/detalle_moldeo.html', maquina=maquina, datos=datos_especificos)
    elif tipo == 'secador':
        datos_especificos = Secador.query.filter_by(id_maquina=id).first()
        return render_template('maquinas/detalle_secador.html', maquina=maquina, datos=datos_especificos)
    elif tipo == 'apilado':
        datos_especificos = Apilado.query.filter_by(id_maquina=id).first()
        return render_template('maquinas/detalle_apilado.html', maquina=maquina, datos=datos_especificos)
    elif tipo == 'descargue':
        datos_especificos = Descargue.query.filter_by(id_maquina=id).first()
        return render_template('maquinas/detalle_descargue.html', maquina=maquina, datos=datos_especificos)
    else:
        print(f"Tipo de máquinass: {tipo}")
        abort(404)

# API PARA RECIBIR REPORTE
@maquinas_bp.route('/api/reportes', methods=['POST'])
@login_required
def recibir_reporte():
    data = request.get_json()
    nuevo = Reporte(
        id_maquina=data['id_maquina'],
        temperatura=data['temperatura'],
        velocidad=data['velocidad'],
        produccion=data['produccion']
    )
    db.session.add(nuevo)
    db.session.commit()
    return jsonify({'mensaje': 'Reporte recibido'}), 201

# VISTA PARA GRAFICAS
@maquinas_bp.route('/maquina/<int:id>/graficas')
@login_required
def grafica(id):
    maquina = Maquina.query.get_or_404(id)
    reportes = Reporte.query.filter_by(id_maquina=id).order_by(Reporte.timestamp.asc()).all()
    return render_template('maquinas/graficas.html', maquina=maquina, reportes=reportes)