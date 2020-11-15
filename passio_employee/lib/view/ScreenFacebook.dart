

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passioemployee/model/getAPI_news.dart';
import 'package:passioemployee/model/model_news.dart';
import 'package:passioemployee/model/url/url_color.dart';
import 'package:passioemployee/model/url/url_icon.dart';
import 'package:passioemployee/presenter/presenter_home.dart';
import 'package:passioemployee/view/home.dart';
import 'package:passioemployee/view/load_page.dart';
import 'package:passioemployee/view/login_screen.dart';
import 'package:passioemployee/view/people_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import 'about.dart';
import 'attendance.dart';
import 'calendar.dart';

class ScreenFacebook extends StatefulWidget{
  @override

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ScreenFacebookState();
  }
}

class ScreenFacebookState extends State<ScreenFacebook>{
  static String token;
  int _selectedPage = 0;
  final _pageOptions = [ // Thay Text bằng class để Naviga
    ScreenFacebook(),
    People(),
    Attendance(),
    Calendar(),
    Profile(),
  ];

  Timer timer;
  int count = 0;
  static String email, username;
  @override
  void initState() {
    // LoginScreenState.email = 'user1';
    // LoginScreenState.password = '123456';
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
          count = 1;}
        else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Home()),
                  (route) => false);count = 1;
        }
      }});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Hồng Nguyên",style:TextStyle(fontSize: 35.0)),
                  SizedBox(height: 20.0,),
                  CircleAvatar(
                    backgroundImage: NetworkImage("https://scontent.fsgn2-6.fna.fbcdn.net/v/t31.0-8/22256742_1956032107945563_1812094570274263368_o.jpg?_nc_cat=110&ccb=2&_nc_sid=09cbfe&_nc_ohc=8c8lY1x6X6wAX8SG5tQ&_nc_ht=scontent.fsgn2-6.fna&oh=3e77227c8b6550c3289006123b279fea&oe=5FD69DFB" + '?width=500&height500'),
                    radius: 60.0,
                  ),
                  SizedBox(height: 20.0,),
                  Text("lehongnguyen1999@gmail.com",style:TextStyle(fontSize: 10.0)),
                  // SizedBox(height: 20.0,),
                  // Text(snapshot.data.phoneNumber,style:TextStyle(fontSize: 10.0)),

                  SizedBox(height: 100.0,),
                  FlatButton.icon(
                    textColor: Color(0xFF6200EE),
                    onPressed: () {
                      setState(() {
                        LoginScreenState.email = 'leminhtuan';
                        LoginScreenState.password = '1';
                      });
                      // ý m là j
                      //m  muốn làm j. click vao nut trang chu la vao duoc lun cai  newoko     ok
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Load()),
                      );
                    },
                    icon: Icon(Icons.home, size: 18),
                    label: Text("Trang chủ"),
                  ),
                  FlatButton.icon(
                    textColor: Color(0xFF6200EE),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    icon: Icon(Icons.logout, size: 18),
                    label: Text("Đăng xuất"),
                  ),
                ])
        )
    );
  }

  }
