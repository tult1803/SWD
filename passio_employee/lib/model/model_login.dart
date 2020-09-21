class DataLogin {
  final String user_name, email;
  final String full_name, access_token;

  DataLogin({this.user_name, this.full_name, this.email, this.access_token});

  factory DataLogin.fromJson(Map<String, dynamic> json) {
    return DataLogin(
      user_name: json['user_name'],
      full_name: json['full_name'],
      email: json['email'],
      access_token: json['access_token'],
    );
  }
}