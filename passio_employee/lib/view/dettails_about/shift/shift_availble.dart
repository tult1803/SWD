
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passioemployee/model/getAPI_getPublic_attendance.dart';
import 'package:passioemployee/model/model_attendance_getBydate.dart';
import 'package:passioemployee/model/url/url_color.dart';
import 'package:passioemployee/presenter/presenter_swapShift.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class ShiftAvailable extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ShiftAvailableState();
  }
}

String token,empId, date;

class ShiftAvailableState extends State {
  CalendarController _controller;
  int _selectedPage = 3;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = '${DateTime.now()}';
    date = date.substring(0, 10).trim();
    _getNews();
    _controller = CalendarController();
  }
  GetPublicAttendacesAPI _getPublicAttendacesAPI = GetPublicAttendacesAPI();
  List<dynamic> data_list = [];
  List<GetByDate> data_list_getBydate = [];

  void _getNews() async{
    int i = 0;
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      empId = prefs.getString('id_emp');
    });
    data_list = await _getPublicAttendacesAPI.getPublicAttendaces(token, date, empId);
    print('${data_list.length}');
    data_list.forEach((element) {
      Map<dynamic, dynamic> data= element;
      data_list_getBydate.add(GetByDate.fromJson(data));
      // print('ID: ${data_list_getBydate[i++].id}');
    });
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.chevron_left, size: 30, color: Colors.black,), onPressed: () => Navigator.pop(context), ) ,
        centerTitle: true,
        backgroundColor: color_main,
        title: Text("Ca khả dụng", style: TextStyle(color: Colors.black)),
      ),
      body: FutureBuilder(
          future:  _getPublicAttendacesAPI.getPublicAttendaces(token, date, empId),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              print(snapshot.error);
            }
            if(snapshot.hasData){
              // if(data_list_getBydate.length != 0) {
              return new Column(
                  children: [
                    SizedBox(height: 20,),
                    // TableCalendar(
                    //   initialCalendarFormat: CalendarFormat.week,
                    //   calendarController: _controller,
                    //   calendarStyle: CalendarStyle(
                    //     todayColor: Colors.orange,
                    //     selectedColor: Theme
                    //         .of(context)
                    //         .primaryColor,
                    //   ),
                    //   onDaySelected: (day, events) {
                    //     setState(() {
                    //       date = '$day';
                    //       date = date.substring(0, 10).trim();
                    //       data_list_getBydate.clear();
                    //       _getNews();
                    //
                    //     });
                    //   },
                    // ),
                    Expanded(child: checkDays(size, data_list_getBydate)),
                  ]);
            }else {
              return Center(child: CircularProgressIndicator());
            }

          } ),
    );
  }

  Widget checkDays(var size, List data_list_getBydate){
    if(data_list_getBydate.length != 0){
      return  ListView.builder(
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
              child: cardToSwapShift(
                context,
                data_list_getBydate[index].store_name,
                '$sTime - $eTime',
                data_list_getBydate[index].id,
              ),
            ),
          );
        },
      );
    }else{
      return  Container(
        width: size.width,
        child: Center(child: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Text('Không có ca làm', style: TextStyle(fontSize: 20, color: Colors.black54),),
        )),
      );
    }
  }

}