import 'package:flutter/material.dart';
import 'package:passioemployee/model/model_attendance_getBydate.dart';
import 'package:passioemployee/model/url/url_color.dart';
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
  String sTime, eTime, store, day;

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
                        child: Column(
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
                                    borderRadius:
                                    BorderRadius.circular(20),
                                  ),
                                  onPressed: () {

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
                        )),
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
}
