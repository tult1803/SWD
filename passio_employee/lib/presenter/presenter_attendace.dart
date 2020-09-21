import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



Widget container_attendance(Color color_status,Color color, String store_name, String name_emp,String date_time,String status){
  return Container(
    margin: EdgeInsets.only(bottom: 3),
//    height: 100,
    decoration: new BoxDecoration(
      color: color,                                                          // dòng này để tạo màu cho container
      border: new Border.all(color: Colors.black45, width: 2.0), // dòng này để tạo viền
      borderRadius:  new BorderRadius.circular(10.0),   // dòng này để bo tròn
    ),
    child: Row(
      children: [
        Container(

          width: 220,
//          color: Colors.black,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10),
                child: Container(
                  child:  Text("${store_name} ( ${name_emp} )", overflow: TextOverflow.visible,style: TextStyle(
                    fontSize: 18,
                  ),),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 5, bottom: 5),
                child: Container(
                  child:  Text("${date_time}", style: TextStyle(
                    fontSize: 18,
                  ),),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                child:  Text("${status}", style: TextStyle(
                  fontSize: 18,
                  color: color_status,
                  fontWeight: FontWeight.w800,
                ),),
                alignment: Alignment.centerRight,
              ),
            ),
          ),
        ),
      ],
    ),
  );}

//  Widget card(Color check_color, String store, String date, String status){
//  Color color_status;
//  String _status;
//  Icon icon_status;
//  if(status == "Approved"){
//    _status = "Present";
//    color_status = Color.fromARGB(255, 240,242,254);
//    icon_status = Icon(Icons.check_circle, size: 50,color: Colors.white,);
//  }else if(status == "Processing"){
//    _status = "Waitting";
//    color_status = Colors.black45;
//    icon_status = Icon(Icons.access_time, size: 50,color: Colors.white,);
//  }else if(status == "Absent"){
//    _status = "Absent";
//    color_status = Colors.black45;
//    icon_status = Icon(Icons.remove_circle_outline, size: 50,color: Colors.white,);
//  }
//  return Card(
//    color:  check_color,
//    margin: EdgeInsets.only(top: 20,left: 20,right: 20),
//    shape: RoundedRectangleBorder(
//      borderRadius: BorderRadius.circular(40.0),
//    ),
//    child: Container(
//      height: 290,
////      width: 300,
//      child: Column(
//        children: [
//          Row(
//            children: [
//              Padding(
//                padding: const EdgeInsets.only(left: 25.0, top: 10),
//                child: Icon(Icons.date_range, size: 50,color: Colors.white),
//              ),
//              Expanded(
//                  child: Container(
//                    padding: EdgeInsets.only(right: 30, top: 10),
//                    alignment: Alignment.topRight,
//                    child: Text("$date", style: TextStyle(
//                      fontWeight: FontWeight.w800,
//                      color: Colors.white,
//                      fontSize: 25
//                    ),),
//                  ),
//              ),
//            ],
//          ),
//          Expanded(
//            child: Center(
//              child: Container(
//                child: Text("$store", style: TextStyle(
//                    fontWeight: FontWeight.w800,
//                    color: Colors.white,
//                    fontSize: 30,
//                ),textAlign: TextAlign.center,),
//              ),
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.only(bottom: 10),
//            child: Row(
//              children: [
//                Container(
//                  padding: EdgeInsets.only(left: 30, bottom: 10, top: 10),
//                  alignment: Alignment.topRight,
//                  child: Text("$_status", style: TextStyle(
//                      fontWeight: FontWeight.w800,
//                      color: Colors.black45,
//                      fontSize: 22
//                  ),),
//                ),
//                Expanded(
//                    child: SizedBox(),
//                ),
//                Container(
//                    width: 110,
//                    child: icon_status),
//              ],
//            ),
//          ),
//        ],
//      ),
//    ),
//  );
//  }