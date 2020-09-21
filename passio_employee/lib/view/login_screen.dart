import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passioemployee/model/getAPI_profile_emp.dart';
import 'package:passioemployee/model/model_login.dart';
import 'package:passioemployee/model/model_profile_emp.dart';
import 'package:passioemployee/view/home.dart';
import 'package:passioemployee/view/load_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgotpassword_screen.dart';



class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  Future<DataLogin> _futureLogin;
  static String email, password;
  bool _isLoading = false;
  Widget _buildIDTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
            onChanged: (text1) {
              email = text1;
            },
//            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Color.fromRGBO(166, 206, 57, 4),
              ),
                hintText: 'email@passio.com'
            ),
          ),
        )
      ],
    );
  }


  Widget _buildPasswordTF() {
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
            onChanged: (text) {
              password = text;
            },
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color.fromRGBO(166, 206, 57, 4),
                ),
                hintText: '••••••••••'
            ),
            obscureText: true,
          ),
        )
      ],
    );

  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.0),
      width: double.infinity,

      child: RaisedButton(
        elevation: 15.0,
        onPressed: () async{
          // Key value
//          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          print('Email: ${email} -- Password: ${password}');
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Load()), (Route<dynamic> route) => false);

//          PostAPI getAPI = PostAPI();
//          DataLogin data;
//          // Đỗ dữ liệu lấy từ api
//          data = await getAPI.createLogin(_email, _password);
//          if(PostAPI.status == 200){
//            sharedPreferences.setString("token", data.access_token);
//            sharedPreferences.setString("email", data.email);
//            sharedPreferences.setString("username", data.user_name);
//            DemoState.username = data.user_name;
//            DemoState.email = data.email;
//            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Home()), (Route<dynamic> route) => false);
//          }
        },

        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color.fromRGBO(166, 206, 57, 4),
        child: Text(
          'Đăng Nhập',
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

  Widget _buildForgetPassword() {
    return new FlatButton(color: Colors.transparent,
      splashColor: Colors.black26,
      onPressed: () {
        print('done');
        Navigator.push(context,MaterialPageRoute(builder: (context) => ForgotPassword()),);
      },
      child: Text(
        'Quên Mật Khẩu',
        style: TextStyle(color: Colors.black,fontSize: 20),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/img_bg.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),

              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 100.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildIDTF(),
                      _buildPasswordTF(),
                      _buildLoginBtn(),
                      _buildForgetPassword(),


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

