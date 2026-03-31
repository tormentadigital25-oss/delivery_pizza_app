import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/app.dart';
import 'package:pizza_app/firebase_options.dart';
import 'package:pizza_app/simple_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  // Asegura que los canales de comunicación nativos (Android/iOS) estén listos 
  // antes de inicializar Firebase o cualquier plugin.
  WidgetsFlutterBinding.ensureInitialized();

  // Conecta la app con tu proyecto de Firebase (usa las credenciales de google-services.json)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  // Configura nuestro 'espía' de BLoC para ver en la consola todo lo que pasa 
  // con los estados y eventos de la app.
  Bloc.observer = SimpleBlocObserver();

  // Lanza la app pasando el repositorio real de Firebase como dependencia.
  // Esto es "Inyección de Dependencias": MyApp ahora sabe cómo hablar con Firebase.
  runApp(MyApp(FirebaseUserRepo()));
}