import 'package:user_repository/src/models/user.dart';
import 'package:uuid/uuid.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    await Future.delayed(const Duration(milliseconds: 300));
    return _user = User(id: const Uuid().v4());
  }
}
