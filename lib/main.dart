import 'package:flutter/material.dart';
import 'package:registry_pull/app/app_registry.dart';
import 'package:registry_pull/app/injector.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  registerInstances();
  runApp(const AppRegistry());
}
