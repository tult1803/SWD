import 'package:passioemployee/model/model_attendance.dart';
import 'package:passioemployee/model/model_profile_emp.dart';
import 'package:passioemployee/model/url/url_color.dart';
import 'package:flutter/material.dart';
import 'package:passioemployee/model/model_news.dart';

class PeopleDetails extends StatefulWidget {
  final AttendanceAPI dataPeople;

  // NewsDetails(this.id);
  PeopleDetails({Key key, @required this.dataPeople}) : super(key: key);

  @override
  DetailPeopleState createState() => DetailPeopleState(dataPeople);
}

class DetailPeopleState extends State<PeopleDetails> {
  final AttendanceAPI dataPeople;
  AttendanceAPI data;
  String id, status, employee_name, shift_min, shift_max, bank_number, store_name, salary, date;
  bool gender, active;

  DetailPeopleState(this.dataPeople);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToken();
  }

  void _getToken() async {
    data = dataPeople;
    setState(() {
      id = data.id.toString();
      status = data.status.toString();
      employee_name = data.employee_name;
      int indexOfTChar = data.shift_min.indexOf('T');
      date = data.shift_min.substring(0, indexOfTChar);
      shift_min = data.shift_min.substring(indexOfTChar + 1);
      shift_max = data.shift_max.substring(indexOfTChar + 1);
      store_name = data.store_name;
    });
    // print('${data.keys}');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 30,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: color_main,
        title: Text(
          "Thông tin nhân viên",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(10),
            // height: 200,
            width: size.width,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black12, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  card('Tên nhân viên', '$employee_name'),
                  Row(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        card('Ngày làm', '$date'),
                        card('Giờ bắt đầu', '$shift_min'),
                        card('Giờ kết thúc', '$shift_max'),
                        card('Tên cửa hàng', '$store_name'),
                      ],
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget card(String tittle, String txt) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10),
      child: Row(
        children: [
          Text(
            '$tittle: ',
            style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w400),
          ),
          Text(
            '$txt',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
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
}