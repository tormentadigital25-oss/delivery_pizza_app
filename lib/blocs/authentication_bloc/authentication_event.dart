part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}
// Este evento se dispara automáticamente cada vez que el Stream de Firebase envía datos
class AuthenticationUserChanged extends AuthenticationEvent{
  final MyUser? user;

  const AuthenticationUserChanged(this.user);


}
