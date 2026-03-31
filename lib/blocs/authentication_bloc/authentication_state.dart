part of 'authentication_bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown }

class AuthenticationState extends Equatable {
  // Constructor privado para controlar los estados desde los métodos nombrados
  const AuthenticationState._(
      {this.status = AuthenticationStatus.unknown, this.user});
  final AuthenticationStatus status;
  final MyUser? user;

  // Estado cuando la app está arrancando
  const AuthenticationState.unknown() : this._();

  // Estado cuando el usuario se loguea con éxito
  const AuthenticationState.authenticated(MyUser myUser)
      : this._(status: AuthenticationStatus.authenticated, user: myUser);
      
  // Estado cuando no hay sesión activa
  const AuthenticationState.unauthenticated():this._(status:AuthenticationStatus.unauthenticated);

  @override
  List<Object?> get props => [status, user];
}
