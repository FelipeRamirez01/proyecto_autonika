# models.py
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class DatosHorno(db.Model):
    __tablename__ = 'datos_horno'
    id = db.Column(db.Integer, primary_key=True)
    zona = db.Column(db.String(20))
    temperatura_real = db.Column(db.Float)
    temperatura_objetivo = db.Column(db.Float)
    tiempo = db.Column(db.Integer)
    presion = db.Column(db.Float)
    estado = db.Column(db.String(10))
