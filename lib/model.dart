class UserModel {
  String? authToken;

  UserModel(this.authToken);

  UserModel.login({this.authToken});

  UserModel.fromJson(Map<String, dynamic> json) {
    authToken = json['auth_token'];
  }
}
