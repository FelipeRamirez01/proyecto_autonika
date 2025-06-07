from app import db
from datetime import datetime

from zoneinfo import ZoneInfo

zona_colombia = ZoneInfo("America/Bogota")
fecha_colombia = datetime.now(zona_colombia).date()

# Tabla principal
class Maquina(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)
    tipo = db.Column(db.String(50), nullable=False)

    moldeo = db.relationship("Moldeo", uselist=False, backref="maquina")
    apilado = db.relationship("Apilado", uselist=False, backref="maquina")
    secador = db.relationship("Secador", uselist=False, backref="maquina")
    horno = db.relationship("Horno", uselist=False, backref="maquina")
    descargue = db.relationship("Descargue", uselist=False, backref="maquina")
    reportes = db.relationship('Reporte', backref='maquina', lazy=True)


class Moldeo(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    maquina_id = db.Column(db.Integer, db.ForeignKey('maquina.id'), nullable=False)
    cortes_por_minuto = db.Column(db.Integer)
    velocidad_cajones = db.Column(db.Float)
    velocidad_formadora = db.Column(db.Float)
    nivel_cajon = db.Column(db.Float)
    fecha = db.Column(db.Date) 
    estado = db.Column(db.String(50))  # Estado de la máquina (operativa, en mantenimiento, etc.)

class Apilado(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    maquina_id = db.Column(db.Integer, db.ForeignKey('maquina.id'), nullable=False)
    estantes_descargados = db.Column(db.Float)
    tiempo_ultimo_estante = db.Column(db.Float)
    efi_produccion = db.Column(db.Float)
    carros_cargados = db.Column(db.Float)
    fecha = db.Column(db.Date) 
    estado = db.Column(db.String(50))  # Estado de la máquina (operativa, en mantenimiento, etc.)

class Secador(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    maquina_id = db.Column(db.Integer, db.ForeignKey('maquina.id'), nullable=False)
    estantes_cargados = db.Column(db.Integer) 
    tiempo_ultimo_estante = db.Column(db.Float)
    efi_produccion = db.Column(db.Float)
    cortes_por_minuto = db.Column(db.float)       
    fecha = db.Column(db.Date) 
    estado = db.Column(db.String(50))  # Estado de la máquina (operativa, en mantenimiento, etc.)

class Horno(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    maquina_id = db.Column(db.Integer, db.ForeignKey('maquina.id'), nullable=False)
    empujes_realizados = db.Column(db.Integer)
    carros_quemados = db.Column(db.float)
    velocidad_tiro = db.Column(db.Float)
    temperatura_tiro = db.Column(db.Float)
    fecha = db.Column(db.Date) 
    estado = db.Column(db.String(50))  # Estado de la máquina (operativa, en mantenimiento, etc.)

class TemperaturaHorno(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    horno_id = db.Column(db.Integer, db.ForeignKey('horno.id'), nullable=False)
    fecha = db.Column(db.Date, nullable=False)
    temperatura_1 = db.Column(db.Float)
    temperatura_2 = db.Column(db.Float)
    temperatura_3 = db.Column(db.Float) 
    temperatura_4 = db.Column(db.Float)
    temperatura_5 = db.Column(db.Float)
    temperatura_6 = db.Column(db.Float)
    temperatura_7 = db.Column(db.Float)
    temperatura_8 = db.Column(db.Float)
    temperatura_9 = db.Column(db.Float)
    temperatura_10 = db.Column(db.Float)
    temperatura_11 = db.Column(db.Float)
    temperatura_12 = db.Column(db.Float)
    temperatura_13 = db.Column(db.Float)
    temperatura_14 = db.Column(db.Float)
    temperatura_15 = db.Column(db.Float)
    temperatura_16 = db.Column(db.Float)
    temperatura_17 = db.Column(db.Float)
    temperatura_18 = db.Column(db.Float)
    temperatura_19 = db.Column(db.Float)
    temperatura_20 = db.Column(db.Float)
    temperatura_21 = db.Column(db.Float)
    temperatura_22 = db.Column(db.Float)
    temperatura_23 = db.Column(db.Float)
    temperatura_24 = db.Column(db.Float)
    temperatura_25 = db.Column(db.Float)
    temperatura_26 = db.Column(db.Float)
    temperatura_27 = db.Column(db.Float)
    temperatura_28 = db.Column(db.Float)
    temperatura_29 = db.Column(db.Float)
    temperatura_30 = db.Column(db.Float)
    temperatura_31 = db.Column(db.Float)
    temperatura_32 = db.Column(db.Float)
    temperatura_33 = db.Column(db.Float)
    temperatura_34 = db.Column(db.Float)
    temperatura_35 = db.Column(db.Float)
    temperatura_36 = db.Column(db.Float)
    temperatura_37 = db.Column(db.Float)
    temperatura_38 = db.Column(db.Float)
    temperatura_39 = db.Column(db.Float)
    temperatura_40 = db.Column(db.Float)

class Descargue(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    maquina_id = db.Column(db.Integer, db.ForeignKey('maquina.id'), nullable=False)
    carros_descargados = db.Column(db.Integer)
    tiempo_ultimo_carro = db.Column(db.Float)
    efi_produccion = db.Column(db.Float)
    paquetes_realizados = db.Column(db.float)
    fecha = db.Column(db.Date) 
    estado = db.Column(db.String(50))  # Estado de la máquina (operativa, en mantenimiento, etc.)



