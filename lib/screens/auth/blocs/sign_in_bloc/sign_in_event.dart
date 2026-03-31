part of 'sign_in_bloc.dart';
// Esta es la clase base "madre" para todos los eventos de Inicio de Sesión.
// Usamos 'sealed' para que nadie pueda crear eventos fuera de este archivo.
// 'Equatable' sirve para que Flutter sepa si un evento es igual a otro y no repita procesos.
sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}
// Este evento se dispara cuando el usuario hace clic en el botón de "Ingresar".
class SignInRequired extends SignInEvent{
  // Guardamos el correo y la clave que el usuario escribió en los TextFields.
  final String email;
  final String password;
  // El constructor recibe los datos para que el Bloc pueda usarlos.
  const SignInRequired(this.email,this.password);
  // Agregamos email y password a 'props' para que, si el usuario le da 20 clics 
  // seguidos con los mismos datos, el Bloc sea inteligente y no se sature.
  @override
  List<Object>get props=>[email,password];
}
// Este evento se dispara cuando el usuario quiere cerrar su sesión.
// No necesita datos (email/pass) porque solo le avisamos a Firebase que se desconecte.
class SignOutRequired extends SignInEvent{}