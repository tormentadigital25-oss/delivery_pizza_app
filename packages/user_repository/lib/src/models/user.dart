import '../entities/entities.dart';
//Es el objeto que usas en tu interfaz de Flutter (UI). Es lo que manejas para mostrar el nombre del cliente en el menú de pizzas.
class MyUser {
  String userId;
  String email;
  String name;
  bool hasActiveCart;

  MyUser(
      {required this.userId,
      required this.email,
      required this.name,
      required this.hasActiveCart});
  // Un usuario "vacío" para evitar errores de null cuando no hay nadie logueado
  static final empty =
      MyUser(userId: '', email: '', name: '', hasActiveCart: false);

  // Convierte este modelo a una Entidad (para ir hacia la base de datos)
  MyUserEntity toEntity() {
    return MyUserEntity(
        userId: userId, email: email, name: name, hasActiveCart: hasActiveCart);
  }

  // Toma una Entidad y la convierte en un modelo usable por la UI
  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
        userId: entity.userId,
        email: entity.email,
        name: entity.name,
        hasActiveCart: entity.hasActiveCart);
  }

  @override
  String toString(){
    return 'MyUser: $userId, $email, $name, $hasActiveCart';
  }
}
