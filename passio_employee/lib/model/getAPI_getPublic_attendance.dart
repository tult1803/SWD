import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passioemployee/model/url/url_api.dart';

class GetPublicAttendacesAPI {
  static int status;

  getPublicAttendaces(String token, String date, String empId) async {
    final response = await http.get(
      '${url_main}/${url_get_public}/$date',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("Status Public Attendaces: ${response.statusCode}");
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // Map<String, dynamic> data_map = json.decode(response.body);
      List<dynamic> data_list = json.decode(response.body);
      // List<dynamic> data_list_all = data_map[''];
      status = 200;
      // print('GetByDate: 200');

      // print('List GetByDate: ${data_list.toString()}');
      // DataNews data = DataNews.fromJson(jsonDecode(response.body));
      // print(data.toString());

      return data_list;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      // print('400 code');
      throw Exception('Failed to load data');
    }
  }
}
