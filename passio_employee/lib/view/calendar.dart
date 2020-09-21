

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passioemployee/model/getAPI_attendance.dart';
import 'package:passioemployee/model/url/url_color.dart';
import 'package:passioemployee/model/url/url_icon.dart';
import 'package:passioemployee/presenter/presenter_calendar.dart';
import 'package:passioemployee/presenter/presenter_home.dart';
import 'package:passioemployee/view/people_page.dart';
import 'package:table_calendar/table_calendar.dart';

import 'about.dart';
import 'attendance.dart';
import 'home.dart';

class Calendar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CalendarState();
  }
}

class CalendarState extends State<Calendar>{
  CalendarController _controller;
  int _selectedPage = 3;
  final _pageOptions = [ // Thay Text bằng class để Na
    Home(),
    People(),
    Attendance(),
    Calendar(),
    Profile(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
  }
  @override
  Widget build(BuildContext context) {
    String value;
    GetAPIAttendance getAPI = GetAPIAttendance();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_main,
        leading: icon_appbar_calendar,
        title: Text("Lịch", style: TextStyle(color: Colors.black),),
      ),
      
     body: SingleChildScrollView(
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           TableCalendar(
             initialCalendarFormat: CalendarFormat.week,
             calendarController: _controller,
             calendarStyle: CalendarStyle(
               todayColor: Colors.orange,
               selectedColor: Theme.of(context).primaryColor,
             ),
           ),
           cardCalendar("MSBuilding.HCM", "7h - 12h"),
           cardCalendar("MSBuilding.HCM", "12h - 15h"),
           cardCalendar("MSBuilding.HCM", "15h - 19h"),
           cardCalendar("MSBuilding.HCM", "19h - 21h"),
         ],
       ),
     ),

     bottomNavigationBar: BottomNavigationBar(
       fixedColor: choose_bottombar,
       currentIndex: 3,
       onTap: (int index) {
         setState(() {
           if(index != 3) {
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
             icon: Icon(Icons.people, color: icon_bottombar), title: Text("People")),
         BottomNavigationBarItem(
             icon: Icon(Icons.check_circle, color: icon_bottombar), title: Text("Điểm danh")),
         BottomNavigationBarItem(
             backgroundColor: color_bottombar,
             icon: Icon(Icons.assignment, color: icon_bottombar), title: Text("Lịch")),
         BottomNavigationBarItem(
             icon: Icon(Icons.account_circle, color: icon_bottombar), title: Text("Cá nhân")),
       ],
     ),
    );
  }

}