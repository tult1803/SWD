
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passioemployee/view/dettails_about/shift/details_swap.dart';

Widget cardToSwapShift(BuildContext context,String store, String time , int id){
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
                          onPressed: () {
                            // print('ID: $id');
                            _sendDataToDetailCalendarScreen(context, id);                          },
                        )]),
                ],
              ),
            ])),
  );
}

void _sendDataToDetailCalendarScreen(BuildContext context, int id1) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsSwap(id: id1),
      ));
}
