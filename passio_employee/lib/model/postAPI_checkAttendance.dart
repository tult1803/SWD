
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passioemployee/model/url/url_api.dart';

class PostAPIAttendance{
  checkAttendance(int finger_scan_machine_id, String date_time, String employee_id, int store_id, int machine_number,  int brand_id) async {
    final response = await http.post(
      '${url_main}/${url_checkAttendace}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        "finger_scan_machine_id": finger_scan_machine_id,
        "employee_id": employee_id,
        "date_time": date_time,
        "store_id": store_id,
        "machine_number": machine_number,
        "brand_id": brand_id
      }),
    );

    return response.statusCode;
  }

}
