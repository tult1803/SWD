import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr/qr.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter - QR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}
Timer timer;
class HomePageState extends State {
  String urlImg = 'images/img01.png';
   String data = "12345680";

  @override
  void initState() {
    var rand = Random();
    timer = Timer.periodic(Duration(seconds: 5), (time) async{
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd – kk:mm:ss').format(now);
      setState(() {
        int count = rand.nextInt(10);
        print("Count: $count");
        if(count == 0){
          urlImg = 'images/img01.png';
        }else if(count == 1){
          urlImg = 'images/img03.jpeg';
        }else if(count == 2){
          urlImg = 'images/img03.jpeg';
        }else if(count == 3){
          urlImg = 'images/img04.png';
        }else if(count == 4){
          urlImg = 'images/img05.jpeg';
        }else if(count == 5){
          urlImg = 'images/img06.jpeg';
        }else if(count == 6){
          urlImg = 'images/img07.jpeg';
        }else if(count == 7){
          urlImg = 'images/img08.jpeg';
        }else if(count == 8){
          urlImg = 'images/img09.jpeg';
        }else if(count == 9){
          urlImg = 'images/img10.jpeg';
        }
        data = '${formattedDate}';
      });
        print(data);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text("QRCode"),
//      ),
      body:  Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(urlImg)
            )
        ),
        alignment: Alignment.bottomRight,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 16,),
              QrImage(
                data: data,
                gapless: true,
                size: 150,
                errorCorrectionLevel: QrErrorCorrectLevel.H,
              )
            ],
          ),
      ),
    );
  }
}
