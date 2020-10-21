
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passioemployee/model/url/url_api.dart';

class PostAPIAttendance{
  checkAttendance(String date_time, String employee_id, int store_id, String token) async {
    final response = await http.post(
      '${url_main}/${url_checkAttendace}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<dynamic, dynamic>{
        "datetime": date_time,
        "employeeId": employee_id,
        "storeId": store_id
      }),
    );
    return response.statusCode;
  }

}
