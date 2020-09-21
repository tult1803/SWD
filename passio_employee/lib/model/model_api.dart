//import 'dart:convert';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:http/http.dart' as http;
//
////signIn(String email, pass) async {
////  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
////  Map data = {
////    'email': email,
////    'password': pass
////  };
////  var jsonResponse = null;
////  var response = await http.post("YOUR_BASE_URL", body: data);
////  if(response.statusCode == 200) {
////    jsonResponse = json.decode(response.body);
////    if(jsonResponse != null) {
////      setState(() {
////        _isLoading = false;
////      });
////      sharedPreferences.setString("token", jsonResponse['token']);
////      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainPage()), (Route<dynamic> route) => false);
////    }
////  }
////  else {
////    setState(() {
////      _isLoading = false;
////    });
////    print(response.body);
////  }
////}