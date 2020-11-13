import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passioemployee/model/url/url_api.dart';

import 'model_attendance.dart';

class GetTotalTimeAPI {

  getTotalTime(String token, String empId, String Sdate, String Edate,) async {
    final response = await http.get(
      '${url_main}/${url_totalTime}/$empId?from=$Sdate&to=$Edate',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },

    );
    print("url: ${url_main}/${url_totalTime}/$empId?from=$Sdate&to=$Edate");
    print("Status TotalTime: ${response.statusCode}");
    if (response.statusCode == 200) {
      Map<String, dynamic> data_map = json.decode(response.body);
      print("Data values: ${data_map.values}");
      print("Data values: ${data_map.values.last.toString()}");
      print("Data values first: ${data_map.values.first}");
      return data_map;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      // print('400 code');
      throw Exception('Failed to load data');
    }
  }
}
