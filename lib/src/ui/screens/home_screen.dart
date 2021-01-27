import 'package:flutter/material.dart';

import 'package:remote_config_app/src/services/remote_config_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  RemoteConfigService _remoteConfigService;

  initializeRemoteConfig() async {
    _remoteConfigService = await RemoteConfigService.getInstance();
    await _remoteConfigService.initialize();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initializeRemoteConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Remote Config'),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _contenedor());
  }

  Center _contenedor() {
    return Center(
      child: Container(
        width: _remoteConfigService.getLongitudLado,
        height: _remoteConfigService.getLongitudLado,
        decoration: BoxDecoration(
            color: Color(_remoteConfigService.getColorContenedor),
            borderRadius:
                BorderRadius.circular(_remoteConfigService.getRadioContenedor)),
        child: Center(
          child: Text(
            _remoteConfigService.getTextoSaludo,
            style: TextStyle(
                fontSize: _remoteConfigService.getTamanioFuente,
                color: Color(_remoteConfigService.getColorTexto)),
          ),
        ),
      ),
    );
  }
}
