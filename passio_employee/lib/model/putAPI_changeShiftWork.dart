
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passioemployee/model/url/url_api.dart';

class PutAPIChangeShiftWork {
  changeShiftWork (String work_id, String token) async {
    final response = await http.put(
      '${url_main}/${url_changeShiftWork}/$work_id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print("Change Shift Work Api Status: " + response.statusCode.toString());
    return response.statusCode;
  }

}
