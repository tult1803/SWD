
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passioemployee/model/url/url_api.dart';

import 'model_news.dart';


class GetAPINews{
  static int status;
  getNews(String token) async {
    final response = await http.get(
      '${url_main}/${url_new}',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);
    print("Status News: ${response.statusCode}");
    if (response.statusCode == 200)  {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // Map<String, dynamic> data_map = json.decode(response.body);
      List<dynamic> data_list = json.decode(response.body);
      // List<dynamic> data_list_all = data_map[''];
      // print('List News: ${data_list.toString()}');
      // DataNews data = DataNews.fromJson(jsonDecode(response.body));
     print('Get News Successed !!!');

      return data_list;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

}
