import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passioemployee/model/url/url_color.dart';

class TimeUnrelax extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TimeUnrelaxState();
  }
}

class TimeUnrelaxState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.chevron_left, size: 30, color: Colors.black,), onPressed: () => Navigator.pop(context), ) ,
        centerTitle: true,
        backgroundColor: color_main,
        title: Text("Trường hợp không rảnh", style: TextStyle(color: Colors.black)),
      ),
    );
  }

}