from flask import Blueprint, render_template, request, redirect, url_for, flash,  session
from app import db, login_manager
from models.DatosHorno import DatosHorno


maquinas_bp = Blueprint("maquinas", __name__)


@maquinas_bp.route('/control-horno')
def control_horno():
    datos = DatosHorno.query.order_by(DatosHorno.zona.asc()).all()
    return render_template('maquinas/control_horno.html', datos=datos)