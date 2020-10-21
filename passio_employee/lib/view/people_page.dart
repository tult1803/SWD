import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passioemployee/model/getAPI_people.dart';
import 'package:passioemployee/model/model_profile_emp.dart';
import 'package:passioemployee/model/url/url_color.dart';
import 'package:passioemployee/model/url/url_icon.dart';
import 'package:passioemployee/presenter/presenter_people.dart';

import 'about.dart';
import 'attendance.dart';
import 'calendar.dart';
import 'home.dart';

class People extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PeopleState();
  }
}

class PeopleState extends State {
  static String token;
  int _selectedPage = 1;
  final _pageOptions = [
    // Thay Text bằng class để Na
    Home(),
    People(),
    Attendance(),
    Calendar(),
    Profile(),
  ];

  void getPeople() async {
    GetAPIPeople getAPI = GetAPIPeople();
    setState(() async {
      data_list = await getAPI.getPeople(HomeState.token);
      data_list.forEach((element) {
        Map<dynamic, dynamic> data = element;
        data_list_people.add(DataProfile.fromJson(data));
      });
    });
  }

  List<dynamic> data_list = [];
  List<DataProfile> data_list_people = [];

  @override
  void initState() {
    getPeople();
  }

  @override
  Widget build(BuildContext context) {
    GetAPIPeople getAPI = GetAPIPeople();
    return Scaffold(
        appBar: AppBar(
            backgroundColor: color_main,
            leading: icon_appbar_people,
            title: Text(
              "People",
              style: TextStyle(color: Colors.black),
            )),
        body: FutureBuilder(
            future: getAPI.getPeople(HomeState.token),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
              }
              if (snapshot.hasData) {
                return new ListView.builder(
                  itemCount: data_list.length,
                  itemBuilder: (context, index) {
                    String check;
                    Color color;
//        if(data_list[1].employee_name != data_list[index].employee_name){
                    if (true) {
                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: container_Calendar(
                              index,
                              Colors.lightGreenAccent,
                              data_list_people[index].name,
                              'Vị trí',
                              true),
                        ),
                      );
                    }
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
        bottomNavigationBar: BottomNavigationBar(
//       fixedColor: Color.fromARGB(255, 168,206,60),\
          fixedColor: choose_bottombar,
          currentIndex: 1,
          onTap: (int index) {
            setState(() {
              if (index != 1) {
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
                backgroundColor: color_bottombar,
                icon: Icon(Icons.people, color: icon_bottombar),
                title: Text("People")),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle, color: icon_bottombar),
                title: Text("Điểm danh")),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment, color: icon_bottombar),
                title: Text("Lịch")),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, color: icon_bottombar),
                title: Text("Cá nhân")),
          ],
        ));
  }
}
