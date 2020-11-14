import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:passioemployee/model/model_attendance_getBydate.dart';
import 'package:passioemployee/model/putAPI_changeShiftWork.dart';
import 'package:passioemployee/model/url/url_color.dart';
import 'package:passioemployee/view/calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsCalendar extends StatefulWidget {
  final GetByDate dataGetByDate;

  // DetailsCalendar(this.id);
  DetailsCalendar({Key key, @required this.dataGetByDate}) : super(key: key);

  @override
  _DetailsCalendarState createState() => _DetailsCalendarState(dataGetByDate);
}

class _DetailsCalendarState extends State<DetailsCalendar> {
  final GetByDate dataGetByDate;
  GetByDate data;
  String work_id, sTime, eTime, store, day;

  _DetailsCalendarState(this.dataGetByDate);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToken();
  }

  void _getToken() async {
    data = dataGetByDate;
    setState(() {
      work_id = data.id.toString();
      store = data.store_name;
      sTime = data.shift_min;
      sTime = '${sTime.substring(11, 16)}';
      eTime = data.shift_max;
      day = '${eTime.substring(0, 10)}';
      eTime = '${eTime.substring(11, 16)}';
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
          "Chi tiết lịch",
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
                  card('Cửa hàng', '$store'),
                  card('Ngày nhận ca', '$day'),
                  Row(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        card('Giờ nhận ca', '$sTime'),
                        card('Giờ kết thúc ca', '$eTime'),
                      ],
                    ),
                    Expanded(
                      child: detailCard(),
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

  Widget detailCard() {
    DateTime now = DateTime.now();
    DateTime dateInShift = DateTime.parse(day);
    bool compared = dateInShift.isBefore(now);
    print("DateInShift is before now : ${compared}");
    if (compared) {
      if (data.present) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Present',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  )),
            ),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Absent',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  )),
            ),
          ],
        );
      }
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(20),
            ),
            child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => confirmDialog(work_id),
                    barrierDismissible: false,
                  );
                },
                child: Text(
                  'Đổi ca',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                )),
          ),
        ],
      );
    }
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

  Widget confirmDialog(String work_id) {
    return AlertDialog(
      title: Text("Xác nhận"),
      content: Text("Bạn muốn đổi ca làm việc này?"),
      actions: [
        FlatButton(
          child: Text("Không"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Có"),
          onPressed: () async {
            var prefs = await SharedPreferences.getInstance();
            PutAPIChangeShiftWork _apiChangeShiftWork = PutAPIChangeShiftWork();
            int resultChangeShiftWork = await _apiChangeShiftWork
                .changeShiftWork(work_id, prefs.getString('token'));
            if (resultChangeShiftWork == 200) {
              await _showDialog('Đổi ca thành công !');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Calendar(),
                  ));
            } else {
              Navigator.of(context).pop();
              _showDialog('Đổi ca lỗi. Thử lại !');
            }
          },
        )
      ],
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
