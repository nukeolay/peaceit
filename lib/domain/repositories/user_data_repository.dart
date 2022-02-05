import 'package:darkit/domain/entities/user_data.dart';

abstract class UserDataRepository {
  UserData get userData;
  Future<void> load();
  Future<void> save();
}
