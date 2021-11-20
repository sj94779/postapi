import 'package:flutter/foundation.dart';
import 'package:postapi/repository.dart';
import 'package:postapi/model.dart';

class UserProvider extends ChangeNotifier {
  late UserRepo _userRepo;
  late UserModel? _user;

  UserModel? get getUser => _user;

  UserProvider() {
    _userRepo = UserRepo();
  }

  login(String phone, String password) async {
    try {
      _user = await _userRepo.login(phone, password);

      notifyListeners();
    } catch (e) {
      _user = null;
      notifyListeners();
    }
  }
}
