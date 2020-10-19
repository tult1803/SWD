

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passioemployee/model/getAPI_news.dart';
import 'package:passioemployee/model/model_news.dart';
import 'package:passioemployee/model/url/url_color.dart';
import 'package:passioemployee/model/url/url_icon.dart';
import 'package:passioemployee/presenter/presenter_home.dart';
import 'package:passioemployee/view/people_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'about.dart';
import 'attendance.dart';
import 'calendar.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home>{
   static String token;
  int _selectedPage = 0;
  final _pageOptions = [ // Thay Text bằng class để Naviga
    Home(),
    People(),
    Attendance(),
    Calendar(),
    Profile(),
  ];

  @override
  void initState() {
    _getToken();
    print('Token get !!!');
    _getNews();
  }
   GetAPINews getNew = GetAPINews();
   List<dynamic> data_list = [];
   List<DataNews> data_list_news = [];
  void _getNews() async{
    int i = 0;
    data_list = await getNew.getNews(token);
    print('${data_list.length}');
    data_list.forEach((element) {
      Map<dynamic, dynamic> data= element;
      data_list_news.add(DataNews.fromJson(data));
      print('ID: ${data_list_news[i++].id}');
    });
    // print('Data List: ${data_list.length}');
    // for(int i =0; i< data_list.length; i++){
    //   print('Code News: ${data_list[i].id}');
    // }
  }

  void _getToken()async{
    final prefs = await SharedPreferences.getInstance();
    setState((){
      token = prefs.getString('token');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_main,
        leading: icon_appbar_home,
        title: Text("Tin tức", style: TextStyle(color: Colors.black),),
      ),
      body: FutureBuilder(
          future:  getNew.getNews(token),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              print(snapshot.error);
            }
            if(snapshot.hasData){
              return  new  Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data_list_news.length,
                      itemBuilder: (context, index) {
                        String dateTime = data_list_news[index].date_create;
//                          if(data_list[index].employee_name == _nameEmp){
                        return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: cardNews(data_list_news[index].name, data_list_news[index].content_html, '${dateTime.substring(0, 10).trim()}', '${data_list_news[index].id}'),
                          ),
                        );
//                          }
                      },
                    ),
                  ),
                ],
              );
            }else {
              return Center(child: CircularProgressIndicator());
            }

          } ),

     bottomNavigationBar: BottomNavigationBar(
//       fixedColor: Color.fromARGB(255, 168,206,60),\
     fixedColor: choose_bottombar,
       currentIndex: 0,
       onTap: (int index) {
         setState(() {
           if(index != 0) {
             _selectedPage = index;
             Navigator.of(context).pushAndRemoveUntil(
                 MaterialPageRoute(builder: (context) => _pageOptions[_selectedPage]),
                     (route) => false);
           }});
       },
       items: [
         BottomNavigationBarItem(
             backgroundColor: color_bottombar,
             icon: Icon(Icons.fiber_new, color: icon_bottombar), title: Text("Tin tức")),
         BottomNavigationBarItem(
             icon: Icon(Icons.people, color: icon_bottombar), title: Text("People")),
         BottomNavigationBarItem(
             icon: Icon(Icons.check_circle, color: icon_bottombar), title: Text("Điểm danh")),
         BottomNavigationBarItem(
             icon: Icon(Icons.assignment, color: icon_bottombar), title: Text("Lịch")),
         BottomNavigationBarItem(
             icon: Icon(Icons.account_circle, color: icon_bottombar), title: Text("Cá nhân")),
       ],
     ),
    );
  }

}