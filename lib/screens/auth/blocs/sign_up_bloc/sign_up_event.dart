part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

// Este evento es el "grito" de: "¡Quiero crear una cuenta!"
class SignUpRequired extends SignUpEvent {
  // 'user' contiene los datos del perfil (nombre, email, etc.)
  final MyUser user;
  // La contraseña se pasa aparte para el proceso de creación en Firebase
  final String password;

  const SignUpRequired(this.user, this.password);

  @override
  List<Object> get props => [user, password];
}

