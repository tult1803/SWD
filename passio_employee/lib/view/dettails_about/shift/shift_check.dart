
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passioemployee/model/getAPI_totalTime.dart';
import 'package:passioemployee/model/model_attendance.dart';
import 'package:passioemployee/model/url/url_color.dart';
import 'package:passioemployee/presenter/presenter_attendace.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;


class ShiftCheck extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ShiftCheckState();
  }
}

class ShiftCheckState extends State {
  List<dynamic> picked;
  Map<String, dynamic> _data = {"":[]};
  List<AttendanceAPI> list = [];
  GetTotalTimeAPI _getTotalTimeAPI = GetTotalTimeAPI();
  String token, fromDate = DateTime(DateTime.now().year, DateTime.now().month).toString().substring(0, 10).trim(),
      toDate = DateTime.now().toString().substring(0, 10).trim(), empId, totalTime ='0';

  @override
  void initState() {
    super.initState();
    _getToken();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.chevron_left, size: 30, color: Colors.black,), onPressed: () => Navigator.pop(context), ) ,
        centerTitle: true,
        backgroundColor: color_main,
        title: Text("Bảng chấm công", style: TextStyle(color: Colors.black)),
      ),
      body: FutureBuilder (
        future: _getTotalTimeAPI.getTotalTime(token, empId, fromDate, toDate),
          builder: (context, snapshot) {
            if (_data.values.last.isNotEmpty) {
              return new Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: MaterialButton(
                          color: Colors.lightGreen,
                          onPressed: () async {
                            await _pickDate();
                            _data = await _getTotalTimeAPI.getTotalTime(
                                token, empId, fromDate, toDate);
                            print(_data.toString());
                            setState(() {
                                list.clear();
                                _data.values.last.forEach((element) {
                                  dynamic data = element;
                                  list.add(AttendanceAPI.fromJson(data));
                                });
                              totalTime = '${_data.values.first}';
                              if (totalTime.contains('.')) {
                                int day = int.parse(totalTime.substring(
                                    0, totalTime.indexOf('.')));
                                int hour = int.parse(totalTime.substring(
                                    totalTime.indexOf('.') + 1,
                                    totalTime.indexOf(':')));
                                int total = day * 24 + hour;
                                totalTime = '$total${totalTime.substring(
                                    totalTime.indexOf(':'))}';
                              }
                            });
                          },
                          child: new Text("Chọn ngày")
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("Tổng giờ công: $totalTime ( ${fromDate.substring(
                      8, 10)}/${fromDate.substring(5, 7)} - ${toDate.substring(
                      8, 10)}/${toDate.substring(5, 7)} )",
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  SizedBox(height: 20,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Padding(
                            padding:
                            const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: container_attendance(
                                Color.fromARGB(255, 168, 206, 60),
                                Colors.white70,
                                list[index].store_name,
                                list[index].shift_min,
                                list[index].shift_max,
                                "Present"),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return new Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: MaterialButton(
                          color: Colors.lightGreen,
                          onPressed: () async {
                            await _pickDate();
                            _data = await _getTotalTimeAPI.getTotalTime(
                                token, empId, fromDate, toDate);
                            setState(() {
                              list.clear();
                              _data.values.last.forEach((element) {
                                dynamic data = element;
                                list.add(AttendanceAPI.fromJson(data));
                              });
                              totalTime = '${_data.values.first}';
                              if (totalTime.contains('.')) {
                                int day = int.parse(totalTime.substring(
                                    0, totalTime.indexOf('.')));
                                int hour = int.parse(totalTime.substring(
                                    totalTime.indexOf('.') + 1,
                                    totalTime.indexOf(':')));
                                int total = day * 24 + hour;
                                totalTime = '$total${totalTime.substring(
                                    totalTime.indexOf(':'))}';
                              }
                            });
                          },
                          child: new Text("Chọn ngày")
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("Tổng giờ công: $totalTime ( ${fromDate.substring(
                      8, 10)}/${fromDate.substring(5, 7)} - ${toDate.substring(
                      8, 10)}/${toDate.substring(5, 7)} )",
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  Expanded(
                    child: Container(
                      width: size.width,
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 100.0),
                            child: Text(
                              'Không có ca làm',
                              style:
                              TextStyle(fontSize: 20, color: Colors.black54),
                            ),
                          )),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }

  void _getToken() async{
    var prefes = await SharedPreferences.getInstance();
    setState(() {
      token = prefes.get('token');
      empId = prefes.get('id_emp');
      fromDate ='${DateTime(DateTime.now().year, DateTime.now().month).toString().substring(0, 10).trim()}';
      toDate = '${DateTime.now().toString().substring(0, 10).trim()}';
    });
    _data = await _getTotalTimeAPI.getTotalTime(token, empId, fromDate, toDate);
    setState(() {
      list.clear();
      _data.values.last.forEach((element) {
        dynamic data = element;
        list.add(AttendanceAPI.fromJson(data));
      });
      totalTime = '${_data.values.first}';
      if(totalTime.contains('.')){
        int day = int.parse(totalTime.substring(0, totalTime.indexOf('.')));
        int hour = int.parse(totalTime.substring(totalTime.indexOf('.') + 1, totalTime.indexOf(':')));
        int total = day*24 + hour;
        totalTime = '$total${totalTime.substring(totalTime.indexOf(':'))}';
      }
    });
  }

  _pickDate() async{
    picked = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: DateTime(DateTime.now().year, DateTime.now().month),
      initialLastDate: DateTime.now(),
      firstDate:   DateTime(DateTime.now().year - 1),
      lastDate:  DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked.length == 2) {
      setState(() {
        fromDate = '${picked.first}';
        fromDate = fromDate.substring(0, 10).trim();
        toDate = '${picked.last}';
        toDate = toDate.substring(0, 10).trim();
        print("from: ${fromDate}");
        print("to: ${toDate}");
      });
    }
  }
}