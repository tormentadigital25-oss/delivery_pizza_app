import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  late final StreamSubscription<MyUser?> _userSubscription;

  AuthenticationBloc({required this.userRepository}) : super(const AuthenticationState.unknown()) {
    // 1. Empezamos a escuchar al repositorio inmediatamente
    _userSubscription=userRepository.user.listen((user){
      // 2. Cada vez que Firebase diga algo, disparamos el evento interno
      add(AuthenticationUserChanged(user));
    });
    // 3. Reaccionamos al evento para cambiar el estado de la UI
    on<AuthenticationUserChanged>((event, emit) {
      if(event.user != MyUser.empty){
        emit(AuthenticationState.authenticated(event.user!));
      }else{
        emit(const AuthenticationState.unauthenticated());
      }
    });
  }

  @override
  Future<void>close(){
    // 4. Limpieza: cancelamos la suscripción para evitar fugas de memoria
    _userSubscription.cancel();
    return super.close();
  }
}
