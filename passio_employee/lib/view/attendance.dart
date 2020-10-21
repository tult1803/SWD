import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:passioemployee/model/getAPI_attendance.dart';
import 'package:passioemployee/model/model_attendance.dart';
import 'package:passioemployee/model/postAPI_checkAttendance.dart';
import 'package:passioemployee/model/url/url_color.dart';
import 'package:passioemployee/model/url/url_icon.dart';
import 'package:passioemployee/presenter/presenter_attendace.dart';
import 'package:passioemployee/view/people_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'calendar.dart';
import 'home.dart';
import 'about.dart';

class Attendance extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AttendanceState();
  }
}

var qrcode;

class AttendanceState extends State<Attendance> {
  String _nameEmp;
  int _selectedPage = 2;
  String value;
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
    getAttendance();
  }

  void getAttendance() async {
    final prefs = await SharedPreferences.getInstance();
    _nameEmp = prefs.getString("name_emp");
    GetAPIAttendance getAPI = GetAPIAttendance();
    setState(() async {
//       do {
//         data_list = await getAPI.getAttendance(HomeState.token);
//         for (int i = 0; i < data_list.length; i++) {
//           if (data_list[i].employee_name.contains(_nameEmp)) {
// //            print('Count: $i');
// //            print("${data_list[i].employee_name}  --- $_nameEmp");
//             data_list.add(data_list.elementAt(i));
// //            print("Data: ${data_list.length}");
//           }
//         }
//       } while (data_list.isEmpty);
      data_list = await getAPI.getAttendance(HomeState.token);
      data_list.forEach((element) {
        Map<dynamic, dynamic> data = element;
        data_list_people.add(AttendanceAPI.fromJson(data));
      });
    });
  }

  List<dynamic> data_list = [];
  List<AttendanceAPI> data_list_people = [];
  PostAPIAttendance _postAPIAttendance = PostAPIAttendance();

  @override
  Widget build(BuildContext context) {
    GetAPIAttendance getAPI = GetAPIAttendance();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_main,
        leading: icon_appbar_attendance,
        title: Text("Điểm danh", style: TextStyle(color: Colors.black)),
      ),
      body: FutureBuilder(
          future: getAPI.getAttendance(HomeState.token),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            if (snapshot.hasData) {
              return new Column(
                children: [
                  Container(
                    height: size.height * .2,
                    child: Center(
                      child: RaisedButton(
                        color: Color.fromARGB(255, 168, 206, 60),
                        onPressed: () async {
                          value = await FlutterBarcodeScanner.scanBarcode(
                              "#004297", "Cancel", false, ScanMode.QR);
                          await checkAtt(value);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 100,
                          child: Text(
                            "QR-CODE",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: data_list_people.length,
                      itemBuilder: (context, index) {
                        String check;
                        Color color;
                        if (data_list_people[index].status == 0) {
                          color = Colors.orangeAccent;
                          check = "Processing";
                        } else if (data_list_people[index].status == 1) {
                          color = Color.fromARGB(255, 168, 206, 60);
                          check = "Present";
                        } else if (data_list_people[index].status == 2) {
                          color = Color.fromARGB(255, 168, 206, 60);
                          check = "Reject";
                        } else if (data_list_people[index].status == 3) {
                          color = Color.fromARGB(255, 168, 206, 60);
                          check = "Employee Submit";
                        } else if (data_list_people[index].status == 4) {
                          color = Colors.black45;
                          check = "Draft";
                        } else if (data_list_people[index].status == 5) {
                          color = Colors.black45;
                          check = "Closed";
                        } else if (data_list_people[index].status == 6) {
                          color = Colors.red;
                          check = "Absent";
                        }
                        ;
//                          if(data_list[index].employee_name == _nameEmp){
                        return GestureDetector(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: container_attendance(
                                color,
                                Colors.white70,
                                data_list_people[index].store_name,
                                data_list_people[index].shift_min,
                                check),
                          ),
                        );
//                          }
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: choose_bottombar,
        currentIndex: 2,
        onTap: (int index) {
          setState(() {
            if (index != 2) {
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
              backgroundColor: color_bottombar,
              icon: Icon(Icons.check_circle, color: icon_bottombar),
              title: Text("Điểm danh")),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment, color: icon_bottombar),
              title: Text("Lịch")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: icon_bottombar),
              title: Text("Cá nhân")),
        ],
      ),
    );
  }

  void _showDialog(String error) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thông báo"),
          content: new Text("$error",
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((val) {
      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      // builder: (BuildContext context) => LoginScreen()), (
      // Route<dynamic> route) => false);
    });
  }

  void checkAtt(String value) {
    setState(() async {
      var prefs = await SharedPreferences.getInstance();
      String time;
      int storeId;
      try {
        time = await value.substring(0, value.indexOf(';'));
        storeId = await int.parse(value.substring(value.indexOf(';') + 1));
      } catch (e) {
        print(e);
        return _showDialog('Quét mã ngu !!!');
      }
      int checkAtt = await _postAPIAttendance.checkAttendance(
          time, prefs.getString('id_emp'), storeId, prefs.getString('token'));
      print(time);
      print(checkAtt);
      if (checkAtt == 200) {
        _showDialog('Điểm danh thành công !!!');
        print("Điểm danh thành công");
        GetAPIAttendance getAPI = GetAPIAttendance();
        //setState(() async {
        data_list_people = [];
        data_list = await getAPI.getAttendance(HomeState.token);
        data_list.forEach((element) {
          Map<dynamic, dynamic> data = element;
          data_list_people.add(AttendanceAPI.fromJson(data));
        });
        //});
      } else {
        _showDialog('Điểm danh lỗi. Thử lại !!!');
      }
    });
  }
}
