
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passioemployee/model/url/url_api.dart';

import 'model_login.dart';
class PostAPI{
  static int status;
  createLogin(String username, String password) async {
  final response = await http.post(
    '${url_main}/${url_Login}',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "username": username,
      "password": password
    }),
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    status = 200;
    return DataLogin.fromJson(json.decode(response.body));
  } else if (response.statusCode == 400) {
    status = 400;
    print("Wrong email/pass");
  }
//  else {
//    // If the server did not return a 201 CREATED response,
//    // then throw an exception.
//    throw Exception('Failed to load data');
//  }
}

}

class PostGoogleAPI{
  static int status;
  createLogin(String email) async {
    final response = await http.post(
      '${url_main}/${url_LoginGoogle}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "email": email,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      status = 200;
      return DataLogin.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      status = 400;
      print("Wrong email/pass");
    }
//  else {
//    // If the server did not return a 201 CREATED response,
//    // then throw an exception.
//    throw Exception('Failed to load data');
//  }
  }

}