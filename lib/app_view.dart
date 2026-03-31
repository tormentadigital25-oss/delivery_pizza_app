import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pizza_app/screens/home/blocs/get_pizza_bloc/get_pizza_bloc.dart';
import 'package:pizza_app/screens/home/views/home_screen.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'screens/auth/views/welcome_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Delivery',
      debugShowCheckedModeBanner:
          false, // Quita la etiqueta roja de "Debug" en la esquina
      theme: ThemeData(
          // Configuramos los colores globales de la Pizza App
          colorScheme: ColorScheme.light(
              surface: Colors.grey.shade100, // Fondo de las pantallas
              onSurface: Colors.black, // Color de texto sobre el fondo
              primary: Colors.blue, // Color de botones y destacados
              onPrimary: Colors.white // Color de texto sobre botones azules
              )),
      // El BlocBuilder "escucha" al Gerente (AuthenticationBloc)
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          // AQUÍ SE TOMA LA DECISIÓN:
          // Si el estatus que viene del estado es "autenticado"...
          if (state.status == AuthenticationStatus.authenticated) {
            // ...lo mandamos directo a pedir su pizza
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SignInBloc(
                      context.read<AuthenticationBloc>().userRepository),
                ),
                BlocProvider(
                  create: (context) => GetPizzaBloc(FirebasePizzaRepo())..add(GetPizza()),
                ),
              ],
              child: const HomeScreen(),
            );
          } else {
            // ...si no, lo mandamos a la pantalla de Bienvenida (Sign In / Sign Up)
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}
