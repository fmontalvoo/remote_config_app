import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final RemoteConfig _remoteConfig;

  RemoteConfigService({RemoteConfig remoteConfig})
      : this._remoteConfig = remoteConfig;

  final defaults = <String, dynamic>{
    "color_texto": 0xffffffff,
    "color_contenedor": 0xff0d47a1,
    "longitud_lado": 250,
    "radio_contenedor": 2.5,
    "texto_saludo": "Hola Mundo",
    "tamanio_fuente": 21
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

  int get getColorTexto => this._remoteConfig.getInt('color_texto');
  int get getColorContenedor => this._remoteConfig.getInt('color_contenedor');

  double get getLongitudLado => this._remoteConfig.getDouble('longitud_lado');
  double get getRadioContenedor =>
      this._remoteConfig.getDouble('radio_contenedor');

  String get getTextoSaludo => this._remoteConfig.getString('texto_saludo');
  double get getTamanioFuente => this._remoteConfig.getDouble('tamanio_fuente');
}

// https://medium.com/@tsvillain/update-flutter-app-remotely-using-firebase-remote-config-69aadba275f7

// color_blanco: 0xffffffff
// color_negro: 0xff000000
// color_azul: 0xff0d47a1
// color_rojo: 0xffb71c1c
