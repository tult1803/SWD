import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login_screen.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  Widget _buildIDTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 50.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(4)
              ),
              boxShadow: [BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0,-1),
                  blurRadius: 0,
                  spreadRadius: 0
              )] ,
              color: Colors.white
          ),
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.lightGreen,
                ),
                hintText: 'email@passio.com'
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSendBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,

      child: RaisedButton(
        elevation: 15.0,
        onPressed: () {
          print('Send Button Pressed');
          //Navigator.push(context,MaterialPageRoute(builder: (context) => SwipeScreen()),
          //);
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color.fromRGBO(166, 206, 57, 4),
        child:
        Text(
          'Gửi',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 3.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),

        ),

      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(241, 243, 246, 4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black,),
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },),
        title: Text("Quên Mật Khẩu",style: TextStyle(color: Colors.black)),


      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,


              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildIDTF(),
                      _buildSendBtn()



                    ],
                  ),
                ),

              )
            ],
          ),
        ),
      ),


    );
  }
}
