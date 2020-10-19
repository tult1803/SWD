

import 'package:flutter/material.dart';
import 'package:passioemployee/model/url/url_color.dart';
import 'package:passioemployee/view/dettails_about/more/contact.dart';
import 'package:passioemployee/view/dettails_about/more/request_break.dart';
import 'package:passioemployee/view/dettails_about/more/setting.dart';
import 'package:passioemployee/view/dettails_about/shift/shift_availble.dart';
import 'package:passioemployee/view/dettails_about/shift/shift_check.dart';
import 'package:passioemployee/view/dettails_about/shift/shift_soon.dart';
import 'package:passioemployee/view/dettails_about/tasks/task_assigned.dart';
import 'package:passioemployee/view/dettails_about/tasks/task_my.dart';
import 'package:passioemployee/view/dettails_about/tasks/task_shift.dart';
import 'package:passioemployee/view/dettails_about/time/time_relax.dart';
import 'package:passioemployee/view/dettails_about/time/time_unrelax.dart';
import 'package:passioemployee/view/login_screen.dart';
import 'package:random_color/random_color.dart';
import 'package:shared_preferences/shared_preferences.dart';


Widget lable_profile(String txt){
  return Container(
    padding: EdgeInsets.only(left: 20),
    alignment: Alignment.centerLeft,
    color: profile_shift,
    height: 40,
    child: Text("$txt", style: TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 20,
      color: Colors.black45,
    ),),
  );
}

Widget container_profile(BuildContext context, int id,String txt, Icon icon){
  final _pageOptions = [
    ShiftSoon(),
    ShiftAvailable(),
    ShiftCheck(),
    TimeRelax(),
    TimeUnrelax(),
    TaskMy(),
    TaskAssigned(),
    TaskShift(),
    RequestBreak(),
    MoreSetting(),
    MoreContact(),
  ];

  return FlatButton(
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => _pageOptions[id]));
    },
    child: Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          icon,
          SizedBox(width: 10,),
          Expanded(
            child: Text("$txt", style: TextStyle(
                fontSize: 20
            ),),
          ),
          Container(
            width: 40,
            child: Image(image: AssetImage('images/arrow_right.png'),),
          ),
        ],
      ),
    ),
  );
}

Widget container_profile_logout(BuildContext context, String txt, Icon icon){
  return FlatButton(
    onPressed: () async{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.clear();
      print("Clear Save Login");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()), (Route<dynamic> route) => false);

    },
    child: Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          icon,
          SizedBox(width: 10,),
          Expanded(
            child: Text("$txt", style: TextStyle(
                fontSize: 20
            ),),
          ),
          Container(
            width: 40,
            child: Image(image: AssetImage('images/arrow_right.png'),),
          ),
        ],
      ),
    ),
  );
}

Widget btnTime(){
  return Container(
    margin: EdgeInsets.all(5),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.black,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: IconButton(
      padding: EdgeInsets.all(0),
      icon: Icon(Icons.access_time, size: 40,),
      onPressed: ()
      {
        // Code here
      },),
  );
}

Widget btnShift(String txt, Color color){
  return Container(
    width: 150,
    margin: EdgeInsets.all(5),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: FlatButton(
      onPressed: () {},
      child: Text("${txt}", style: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),),
    ),
  );
}

Widget circle_avata(String short_name, Color color_status){
  RandomColor _randomColor = RandomColor();
  return CircleAvatar(
    radius: 37,
    backgroundColor: _randomColor.randomColor(
        colorBrightness: ColorBrightness.light  // Chỉ random ra màu sáng
    ),

    child: Stack(
      children: [
          Container(
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(37),
          ),
            alignment: Alignment.center,
            child: textName("${short_name}"),
          ),
//        ),
        Container(
          alignment: Alignment.bottomRight,
          child: SizedBox(
            width: 25.0,
            height: 25.0,
            child: FloatingActionButton(
              backgroundColor: color_status,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget info(String time, String start_time, String end_time, String full_name, String short_name){
  return Container(
    margin: EdgeInsets.only(left: 5),
    height: 90,
    child: Center(
      child: Row(
        children: [
          circle_avata("", Colors.lightGreenAccent),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: tittleName("${full_name}"),
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: timeStart("${time}"),),
                  Container(
                      margin: EdgeInsets.only(top: 2),
                      alignment: Alignment.centerLeft,
                      child: timeShift("${start_time}", "${end_time}")),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
Widget textName(String name){
  return Text("${name} ", overflow: TextOverflow.visible,style: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w800,
      color: Colors.white
  ),);
}

Widget tittleName(String name){
  return Text("${name}", style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.black
  ),);
}

Widget timeStart(String time){
  return Text("Bắt đầu ${time}", style: TextStyle(
      fontSize: 15,
//      fontWeight: FontWeight.w600,
      color: Colors.black45
  ),);
}

Widget timeShift(String start, String end){
  return Text("${start} - ${end}", style: TextStyle(
      fontSize: 20,
//      fontWeight: FontWeight.w600,
      color: Colors.lightBlue,
  ),);
}