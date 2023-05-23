

import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String email;

  @HiveField(1)
  String password;
  @HiveField(2)
  final String name;
  User({required this.email, required this.password,required this.name,
  });
  String getUserName() {
    return name;
  }
}
