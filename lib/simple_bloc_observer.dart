import 'dart:developer';
import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    // Se dispara cuando un BLoC nace. Útil para saber qué módulos se están cargando.
    print('-----------------------------------------');
    print('onCreate -- bloc: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // Te avisa cuando el usuario hace algo, ej: "Le dio clic al botón de login" (evento).
    log('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // Muestra el cambio: el estado antes y el estado después.
    print('onChange -- bloc: ${bloc.runtimeType}, change: $change');
    print('-----------------------------------------');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // Específico para BLoCs: muestra el evento que causó el cambio y el nuevo estado.
    log('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // Si algo falla en la lógica de BLoC, aquí verás el error exacto.
    log('onError -- bloc: ${bloc.runtimeType}, error: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    // Se dispara cuando el BLoC se destruye para liberar memoria.
    log('onClose -- bloc: ${bloc.runtimeType}');
  }
}