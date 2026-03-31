import 'models/models.dart';

//Dice qué acciones puede hacer un usuario (registrarse, salir, loguearse), pero no dice cómo se hacen.
abstract class UserRepository{
  // Un flujo (Stream) que nos dice en tiempo real si el usuario está conectado o no
  Stream <MyUser?> get user;
  // Firma para registrar un nuevo usuario con email y password
  Future <MyUser> signUp (MyUser myUser, String password);
  // Firma para guardar o actualizar los datos del usuario en Firestore
  Future<void> setUserData(MyUser user);
  // Firma para iniciar sesión
  Future <void> signIn(String email,String password);
  // Firma para cerrar la sesión
  Future <void> logOut();

}