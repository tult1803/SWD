import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passioemployee/model/url/url_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model_profile_emp.dart';

class GetAPIPeople {
  static int status;

  getPeople(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      '${url_main}/${url_People}/${prefs.get('main_store_id')}',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("Status Attendance: ${response.statusCode}");
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      status = 200;
      List<dynamic> data_list = json.decode(response.body);
//
//      final data = data_map["data"].cast<Map<String, dynamic>>();
//      final listofData = await data.map<AttendanceAPI>((json) {
//        return AttendanceAPI.fromJson(json);
//      }).toList();
//       List<DataProfile> data_list = [];
//
//       List<dynamic> data_list_all = data_map["data"];
//
//       data_list_all.forEach((element) {
//
//         Map<String, dynamic> data1= element;
//
//         data_list.add(DataProfile.fromJson(data1),); });
//      print(data_list[1].status);
      return data_list;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }
}
