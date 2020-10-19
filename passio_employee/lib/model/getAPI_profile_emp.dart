
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passioemployee/model/url/url_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model_profile_emp.dart';

class GetAPIProfile{
  static int status;
  getProfile(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      '${url_main}/${url_Profile}/${prefs.get('id_emp')}',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);
    print("Status Attendance: ${response.statusCode}");
    print("Emp: ${url_main}/${url_Profile}/${prefs.get('id_emp')}");
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
