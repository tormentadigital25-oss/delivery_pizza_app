import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_repository/user_repository.dart';

//Aquí es donde escribes el código real que habla con Firebase

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  // Este Stream devuelve un objeto MyUser cada vez que el estado de autenticación cambia
  Stream<MyUser?> get user {
    // Escuchamos los cambios de sesión (login/logout)
    return _firebaseAuth.authStateChanges().flatMap((firebaseUser) async* {
      if (firebaseUser == null) {
        // Si no hay nadie, devolvemos el usuario vacío que definimos en el modelo
        yield MyUser.empty;
      } else {
        // Buscamos el documento en Firestore
        final doc = await usersCollection.doc(firebaseUser.uid).get();

        // VALIDACIÓN DE SEGURIDAD:
        // Si el documento existe, lo convertimos.
        // Si NO existe (usuario nuevo), creamos un MyUser básico con su email y ID.
        if (doc.exists && doc.data() != null) {
          yield MyUser.fromEntity(MyUserEntity.fromDocument(doc.data()!));
        } else {
          // Esto evita que la app explote si el documento aún no se crea en la DB
          yield MyUser(
            userId: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            name: '', // O un nombre por defecto
            hasActiveCart: false,
          );
        }
      }
    });
  }

  @override
  // Intenta iniciar sesión. Es 'Future' porque debe esperar respuesta de la red.
  Future<void> signIn(String email, String password) async {
    try {
      // Llamada directa a Firebase con las credenciales del usuario
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      // Si hay error (ej: usuario no encontrado), lo registra en la consola
      log(e.toString());

      // Re-lanza el error para que la UI (GetX) pueda mostrar un mensaje al usuario
      rethrow;
    }
  }

  @override
  // Crea un nuevo usuario y devuelve el objeto 'MyUser' actualizado con su ID
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      // 1. Intentamos crear el usuario
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email, password: password);

      // 2. En lugar de confiar en el objeto completo, extraemos solo el UID
      // Esto suele saltarse el error de 'PigeonUserDetails'
      final String? uid = credential.user?.uid;

      if (uid != null) {
        myUser.userId = uid;
        return myUser;
      } else {
        throw Exception("No se pudo obtener el UID de Firebase");
      }
    } catch (e) {
      log("Error en Repo signUp: $e");
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
  try {
    // Mantenemos esta validación por seguridad
    if (myUser.userId.isEmpty) return;

    // Ejecutamos la escritura con un timeout prudente
    await usersCollection
        .doc(myUser.userId)
        .set(myUser.toEntity().toDocument())
        .timeout(const Duration(seconds: 10));

  } catch (e) {
    // Es mejor usar log() de 'dart:developer' en lugar de print
    // para que no aparezca en la versión final de la app (Release)
    log("Error en setUserData: $e");
    rethrow;
  }
}


}
