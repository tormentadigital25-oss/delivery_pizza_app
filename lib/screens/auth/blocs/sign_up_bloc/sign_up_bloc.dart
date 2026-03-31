import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;
  SignUpBloc(this._userRepository) : super(SignUpInitial()) {
    // Escuchamos cuando alguien lanza el evento 'SignUpRequired'
    on<SignUpRequired>((event, emit) async{
      // PASO 1: Avisamos a la pantalla que empiece a cargar
        emit(SignUpProcess());
      try{
        // PASO 2: Creamos el usuario en Firebase Authentication (Email y Password)
        // Esto nos devuelve un objeto 'MyUser' con el ID único (UID) generado.
        MyUser myUser = await _userRepository.signUp(event.user,event.password);
        // PASO 3: Guardamos los datos adicionales (Nombre, etc.) en Firestore 
        // usando ese mismo objeto 'myUser'.
        await _userRepository.setUserData(myUser);
        // PASO 4: Si ambos pasos funcionaron, emitimos Éxito.
        emit(SignUpSuccess());
      }catch(e){
        // Si cualquiera de los pasos anteriores falla, emitimos Fallo.
        print("ERROR EN SIGNUP BLOC: $e");
        emit(SignUpFailure());
      }
      
    });
  }
}
