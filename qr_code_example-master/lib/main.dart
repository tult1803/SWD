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
   String storeId = '1';
  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 5), (time) async{
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd – kk:mm:ss').format(now);
      setState(() {
        data = '${formattedDate};${storeId}';
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
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 16,),
                QrImage(
                  data: data,
                  gapless: true,
                  size: 350,
                  errorCorrectionLevel: QrErrorCorrectLevel.H,
                )
              ],
            ),
        ),
      ),
    );
  }
}
