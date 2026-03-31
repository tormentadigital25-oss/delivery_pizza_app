//Es la capa intermedia. Sirve para transformar los datos de la base de datos (un Mapa/JSON de Firestore) a algo que Flutter entienda.


class MyUserEntity {
  String userId;
  String email;
  String name;
  bool hasActiveCart;

  MyUserEntity({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasActiveCart,
  });

  // Convierte los datos a un Map para que Firebase lo pueda guardar (JSON)
  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'hasActiveCart': hasActiveCart,
    };
  }
  
  // Toma un documento de Firebase y lo convierte en esta Entidad
  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      // Usamos 'as String' y 'as bool' para decirle a Flutter exactamente qué esperar.
      // El operador '??' pone un valor por defecto si el campo no existe en Firestore.
      userId: doc['userId'] as String? ?? '', 
      email: doc['email'] as String? ?? '',
      name: doc['name'] as String? ?? '',
      // Si 'hasActiveCart' es nulo en la base de datos, por defecto será 'false'
      hasActiveCart: doc['hasActiveCart'] as bool? ?? false,
    );
  }
}
