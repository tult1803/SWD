import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passioemployee/model/url/url_color.dart';

class TaskMy extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TaskMyState();
  }
}

class TaskMyState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.chevron_left, size: 30, color: Colors.black,), onPressed: () => Navigator.pop(context), ) ,
        centerTitle: true,
        backgroundColor: color_main,
        title: Text("My Tasks", style: TextStyle(color: Colors.black)),
      ),
    );
  }

}