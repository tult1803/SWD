import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passioemployee/model/url/url_color.dart';

class RequestBreak extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return RequestBreakState();
  }
}

class RequestBreakState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.chevron_left, size: 30, color: Colors.black,), onPressed: () => Navigator.pop(context), ) ,
        backgroundColor: color_main,
        centerTitle: true,
        title: Text("Yêu cầu nghỉ", style: TextStyle(color: Colors.black)),
      ),
    );
  }

}