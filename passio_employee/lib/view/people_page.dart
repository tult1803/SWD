import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passioemployee/model/getAPI_attendance.dart';
import 'package:passioemployee/model/model_attendance.dart';
import 'package:passioemployee/model/url/url_color.dart';
import 'package:passioemployee/model/url/url_icon.dart';
import 'package:passioemployee/presenter/presenter_attendace.dart';
import 'package:passioemployee/presenter/presenter_people.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'about.dart';
import 'attendance.dart';
import 'calendar.dart';
import 'home.dart';

class People extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return PeopleState();
  }

}

class PeopleState extends State{
  static String token;
  int _selectedPage = 1;
  final _pageOptions = [ // Thay Text bằng class để Na
    Home(),
    People(),
    Attendance(),
    Calendar(),
    Profile(),
  ];
  String _nameEmp;
  void getAttendance() async{
    GetAPIAttendance getAPI = GetAPIAttendance();
    setState(() async{
      do {
        data_list = await getAPI.getAttendance(HomeState.token);
        String nameCheck;
        data_list_short.add(data_list[0]);
        for(int i = 0; i < data_list.length; i++){
            if(data_list_short[(data_list_short.length - 1)].employee_name != data_list[i].employee_name){
             await   data_list_short.add(data_list[i]);
          }
        }
      }while(data_list.isEmpty);
    });
  }
  List<AttendanceAPI> data_list = [];
  List<AttendanceAPI> data_list_short = [];
  @override
  void initState() {
    // TODO: implement initState
    getAttendance();
  }

  @override
  Widget build(BuildContext context) {
    GetAPIAttendance getAPI = GetAPIAttendance();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_main,
        leading: icon_appbar_people,
        title: Text("People", style: TextStyle(color: Colors.black),)
      ),

        body: FutureBuilder(
        future:  getAPI.getAttendance(HomeState.token),
    builder: (context, snapshot) {
    if(snapshot.hasError){
    print(snapshot.error);
    }
    if(snapshot.hasData){
     return new ListView.builder(
      itemCount: data_list_short.length,
      itemBuilder: (context, index) {
        String check;
        Color color;
//        if(data_list[1].employee_name != data_list[index].employee_name){
    if(true){
          return GestureDetector(
            onTap: () {

            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: container_Calendar(index,Colors.lightGreenAccent, data_list_short[index].employee_name, data_list_short[index].shift_min.substring(11,16),'Vị trí', true, "VT"),
            ),
          );
        }
      },
     );}else {
    return Center(child: CircularProgressIndicator());
    }

    } ),

      bottomNavigationBar: BottomNavigationBar(
//       fixedColor: Color.fromARGB(255, 168,206,60),\
        fixedColor: choose_bottombar,
        currentIndex: 1,
        onTap: (int index) {
          setState(() {
            if(index != 1) {
              _selectedPage = index;
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => _pageOptions[_selectedPage]),
                      (route) => false);
            }});
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.fiber_new, color: icon_bottombar), title: Text("Home")),
          BottomNavigationBarItem(
              backgroundColor: color_bottombar,
              icon: Icon(Icons.people, color: icon_bottombar), title: Text("People")),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle, color: icon_bottombar), title: Text("Điểm danh")),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment, color: icon_bottombar), title: Text("Lịch")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: icon_bottombar), title: Text("Cá nhân")),
        ],
    ));
  }

}