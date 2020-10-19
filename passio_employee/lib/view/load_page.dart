import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:passioemployee/loaders/color_loader_4.dart';
import 'package:passioemployee/model/getAPI_profile_emp.dart';
import 'package:passioemployee/model/model_login.dart';
import 'package:passioemployee/model/model_profile_emp.dart';
import 'package:passioemployee/model/postAPI_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Welcome_Page.dart';
import 'home.dart';
import 'login_screen.dart';

class Load extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoadState();
  }
}
String type = 'Loading';
class LoadState extends State{
  static String error = '';
  SharedPreferences sharedPreferences;
  DataLogin data;
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
      _loadDate();
  }

  Future _loadDate()async{
        PostAPI getAPI = PostAPI();
         sharedPreferences = await SharedPreferences
            .getInstance();
        // Đỗ dữ liệu lấy từ api
        data = await getAPI.createLogin(
            LoginScreenState.email, LoginScreenState.password);
        int status = await PostAPI.status;
        if (status == 200) {
          sharedPreferences.setString("token", data.access_token);
          sharedPreferences.setString("email", data.email);
          sharedPreferences.setString("username", data.user_name);
          sharedPreferences.setString("id_emp", '${data.employeeId}');
          String store_name_emp;
          GetAPIProfile getApi = GetAPIProfile();
          DataProfile dataProfile = await getApi.getProfile(data.access_token);

          sharedPreferences.setString("name_emp", dataProfile.name);
          sharedPreferences.setString("short_name_emp", dataProfile.short_name);
          sharedPreferences.setString("address_emp", dataProfile.address);
          sharedPreferences.setString("main_store_id", "${dataProfile.main_store_id}");
          sharedPreferences.setString("salary_emp", '${dataProfile.salary}');
          sharedPreferences.setString("phone_emp", dataProfile.phone_number);
          sharedPreferences.setString("email_emp", dataProfile.email);
          sharedPreferences.setString("store_work_emp", '${store_name_emp}');
          DemoState.username = data.user_name;
          DemoState.email = data.email;
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => Home()), (
              Route<dynamic> route) => false);
        } else if (status != 200) {
          error = "Login Failed";
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: new Text("Status Login"),
                content: new Text("$error", style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                )),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          ).then((val){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen()), (
              Route<dynamic> route) => false);
        });}}

//  void _checkDate() async{
//    print("PostAPI: ${PostAPI.status}");
//    int status = await PostAPI.status;
//    if (status == 200) {
//      sharedPreferences.setString("token", data.access_token);
//      sharedPreferences.setString("email", data.email);
//      sharedPreferences.setString("username", data.user_name);
//      DemoState.username = data.user_name;
//      DemoState.email = data.email;
//      Navigator.of(context).pushAndRemoveUntil(
//          MaterialPageRoute(builder: (BuildContext context) => Home()), (
//          Route<dynamic> route) => false);
//    } else if (status != 200) {
//      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
//          builder: (BuildContext context) => LoginScreen()), (
//          Route<dynamic> route) => false);
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ColorLoader4(),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text("$type", style: TextStyle(
              fontSize: 15,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),),
          ),
        ],
      ),
    );
  }

}