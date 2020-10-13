import 'dart:convert';
import 'package:http/http.dart' as http;

import 'url/url_api.dart';

class GetAPINews{
  static int status;
  getNews(String token) async {
    final response = await http.get(
      '${url_main}/${url_new}',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
      },);
    print("Status News: ${response.statusCode}");
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // Map<String, dynamic> data_map = json.decode(response.body;
      List<dynamic> data_list = json.decode(response.body);
      // List<dynamic> data_list_all = data_map[''];
      status = 200;
      print('News: 200');



      print('List News: ${data_list.toString()}');
      // DataNews data = DataNews.fromJson(jsonDecode(response.body));
      // print(data.toString());

      return data_list;
    }else{
      // If the server did return a 201 CREATED response,
      // then throw an exception.
    }
  }
}