import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  static const String COLOR_TEXTO = "color_texto";
  static const String COLOR_CONTENEDOR = "color_contenedor";
  static const String LONGITUD_LADO = "longitud_lado";
  static const String RADIO_CONTENEDOR = "radio_contenedor";
  static const String TEXTO_SALUDO = "texto_saludo";
  static const String TAMANIO_FUENTE = "tamanio_fuente";

  final RemoteConfig _remoteConfig;

  RemoteConfigService({RemoteConfig remoteConfig})
      : this._remoteConfig = remoteConfig;

  final defaults = <String, dynamic>{
    COLOR_TEXTO: 0xffffffff,
    COLOR_CONTENEDOR: 0xff0d47a1,
    LONGITUD_LADO: 250.0,
    RADIO_CONTENEDOR: 25.0,
    TEXTO_SALUDO: "Hola Mundo",
    TAMANIO_FUENTE: 21.0
  };

  static RemoteConfigService _instance;
  static Future<RemoteConfigService> getInstance() async {
    if (_instance == null)
      _instance =
          RemoteConfigService(remoteConfig: await RemoteConfig.instance);
    return _instance;
  }

  Future initialize() async {
    try {
      await this._remoteConfig.setDefaults(defaults);
      await _fetchAndActivate();
    } on FetchThrottledException catch (e) {
      print("Remote config fetch throttled: $e");
    } catch (e) {
      print("Unable to fetch remote config.");
    }
  }

  Future _fetchAndActivate() async {
    await this._remoteConfig.fetch(expiration: Duration(seconds: 0));
    await this._remoteConfig.activateFetched();
  }

  int get getColorTexto => this._remoteConfig.getInt(COLOR_TEXTO);
  int get getColorContenedor => this._remoteConfig.getInt(COLOR_CONTENEDOR);

  double get getLongitudLado => this._remoteConfig.getDouble(LONGITUD_LADO);
  double get getRadioContenedor =>
      this._remoteConfig.getDouble(RADIO_CONTENEDOR);

  String get getTextoSaludo => this._remoteConfig.getString(TEXTO_SALUDO);
  double get getTamanioFuente => this._remoteConfig.getDouble(TAMANIO_FUENTE);
}

// https://medium.com/@tsvillain/update-flutter-app-remotely-using-firebase-remote-config-69aadba275f7

// color_blanco: 0xffffffff
// color_negro: 0xff000000
// color_azul: 0xff0d47a1
// color_rojo: 0xffb71c1c
