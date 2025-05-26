from app import db
from datetime import datetime

# Tabla principal
class Maquina(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)
    ubicacion = db.Column(db.String(100), nullable=False)
    temperatura_max = db.Column(db.Float)
    temperatura_min = db.Column(db.Float)
    velocidad = db.Column(db.Float)
    produccion_min = db.Column(db.Integer)
    tipo = db.Column(db.String(50), nullable=False)

    moldeo = db.relationship("Moldeo", uselist=False, backref="maquina")
    apilado = db.relationship("Apilado", uselist=False, backref="maquina")
    secador = db.relationship("Secador", uselist=False, backref="maquina")
    horno = db.relationship("Horno", uselist=False, backref="maquina")
    descargue = db.relationship("Descargue", uselist=False, backref="maquina")
    reportes = db.relationship('Reporte', backref='maquina', lazy=True)

class Reporte(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    id_maquina = db.Column(db.Integer, db.ForeignKey('maquina.id'), nullable=False)
    timestamp = db.Column(db.DateTime, default=datetime.now)
    temperatura = db.Column(db.Float, nullable=False)
    velocidad = db.Column(db.Float, nullable=False)
    produccion = db.Column(db.Float, nullable=False)


class Moldeo(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    maquina_id = db.Column(db.Integer, db.ForeignKey('maquina.id'), nullable=False)
    cortes_por_minuto = db.Column(db.Integer)
    velocidad_cajones = db.Column(db.Float)
    velocidad_extrusora = db.Column(db.Float)
    tiempo_parada = db.Column(db.Float)

class Apilado(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    maquina_id = db.Column(db.Integer, db.ForeignKey('maquina.id'), nullable=False)
    mesas_endagadas = db.Column(db.Integer)
    tiempo_ultima_mesa = db.Column(db.Float)

class Secador(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    maquina_id = db.Column(db.Integer, db.ForeignKey('maquina.id'), nullable=False)
    descargue_bajometa_tiempo = db.Column(db.Float)
    tiempo_carga_bajonetas = db.Column(db.Float)
    funcionamiento_brazo_descargue = db.Column(db.Boolean)
    funcionamiento_brazo_cargue = db.Column(db.Boolean)
    temperatura_secador = db.Column(db.Float)
    bajonetas_ingresadas = db.Column(db.Integer)
    bajonetas_salidas = db.Column(db.Integer)

class Horno(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    maquina_id = db.Column(db.Integer, db.ForeignKey('maquina.id'), nullable=False)
    carros_empujados_diarios = db.Column(db.Integer)
    tiempo_entre_empujes = db.Column(db.Float)

class TemperaturaHorno(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    horno_id = db.Column(db.Integer, db.ForeignKey('horno.id'), nullable=False)
    fecha = db.Column(db.Date, nullable=False)
    temperatura_1 = db.Column(db.Float)
    temperatura_2 = db.Column(db.Float)
    # ...
    temperatura_40 = db.Column(db.Float)

class Descargue(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    maquina_id = db.Column(db.Integer, db.ForeignKey('maquina.id'), nullable=False)
    carros_descargados = db.Column(db.Integer)
    paquetes_formados = db.Column(db.Integer)



