import 'package:flutter/material.dart';
import 'package:registry_pull/app/app_registry.dart';
import 'package:registry_pull/app/injector.dart';

void main() {
  registerInstances();
  runApp(const AppRegistry());
}
