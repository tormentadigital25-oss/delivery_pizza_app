part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();
  
  @override
  List<Object> get props => [];
}
// 1. Estado inicial: El formulario de registro está vacío y listo.
final class SignUpInitial extends SignUpState {}

// 2. Estado de éxito: ¡Cuenta creada y datos guardados!
class SignUpSuccess extends SignUpState{}

// 3. Estado de fallo: Algo salió mal (ej: el correo ya existe o no hay internet).
class SignUpFailure extends SignUpState{}

// 4. Estado de proceso: El Moto G15 está trabajando con Firebase.
// Aquí es donde mostrarás el círculo de carga.
class SignUpProcess extends SignUpState{}