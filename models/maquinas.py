from app import db
from datetime import datetime

class Maquina(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)
    ubicacion = db.Column(db.String(100), nullable=False)
    temperatura_max = db.Column(db.Float, nullable=False)
    temperatura_min = db.Column(db.Float, nullable=False)
    velocidad = db.Column(db.Float, nullable=False)
    produccion_min = db.Column(db.Float, nullable=False)
    reportes = db.relationship('Reporte', backref='maquina', lazy=True)

class Reporte(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    id_maquina = db.Column(db.Integer, db.ForeignKey('maquina.id'), nullable=False)
    timestamp = db.Column(db.DateTime, default=datetime.now)
    temperatura = db.Column(db.Float, nullable=False)
    velocidad = db.Column(db.Float, nullable=False)
    produccion = db.Column(db.Float, nullable=False)