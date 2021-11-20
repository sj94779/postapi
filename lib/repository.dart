import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:postapi/model.dart';

class UserRepo {
  Future<UserModel> login(String phone, String password) async {
    final url = 'http://fasaltech.com/app/auth/token/login/';

    var response = await http.post(Uri.parse(url),
        body: {'phone_number': phone, 'password': password});

    return UserModel.fromJson(json.decode(response.body));
  }
}
