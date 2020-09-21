import 'dart:async';
import 'package:flutter/material.dart';
import 'package:passioemployee/model/url/url_image.dart';
import 'package:passioemployee/view/home.dart';
import 'package:passioemployee/view/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


//void main() {
//  runApp(MaterialApp(
//    debugShowCheckedModeBanner: false,
//    home: Demo(),
//  ));
//}
class Demo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DemoState();
  }
}
Timer timer;
int count = 0;
class DemoState extends State<Demo> with WidgetsBindingObserver{
  static String email, username;
  @override
  void initState() {
      timer = Timer.periodic(Duration(seconds: 3), (time) async{
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        email = prefs.getString('email');
        username = prefs.getString('username');
        if(count == 0) {
          if(token == null){
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
            count = 1;}else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Home()),
                    (route) => false);count = 1;
          }
        }});
    }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(url_imgbackground_welcome)
        )
      ),
      child: Image.asset(url_icon_welcome),
    );
  }
}
