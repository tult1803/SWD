class DataLogin {
  final String access_token;
  final int employeeId;
  final bool admin;

  DataLogin({this.employeeId, this.access_token, this.admin});

  factory DataLogin.fromJson(Map<String, dynamic> json) {
    return DataLogin(
      employeeId: json['employeeId'],
      access_token: json['token'],
      admin: json['admin']
    );
  }
}