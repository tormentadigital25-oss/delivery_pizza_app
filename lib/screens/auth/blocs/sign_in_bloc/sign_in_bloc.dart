import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  // Necesitamos el repositorio para poder usar la función 'signIn' de Firebase
  final UserRepository _userRepository;

  // Al nacer, el Bloc empieza en el estado Inicial (formulario vacío)
  SignInBloc(this._userRepository) : super(SignInInitial()) {
    
    // ESCUCHADOR 1: Cuando el usuario pide iniciar sesión (SignInRequired)
    on<SignInRequired>((event, emit) async {
      // Paso 1: Avisamos a la pantalla que estamos "Cargando"
      emit(SignInProcess());
      try {
        // Paso 2: Intentamos hacer el Login usando el email y pass que vienen en el evento
        await _userRepository.signIn(event.email, event.password);
       // emit(SignInSuccesss()); 
        
        // Paso 3: Si todo sale bien, emitimos Éxito
        // NOTA: Falta agregar 'emit(SignInSuccesss());' aquí para que la pantalla se entere.
      } catch (e) {
        // Paso 4: Si Firebase da error (ej. sin internet), emitimos Fallo
        emit(SignInFailure());
      }
    });

    // ESCUCHADOR 2: Cuando el usuario pide cerrar sesión
    on<SignOutRequired>((event, emit) async => await _userRepository.logOut());
  }
}