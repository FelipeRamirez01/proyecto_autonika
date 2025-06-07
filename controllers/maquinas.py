from flask import Blueprint, render_template, request, redirect, url_for, flash,  session, jsonify, abort
from flask_login import login_required, current_user, login_user, logout_user
from app import db, login_manager
from models.maquinas import Maquina, Reporte, Moldeo, Apilado, Secador, Horno, Descargue, TemperaturaHorno

from datetime import date, datetime, timedelta
from zoneinfo import ZoneInfo


maquinas_bp = Blueprint("maquinas", __name__)

zona_colombia = ZoneInfo("America/Bogota")

@maquinas_bp.route('')
@login_required
def listar_maquinas():
    maquinas = Maquina.query.all()
    return render_template('maquinas/listar_maquinas.html', maquinas=maquinas)

@maquinas_bp.route('/gestion_maquinas')
@login_required
def index():
    maquinas = Maquina.query.all()
    return render_template('maquinas/index.html', maquinas=maquinas)

@maquinas_bp.route('/nueva_maquina', methods=['GET', 'POST'])
@login_required
def nueva_maquina():
    if request.method == 'POST':

        nombre = request.form.get('nombre', '').strip()
        tipo = request.form['tipo']

        nueva = Maquina(
            nombre=nombre,
            tipo=tipo
        )
        db.session.add(nueva)
        db.session.commit()

    return render_template('maquinas/nueva_maquina.html')

@maquinas_bp.route('/<int:id>', methods=['GET'])
@login_required
def ver_maquina(id):
    
    maquina = Maquina.query.get_or_404(id)
    tipo = maquina.tipo
    
    if tipo == "horno":
        horno = Horno.query.filter_by(maquina_id=id).first()

        fecha_str = request.args.get('fecha')
        if fecha_str:
            try:
                fecha = datetime.strptime(fecha_str, '%Y-%m-%d').date()
            except ValueError:
                fecha = datetime.now(tz=zona_colombia).date()
        else:
            fecha = datetime.now(tz=zona_colombia).date()

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
        datos_especificos = Moldeo.query.filter_by(maquina_id=id).first()
        return render_template('maquinas/detalle_moldeo.html', maquina=maquina, datos=datos_especificos)
    elif tipo == 'secador':
        maquina = Maquina.query.get_or_404(id)
        datos = Secador.query.filter_by(maquina_id=maquina.id).order_by(Secador.id.desc()).first()

        # Obtener fechas desde el query string
        fecha_inicio = request.args.get('fecha_inicio')
        fecha_fin = request.args.get('fecha_fin')

        # Filtro base
        query = Secador.query.filter_by(maquina_id=maquina.id)

        if fecha_inicio:
            fecha_inicio = datetime.strptime(fecha_inicio, "%Y-%m-%d").date()
            query = query.filter(Secador.fecha >= fecha_inicio)

        if fecha_fin:
            fecha_fin = datetime.strptime(fecha_fin, "%Y-%m-%d").date()
            query = query.filter(Secador.fecha <= fecha_fin)

        historial = query.order_by(Secador.fecha.asc()).all()

        return render_template('maquinas/detalle_secador.html', maquina=maquina, datos=datos, historial=historial)
    elif tipo == 'apilado':
        datos_especificos = Apilado.query.filter_by(maquina_id=id).first()
        return render_template('maquinas/detalle_apilado.html', maquina=maquina, datos=datos_especificos)
    elif tipo == 'descargue':
        maquina = Maquina.query.get_or_404(id)
        datos = Descargue.query.filter_by(maquina_id=maquina.id).order_by(Descargue.id.desc()).first()

        # Obtener fechas desde el query string
        fecha_inicio = request.args.get('fecha_inicio')
        fecha_fin = request.args.get('fecha_fin')

        # Filtro base
        query = Descargue.query.filter_by(maquina_id=maquina.id)

        if fecha_inicio:
            fecha_inicio = datetime.strptime(fecha_inicio, "%Y-%m-%d").date()
            query = query.filter(Descargue.fecha >= fecha_inicio)

        if fecha_fin:
            fecha_fin = datetime.strptime(fecha_fin, "%Y-%m-%d").date()
            query = query.filter(Descargue.fecha <= fecha_fin)

        historial = query.order_by(Descargue.fecha.asc()).all()

        return render_template(
            "maquinas/detalle_descargue.html",maquina=maquina, datos=datos, historial=historial)
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