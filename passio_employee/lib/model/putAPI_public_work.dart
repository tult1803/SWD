
import 'package:http/http.dart' as http;
import 'package:passioemployee/model/url/url_api.dart';

class PutPublicWorkAPI {

  putPublicWork(String token, int attendance_id) async {
    final response = await http.put(
      '${url_main}/${url_public_work}/$attendance_id',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("Status PublicWork: ${response.statusCode}");
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
