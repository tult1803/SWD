import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:passioemployee/src/custom_form_builder.dart';
import 'package:passioemployee/src/sample_form.dart';
import 'package:quick_form/quick_form.dart';
import 'package:passioemployee/model/url/url_color.dart';

final GlobalKey _scaffoldKey = GlobalKey();

class MoreSetting extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MoreSettingState();
  }
}

class MoreSettingState extends State<MoreSetting>
    with SingleTickerProviderStateMixin {
  TabController controller;
  String onChangedString;

  void setChangedString(String changedString) => setState(() {
    onChangedString = changedString;
  });

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.chevron_left, size: 30, color: Colors.black,), onPressed: () => Navigator.pop(context), ) ,
        centerTitle: true,
        backgroundColor: color_main,
        title: Text("Sửa hồ sơ", style: TextStyle(color: Colors.black)),
      ),
        body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: FormBuilder(
                      form: sampleForm,
                      onFormSubmitted: resultsCallback,
                      onFormChanged: (map) => setChangedString(map.toString())),
                ),
              ],
            )));
  }
}

void resultsCallback(Map<String, String> results) => showDialog<void>(
    context: _scaffoldKey.currentContext,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(64),
      child: Card(
          child: Text(results.keys.fold(
              "",
                  (previousValue, element) =>
              "$previousValue$element = ${results[element]}\n"))),
    ));