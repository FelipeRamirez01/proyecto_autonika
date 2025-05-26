from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager, UserMixin, login_user, login_required
import os
from datetime import timedelta
from flask import Flask, render_template, request, redirect, url_for, flash
from werkzeug.utils import secure_filename
from flask_mail import Mail
from dotenv import load_dotenv



# Cargar variables del archivo .env
load_dotenv()
db = SQLAlchemy()
login_manager = LoginManager()
mail = Mail()



def create_app():
    app = Flask(__name__, template_folder='../views', static_folder='../static')

    DB_HOST = os.getenv("DB_HOST")
    DB_PORT = os.getenv("DB_PORT")
    DB_NAME = os.getenv("DB_NAME")
    DB_USER = os.getenv("DB_USER")
    DB_PASSWORD = os.getenv("DB_PASSWORD")
    app.config['SQLALCHEMY_DATABASE_URI'] = f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0  # Para desarrollo, en producción usa caché


    print("Base de datos configurada:", app.config['SQLALCHEMY_DATABASE_URI'])
    # Configuración de Flask-Mail desde .env
    app.config['MAIL_SERVER'] = os.getenv("MAIL_SERVER")
    app.config['MAIL_PORT'] = int(os.getenv("MAIL_PORT"))
    app.config['MAIL_USE_TLS'] = os.getenv("MAIL_USE_TLS") == "True"
    app.config['MAIL_USERNAME'] = os.getenv("MAIL_USERNAME")
    app.config['MAIL_PASSWORD'] = os.getenv("MAIL_PASSWORD")
    app.config['MAIL_DEFAULT_SENDER'] = os.getenv("MAIL_DEFAULT_SENDER")

    mail.init_app(app)
    

    # Clave secreta para manejar sesiones y seguridad
    app.config['SECRET_KEY'] = os.urandom(24)
    #app.config['SECRET_KEY'] = os.getenv("FLASK_SECRET_KEY") # Genera una clave aleatoria
    app.config['PERMANENT_SESSION_LIFETIME'] = timedelta(minutes=10)

    db.init_app(app)
    

    login_manager.init_app(app)
    login_manager.login_view = 'usuarios.login'  # Ruta para login obligatorio


    from controllers.users import users_bp
    app.register_blueprint(users_bp)

    from controllers.api_mail import api_mail
    app.register_blueprint(api_mail, url_prefix='/api_mail')

    from controllers.configuracion import config_bp
    app.register_blueprint(config_bp, url_prefix='/configuracion')

    from controllers.log import log_bp
    app.register_blueprint(log_bp, url_prefix='/logs')

    from controllers.maquinas import maquinas_bp
    app.register_blueprint(maquinas_bp, url_prefix='/maquinas')



    #UPLOAD_FOLDER = os.path.join(app.root_path, 'static', 'comprobantes')
    UPLOAD_FOLDER = os.path.join(os.getcwd(), 'static/comprobantes_reservas')
    app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

    from controllers.config_base import obtener_permisos_usuario
    @app.context_processor
    def inject_permisos():
        return dict(permisos_usuario=obtener_permisos_usuario())
    
    from models.datos_app import Datos_app
    @app.context_processor
    def inject_datos_conjunto():
        datos = Datos_app.query.first()
        return dict(datos=datos)
    

    #with app.app_context():
     #   db.create_all()

    return app
