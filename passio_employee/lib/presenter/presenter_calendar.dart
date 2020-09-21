
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget cardCalendar(String store, String time ){
  return Padding(
    padding: EdgeInsets.only(top:0.0),
    child: Card(
        child: Column(
//            mainAxisSize: MainAxisSize.min,
            children:[
              ListTile(
                  leading: Container(
                      width: 40,
                      child: Icon(Icons.work)),
                  title:  Text('$store', style: TextStyle(fontSize: 20),)),
//                 trailing: Text('$time', style: TextStyle(fontSize: 18),overflow: TextOverflow.clip,)),
              Row(
                children: [
                  SizedBox(width: 75,),
                Expanded(child: Container(
                  margin: EdgeInsets.only(bottom: 40),
                    child: Text('Thời gian: $time', style: TextStyle(fontSize: 18, color: Colors.black54),overflow: TextOverflow.clip,))),
                  ButtonBar(
                      children: [
                        FlatButton(
                          child:  Text('More'),
                          onPressed: () {/* ... */},
                        )]),
                ],
              ),
            ])),
  );
}