import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passioemployee/model/getAPI_profile_emp.dart';
import 'package:passioemployee/model/model_profile_emp.dart';
import 'package:passioemployee/view/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget cardNews(String tittle, String text ){
  return Padding(
    padding: EdgeInsets.only(top:0.0),
    child: Card(
        child: Column(
//            mainAxisSize: MainAxisSize.min,
            children:[
                 ListTile(
                  leading: Icon(Icons.new_releases),
                  title:  Text('$tittle',),
                  subtitle: SafeArea(child: Container(height: 50,child: Text('$text', overflow: TextOverflow.clip,)))),
              ButtonBar(
                  children: [
                    FlatButton(
                      child:  Text('More'),
                        onPressed: () {

                      },
                    )])])),
  );
}