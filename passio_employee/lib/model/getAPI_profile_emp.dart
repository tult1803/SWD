
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passioemployee/model/url/url_api.dart';

import 'model_profile_emp.dart';

class GetAPIProfile{
  static int status;
  getProfile(String token) async {
    final response = await http.get(
      '${url_main}/${url_Profile}',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);
    print("Status Attendance: ${response.statusCode}");
    if (response.statusCode == 200)  {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      status = 200;
      DataProfile data = DataProfile.fromJson(jsonDecode(response.body));
//      print(data.toString());
      return data = DataProfile.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

}
