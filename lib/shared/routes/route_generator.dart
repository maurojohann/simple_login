// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../core/di/global_dependece.dart';

import '../../features/characters/presenter/bloc/characters_bloc.dart';

import '../../features/characters/presenter/characters_page.dart';

import '../../features/login/presenters/presenters.dart';
import '../infra/http/http_adapter.dart';

class RouteNames {
  static const HOME = '/home';
  static const SIGNIN = '/';
  static const DETAILS = '/details';
}

class RouteGenerator {
  final httpClient = HttpAdapter(Client());
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.SIGNIN:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => serviceLocator<LoginCubit>(),
            child: const LoginPage(),
          ),
        );
      case RouteNames.HOME:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => serviceLocator<CharactersBloc>(),
            child: const CharactersPage(),
          ),
        );

      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
