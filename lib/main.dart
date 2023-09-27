import 'package:flutter/material.dart';


import 'core/app/pagination_app.dart';
import 'core/di/global_dependece.dart';

void main() async {
  await GlobalDependencies().setup();
  runApp(App());
}
