import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:passioemployee/model/store_model.dart';
import 'package:passioemployee/model/url/url_color.dart';
import 'package:passioemployee/model/url/url_icon.dart';
import 'package:passioemployee/presenter/presenter_about.dart';
import 'package:passioemployee/view/attendance.dart';
import 'package:passioemployee/view/calendar.dart';
import 'package:passioemployee/view/home.dart';
import 'package:passioemployee/view/people_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile>{
  String name, short_name;
  int _selectedPage = 4;
  final _pageOptions = [
    Home(),
    People(),
    Attendance(),
    Calendar(),
    Profile(),
  ];

  @override
  void initState() {
    _getToken();
  }
  void _getToken()async{
    final prefs = await SharedPreferences.getInstance();
    setState((){
      name = prefs.getString('name_emp');
      short_name = prefs.getString('short_name_emp');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_main,
        leading: icon_appbar_about,
        title: Text("Cá Nhân", style: TextStyle(color: Colors.black),),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 100,
              child: Center(
                child: Column(
                  children: [
                    info("13:00", "12:00", "20:00", name, short_name),
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView(
                  children: [
                    lable_profile("Ca"),
                    container_profile(context, 0, "Ca sắp tới", shift_soon),
                    container_profile(context, 1, "Ca khả dụng", shift_availble),
                    container_profile(context, 2, "Bảng chấm công", shift_check),
                    lable_profile("Thời gian rảnh"),
                    container_profile(context, 3, "Nghỉ", time_relax),
                    container_profile(context, 4, "Trường hợp không rảnh", time_notime),
                    lable_profile("Tasks"),
                    container_profile(context, 5, "My Tasks", task_mytask),
                    container_profile(context, 6, "Assigned Tasks", task_asigned),
                    container_profile(context, 7, "Shift Tasks", task_shift),
                    lable_profile("Cần phê duyệt"),
                    container_profile(context, 8, "Yêu cầu nghỉ", wait_check),
                    lable_profile("Khác"),
                    container_profile(context, 9, "Sửa hồ sơ", more_profile),
                    container_profile(context, 10, "Liên hệ", more_contact),
                    container_profile_logout(context, "Đăng xuất", more_logout),
                  ],
                ),
            ),
          ],
        ),
      ),



      bottomNavigationBar: BottomNavigationBar(
        fixedColor: choose_bottombar,
        currentIndex: 4,
        onTap: (int index) {
          setState(() {
            if(index != 4) {
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
              icon: Icon(Icons.assignment, color: icon_bottombar), title: Text("Lịch")),
          BottomNavigationBarItem(
              backgroundColor: color_bottombar,
              icon: Icon(Icons.account_circle, color: icon_bottombar), title: Text("Cá nhân")),
        ],
      ),
    );
  }


}