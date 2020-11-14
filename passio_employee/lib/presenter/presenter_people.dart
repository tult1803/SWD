//import 'package:flutter/material.dart';
//
//
//Widget container_Calendar(Color color_status,Color color, String store_name, String date_time,String status){
//  return Container(
//    margin: EdgeInsets.only(bottom: 3),
//    height: 80,
//    child: Row(
//      children: [
//        Container(
//          width: 200,
//          child: Column(
//            children: [
//              Padding(
//                padding: const EdgeInsets.only(left: 20.0, top: 10),
//                child: Container(
//                  child:  Text("${store_name}", style: TextStyle(
//                    fontSize: 18,
//                  ),),
//                  alignment: Alignment.centerLeft,
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.only(left: 20.0, top: 10),
//                child: Container(
//                  child:  Text("${date_time}", style: TextStyle(
//                    fontSize: 18,
//                  ),),
//                  alignment: Alignment.centerLeft,
//                ),
//              ),
//            ],
//          ),
//        ),
//
//        Expanded(
//          child: Container(
//            child: Padding(
//              padding: const EdgeInsets.only(right: 20),
//              child: Container(
//                child:  Text("${status}", style: TextStyle(
//                  fontSize: 18,
//                  color: color_status,
//                  fontWeight: FontWeight.w800,
//                ),),
//                alignment: Alignment.centerRight,
//              ),
//            ),
//          ),
//        ),
//      ],
//    ),
//  );}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:passioemployee/model/model_profile_emp.dart';
import 'package:passioemployee/view/people_detail.dart';
import 'package:random_color/random_color.dart';

Widget container_Calendar(BuildContext context, int count,Color color_status,String name_emp, String objective, bool check, DataProfile dataPeople){
  RandomColor _randomColor = RandomColor(); // Random màu
  return Container(
    margin: EdgeInsets.only(left: 5, top: 10),
    height: 110,
    child: Row(
      children: [
        CircleAvatar(
//          backgroundImage: AssetImage("assets/images/logo_passio.png"),
          radius: 37,
          backgroundColor: _randomColor.randomColor(
              colorBrightness: ColorBrightness.light  // Chỉ random ra màu sáng
          ),

          child: Row(
            children: [
              Expanded(
                child: Container(
//                  color: Colors.redAccent,
                  alignment: Alignment.center,
//                  color: Colors.black,
                  child: textName("${name_emp.substring(0, 1)}"),
                ),
              ),
//              Container(
//                alignment: Alignment.bottomRight,
//                child: SizedBox(
//                  width: 25.0,
//                  height: 25.0,
//                  child: FloatingActionButton(
//                    heroTag: '${count}',
//                    backgroundColor: color_status,
////                child: Icon(
////                  Icons.add,
////                  color: Colors.white,
////                ),
//                  ),
//                ),
//              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10),
                  child: Container(
                    child:  ButtonBar(
                      alignment: MainAxisAlignment.start,
                        children: [
                          FlatButton(
                            child:  Text("${name_emp}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                            onPressed: () {
                              _sendDataToDetailPeopleScreen(context, dataPeople);
                            },
                          )]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: Container(
                    child:  Text("${dataPeople.store_name}", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13)),
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ],
            ),
          ),
        ),

        Container(
          width: 40,
          // child: Image(image: AssetImage('images/arrow_right.png'),),
          child: ButtonBar(
              children: [
                FlatButton(
                  child:  Image(image: AssetImage('images/arrow_right.png'),),
                  onPressed: () {
                    _sendDataToDetailPeopleScreen(context, dataPeople);
                  },
                )]),
        ),
      ],
    ),
  );}

  Widget checkStatus(bool check, String date_time,String objective){
  if(check == true){
    return Text("Started ${date_time} ", style: TextStyle(
      fontSize: 15,
    ),);
  }else {
    return Container(
      child: Column(
        crossAxisAlignment:  CrossAxisAlignment.start,
        children: [
          Container(
            child: Text("Late to start at ${objective}", style: TextStyle(
              fontSize: 15,
            ),),
          ),
          Container(
            child: Text("9:00 am - 5:00 pm", style: TextStyle(
              color: Colors.blue,
            ),),
          ),
        ],
      ),
    );
  }
  }

  Widget textName(String name){
  return Text("${name}", style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: Colors.white
  ),);
  }

void _sendDataToDetailPeopleScreen(BuildContext context, DataProfile dataPeople) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PeopleDetails(dataPeople: dataPeople),
      ));
}