import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart' hide WatchContext;

import '../../../shared/routes/route_generator.dart';

import 'presenters.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  late LoginCubit _cubit;
  late TextEditingController _loginTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    _cubit = BlocProvider.of<LoginCubit>(context);
    _loginTextController = TextEditingController();
    _passwordTextController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _loginTextController.dispose();
    _passwordTextController.dispose();
    _cubit.close;
    log('PASSSEII NOOO DISSSPOOSEEE');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        bloc: _cubit,
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacementNamed(context, RouteNames.HOME);
          }
          if (state is LoginError) {
            var snackBar = SnackBar(
              duration: const Duration(seconds: 2),
              content: Text(state.message),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xffD0D0D0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ..._buildSignInSection(),
          ...buildSignUpSection(),
        ],
      ),
    );
  }

  List<Widget> _buildSignInSection() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
        child: TextField(
          controller: _loginTextController,
          decoration: InputDecoration(
            hintText: 'login',
            label: Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: const Text('E-mail'),
            ),
            alignLabelWithHint: true,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: TextField(
          controller: _passwordTextController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: '******',
            label: Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: const Text('Senha'),
            ),
            alignLabelWithHint: true,
          ),
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: ElevatedButton(
          onPressed: () async {
            await _cubit.signinAuth(
                user: _loginTextController.text,
                password: _passwordTextController.text);
          },
          child: const Text('Entrar'),
        ),
      ),
    ];
  }

  List<Widget> buildSignUpSection() {
    return const [
      Text('Ainda não tem uma conta?'),
      Text('User: copper'),
      Text('password: card'),
    ];
  }
}
