
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passioemployee/model/getAPI_attendance_getBydate.dart';
import 'package:passioemployee/model/model_attendance_getBydate.dart';
import 'package:passioemployee/model/url/url_color.dart';
import 'package:passioemployee/model/url/url_icon.dart';
import 'package:passioemployee/presenter/presenter_calendar.dart';
import 'package:passioemployee/view/people_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import 'about.dart';
import 'attendance.dart';
import 'home.dart';

class Calendar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CalendarState();
  }
}

String token,empId, date;

class CalendarState extends State<Calendar> {
  CalendarController _controller;
  int _selectedPage = 3;
  final _pageOptions = [
    // Thay Text bằng class để Na
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
    date = '${DateTime.now()}';
    date = date.substring(0, 10).trim();
    _getToken();
    _getNews();
    _controller = CalendarController();
  }
  GetByDateAPI _getByDateAPI = GetByDateAPI();
  List<dynamic> data_list = [];
  List<GetByDate> data_list_getBydate = [];

  void _getNews() async{
    int i = 0;
    data_list = await _getByDateAPI.getByDate(token, date, empId);
    print('${data_list.length}');
    data_list.forEach((element) {
      Map<dynamic, dynamic> data= element;
      data_list_getBydate.add(GetByDate.fromJson(data));
      print('ID: ${data_list_getBydate[i++].id}');
    });
  }

  void _getToken()async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      empId = prefs.getString('id_emp');
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_main,
        leading: icon_appbar_calendar,
        title: Text(
          "Lịch",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: FutureBuilder(
          future:  _getByDateAPI.getByDate(token, date, empId),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              print(snapshot.error);
            }
            if(snapshot.hasData){
              if(data_list_getBydate.length != 0) {
                return new Column(
                  children: [
                    TableCalendar(
                      initialCalendarFormat: CalendarFormat.week,
                      calendarController: _controller,
                      calendarStyle: CalendarStyle(
                        todayColor: Colors.orange,
                        selectedColor: Theme
                            .of(context)
                            .primaryColor,
                      ),
                      onDaySelected: (day, events) {
                        setState(() {
                          date = '$day';
                          date = date.substring(0, 10).trim();
                          data_list_getBydate.clear();
                          _getNews();
                        });
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: data_list_getBydate.length,
                        itemBuilder: (context, index) {
                          String sTime, eTime;
                          sTime = '${data_list_getBydate[index].shift_min}';
                          sTime = sTime.substring(11, 16).trim();
                          eTime = '${data_list_getBydate[index].shift_max}';
                          eTime = eTime.substring(11, 16).trim();
                          return GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: cardCalendar(
                                  data_list_getBydate[index].store_name,
                                  '$sTime - $eTime'),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }else{
                return new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TableCalendar(
                      initialCalendarFormat: CalendarFormat.week,
                      calendarController: _controller,
                      calendarStyle: CalendarStyle(
                        todayColor: Colors.orange,
                        selectedColor: Theme
                            .of(context)
                            .primaryColor,
                      ),
                      onDaySelected: (day, events) {
                        setState(() {
                          date = '$day';
                          date = date.substring(0, 10).trim();
                          data_list_getBydate.clear();
                          _getNews();
                        });
                      },
                    ),
                    Expanded(
                        child: Container(
                          width: size.width,
                          child: Center(child: Padding(
                            padding: const EdgeInsets.only(bottom: 100.0),
                            child: Text('Không có ca làm', style: TextStyle(fontSize: 20, color: Colors.black54),),
                          )),
                        ),
                    ),
                  ],
                );
              }
            }else {
              return Center(child: CircularProgressIndicator());
            }

          } ),

      bottomNavigationBar: BottomNavigationBar(
        fixedColor: choose_bottombar,
        currentIndex: 3,
        onTap: (int index) {
          setState(() {
            if (index != 3) {
              _selectedPage = index;
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => _pageOptions[_selectedPage]),
                  (route) => false);
            }
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.fiber_new, color: icon_bottombar),
              title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.people, color: icon_bottombar),
              title: Text("People")),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle, color: icon_bottombar),
              title: Text("Điểm danh")),
          BottomNavigationBarItem(
              backgroundColor: color_bottombar,
              icon: Icon(Icons.assignment, color: icon_bottombar),
              title: Text("Lịch")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: icon_bottombar),
              title: Text("Cá nhân")),
        ],
      ),
    );
  }
}
