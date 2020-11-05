import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:passioemployee/model/url/url_api.dart';

class PutSwapAPI {

  putSwap(String token, int attendance_id, int employee_id) async {
    final response = await http.put(
      '${url_main}/${url_swap_shift}',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<dynamic, dynamic>{
        "attendance_id": '$attendance_id',
        "employee_id": '$employee_id'
      }),
    );
    print("Status SwapShift: ${response.statusCode}");
    if (response.statusCode == 200) {


      return response.statusCode;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      // print('400 code');
      throw Exception('Failed to load data');
    }
  }
}
