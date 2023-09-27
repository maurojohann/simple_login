// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/data.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepository userRepository;
  LoginCubit(
    this.userRepository,
  ) : super(LoginInitial());

  Future<void> signinAuth({required String user, required String password}) async {
    emit(LoginInitial());
    try {
      bool userId = await userRepository.signinAuth(user, password);
      if (userId) {
        emit(LoginSuccess());
      } else {
        emit(LoginError(
            'Usuario e senha invalidos, tente user: cooper, senha: card'));
      }
    } catch (e) {
      log('Enviar para serviço de observação(sentry, crashlitycs)');

      emit(LoginError('Um erro ocorreu, não foi possivel fazer login'));
    }
  }
}
