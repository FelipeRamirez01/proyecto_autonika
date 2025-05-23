from flask import Blueprint, render_template, request, redirect, url_for, flash,  session, jsonify
from flask_login import login_required, current_user, login_user, logout_user
from app import db, login_manager
from models.maquinas import Maquina, Reporte


maquinas_bp = Blueprint("maquinas", __name__)

@maquinas_bp.route('/')
@login_required
def index():
    maquinas = Maquina.query.all()
    return render_template('maquinas/index.html', maquinas=maquinas)

@maquinas_bp.route('/maquina/nueva', methods=['GET', 'POST'])
@login_required
def nueva_maquina():
    if request.method == 'POST':
        nueva = Maquina(
            nombre=request.form['nombre'],
            ubicacion=request.form['ubicacion'],
            temperatura_max=request.form['temperatura_max'],
            temperatura_min=request.form['temperatura_min'],
            velocidad=request.form['velocidad'],
            produccion_min=request.form['produccion_min']
        )
        db.session.add(nueva)
        db.session.commit()
        return redirect(url_for('maquinas.index'))
    return render_template('maquinas/nueva_maquina.html')

@maquinas_bp.route('/maquina/<int:id>')
@login_required
def ver_maquina(id):
    maquina = Maquina.query.get_or_404(id)
    reportes = Reporte.query.filter_by(id_maquina=id).order_by(Reporte.timestamp.desc()).limit(20).all()
    return render_template('maquinas/ver_maquina.html', maquina=maquina, reportes=reportes)

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