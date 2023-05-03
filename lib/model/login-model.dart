class LoginResponseModel {
  final bool canLogin;
  final int memberId;
  final String error;

  LoginResponseModel(
      {required this.canLogin, required this.error, required this.memberId});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      canLogin: json["canLogin"] != null ? json["canLogin"] : false,
      memberId: json["IntMemberId"] != null ? json["IntMemberId"] : -1,
      error: json["error"] != null ? json["error"] : "",
    );
  }
}

class LoginRequestModel {
  String email = '';
  String password = '';

  LoginRequestModel();
  void setEmail(String email) {
    this.email = email;
  }

  void setPassword(String password) {
    this.password = password;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': email.trim(),
      'password': password.trim(),
    };

    return map;
  }
}
