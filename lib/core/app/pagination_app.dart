import 'package:flutter/material.dart';

import '../../shared/routes/route_generator.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: RouteNames.SIGNIN,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
