part of 'sign_in_bloc.dart';

// Clase base. Todos los estados de inicio de sesión nacen de aquí.
sealed class SignInState extends Equatable {
  const SignInState();
  
  @override
  List<Object> get props => [];
}

// 1. Estado Inicial: El usuario acaba de abrir la pantalla. 
// No hay errores, no hay carga, solo los campos vacíos.
final class SignInInitial extends SignInState {}

// 2. Estado de Fallo: Algo salió mal (ej. contraseña incorrecta).
// Aquí podrías agregar un 'final String message' para decir qué falló.
final class SignInFailure extends SignInState {}

// 3. Estado de Cargando: El Moto G15 está enviando los datos a Firebase.
// Aquí es donde mostrarás el circulito de progreso (CircularProgressIndicator).
final class SignInProcess extends SignInState {}

// 4. Estado de Éxito: ¡Firebase aceptó las credenciales!
// Al detectar este estado, la app nos mandará a la HomeScreen.
final class SignInSuccess extends SignInState {}