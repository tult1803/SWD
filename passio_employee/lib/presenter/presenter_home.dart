import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passioemployee/model/getAPI_profile_emp.dart';
import 'package:passioemployee/model/model_news.dart';
import 'package:passioemployee/model/model_profile_emp.dart';
import 'package:passioemployee/view/home.dart';
import 'package:passioemployee/view/news_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget cardNews(BuildContext context, String tittle, String text, String dateTime,String code, DataNews dataNews){
  return Padding(
    padding: EdgeInsets.only(top:0.0),
    child: Card(
        child: Column(
//            mainAxisSize: MainAxisSize.min,
            children:[
                 ListTile(
                  leading: Icon(Icons.new_releases),
                  title:  Text('$tittle',),
                  // trailing: Text('$code'),
                  subtitle: SafeArea(child: Container(height: 50,child: Text('$text', overflow: TextOverflow.clip,)))),
              Container(
                height: 30,
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 75.0),
                          child: Text('${dateTime}'),
                        ),
                    ),
                    Container(
                      width: 80,
                      child: ButtonBar(
                          children: [
                            FlatButton(
                              child:  Text('More'),
                                onPressed: () {
                                  _sendDataToDetailNewsScreen(context, dataNews);
                              },
                            )]),
                    ),
                  ],
                ),
              )])),
  );
}

void _sendDataToDetailNewsScreen(BuildContext context, DataNews dataNews) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetails(dataNews: dataNews),
      ));
}