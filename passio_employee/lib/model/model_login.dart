class DataLogin {
  final String access_token, email;
  final int employeeId;
  final bool admin;

  DataLogin({this.employeeId, this.access_token, this.email, this.admin});

  factory DataLogin.fromJson(Map<String, dynamic> json) {
    return DataLogin(
        employeeId: json['employeeId'],
        access_token: json['token'],
        email: json['email'],
        admin: json['admin']);
  }
}
