import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passioemployee/model/url/url_api.dart';

import 'model_detailsCalendar.dart';


class GetByIDAPI {
  static int status;

  getByID(String token, int id ) async {
    final response = await http.get(
      '${url_main}/${url_get_by_id}?id=${id}',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("Status GetByID: ${response.statusCode}");
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> data_map = json.decode(response.body);
      // List<GetByID> data_list = [];
      // data_list.add(GetByID.fromJson(data_map));

      return data_map;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      // print('400 code');
      throw Exception('Failed to load data');
    }
  }
}
