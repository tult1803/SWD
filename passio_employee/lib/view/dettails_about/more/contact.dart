import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passioemployee/model/url/url_color.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreContact extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MoreContactState();
  }
}

class MoreContactState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.chevron_left, size: 30, color: Colors.black,),
          onPressed: () => Navigator.pop(context), ) ,
        backgroundColor: color_main,
        centerTitle: true,
        title: Text("Liên hệ", style: TextStyle(color: Colors.black)),

      ),
      body: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      // colors: [Colors.red, Colors.pinkAccent, Colors.orange]
                    colors: [Colors.lightGreen, Colors.lightGreen, Colors.green]
                  ),
                  // image: DecorationImage(
                  //     image: NetworkImage(
                  //         "https://previews.123rf.com/images/mousemd/mousemd1602/mousemd160200121/53122766-colorful-pet-seamless-pattern-on-a-white-background-vector-illustration.jpg"),
                  //     fit: BoxFit.fill)
              ),
              child: Container(
                width: double.infinity,
                height: 350.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://i.pinimg.com/originals/7c/4d/16/7c4d1620e8b075c2f7f0636adf8fe335.jpg",
                        ),
                        radius: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Tổng đài Passio",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              )),
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Text(
              'hello@passiocoffee.com',
              style: TextStyle(
                fontSize: 19.0,
                fontStyle: FontStyle.italic,
                // fontWeight: FontWeight.w300,
                color: Colors.redAccent,
                // letterSpacing: 2.0,
              ),
            ),
            alignment: Alignment(0.0, 0.0),
          ),
          Container(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    ' +84 1900 9434',
                    style: TextStyle(
                      fontSize: 19.0,
                      // fontStyle: FontStyle.italic,
                      // fontWeight: FontWeight.w300,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      // letterSpacing: 2.0,
                    ),
                  ),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: 20.0,
          // ),
          Container(
            width: 300.00,
            child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                elevation: 0.0,
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [Colors.redAccent, Colors.pinkAccent]
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: GestureDetector(
                    onTap: (){
                      launch(('https://www.facebook.com/PassioCoffeeVN/'));
                    },
                    child: Container(
                      constraints:
                      BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Thêm thông tin về chúng tôi",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 70.0,
              ),
              SizedBox.fromSize(
                size: Size(56, 56), // button width and height
                child: ClipOval(
                  child: Material(
                    color: Colors.white, // button color
                    child: InkWell(
                      splashColor: Colors.green, // splash color
                      onTap: () {
                        launch(('tel://${19009434}'));
                      }, // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.call, color: Color(0xFF2845E7)), // icon
                          // Text("Gọi", style: TextStyle(color: Color(0xFF2845E7)),), // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 50.0,
              ),
              SizedBox.fromSize(
                size: Size(56, 56), // button width and height
                child: ClipOval(
                  child: Material(
                    color: Colors.white, // button color
                    child: InkWell(
                      splashColor: Colors.green, // splash color
                      onTap: () {
                        launch(('sms://${19009434}'));
                      }, // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.message, color: Color(0xFF2845E7)), // icon
                          // Text("Nhắn tin", style: TextStyle(color: Color(0xFF2845E7)),),// text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 50.0,
              ),
              SizedBox.fromSize(
                size: Size(56, 56), // button width and height
                child: ClipOval(
                  child: Material(
                    color: Colors.white, // button color
                    child: InkWell(
                      splashColor: Colors.green, // splash color
                      onTap: () {

                      }, // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.email, color: Color(0xFF2845E7)), // icon
                          // Text("Email", style: TextStyle(color: Color(0xFF2845E7)),),// text
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),



        ],
      ),
    );

  }

}