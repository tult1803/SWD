import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:passioemployee/model/getAPI_calendar_getByid.dart';
import 'package:passioemployee/model/putAPI_swapShift.dart';
import 'package:passioemployee/model/url/url_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home.dart';

class DetailsSwap extends StatefulWidget {
  final int id;

  // DetailsCalendar(this.id);
  DetailsSwap({Key key, @required this.id}) : super(key: key);

  @override
  _DetailsSwapState createState() => _DetailsSwapState(id);
}

class _DetailsSwapState extends State<DetailsSwap> {
  final id;
  Map<dynamic, dynamic> data;
  GetByIDAPI _getAPI = GetByIDAPI();
  String token, sTime, eTime, store, day, idEmp;
  int employee_id;

  _DetailsSwapState(this.id);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToken();
    _getIDEmp();
  }

  void _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
    data = await _getAPI.getByID(token, id);
    setState(() {
      store = data.values.elementAt(6);
      sTime = data.values.elementAt(3);
      sTime = '${sTime.substring(11, 16)}';
      eTime = data.values.elementAt(4);
      day = '${eTime.substring(0, 10)}';
      eTime = '${eTime.substring(11, 16)}';
    });
    // print('${data.keys}');
  }

  void _getIDEmp() async{
    final prefs = await SharedPreferences.getInstance();
     idEmp = prefs.getString('id_emp');

     setState(() {
       employee_id = int.parse(idEmp);
       print("Id Emp: $employee_id");
     });
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
          "Chi tiết đổi ca",
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
                                    _showDialog();
                                  },
                                  child: Text(
                                    'Nhận ca',
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

  void _showDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thông báo", style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
          )),
          content: new Text("Chắc chắn đổi ca !!!", style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("No", style: TextStyle(color: Colors.redAccent),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            new FlatButton(
              child: new Text("Yes" , style: TextStyle(color: Colors.lightGreen),),
              onPressed: () async{
                PutSwapAPI _putSwap = PutSwapAPI();
                int status = await _putSwap.putSwap(token, id, employee_id);
                if(status == 200){
                  print('ID Swap: $id - Id Emp: $employee_id');
                  await _showDialogError('Đổi ca thành công !');
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home()), (route) => false);
                }else {
                  await _showDialogError('Đổi ca lỗi !');
                  Navigator.of(context).pop();
                }
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


  void _showDialogError(String error) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thông báo"),
          content: new Text("$error", style: TextStyle(
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
