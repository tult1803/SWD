

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: Center(
        child: ListView(
          children: [
            cardNews("Phí cách ly 14 ngày tại Việt Nam: 22,5 - 88 triệu đồng, có thể ở khách sạn 5 sao?", "TTO - Theo chỉ đạo mới nhất của Thủ tướng Chính phủ, Việt Nam sẽ tổ chức cách ly có thu phí với người nhập cảnh từ ngày 1-9. Quá trình thực hiện ra sao?"),
            cardNews("Lễ 2-9 đi đâu, chơi gì?", "TTO - Dịp lễ 2-9 năm nay, nhiều điểm vui chơi, du lịch tăng cường các biện pháp phòng dịch đồng thời đẩy mạnh khuyến mãi để thu hút khách, còn người dân cũng cân nhắc, lựa chọn các phương án vui chơi với tiêu chí hàng đầu là an toàn với dịch bệnh."),
            cardNews("Ngày 1-9, TP.HCM tăng mưa, kèm lốc, gió mạnh", "TTO - Đài khí tượng thủy văn Nam Bộ nhận định thời tiết tại Nam Bộ nói chung và TP.HCM nói riêng hôm nay sẽ duy trì sáng nắng chiều mưa, mưa tăng cả diện và lượng."),
            cardNews("TP.HCM - trung tâm tài chính, muộn còn hơn không!", "TTO - Bất cứ quốc gia nào, sự phát triển đều dựa vào hai cấu phần căn bản, đó là nền kinh tế thực thông qua sản xuất, kinh doanh... và nền kinh tế tài chính tiền tệ thông qua quá trình phân phối chu chuyển vốn trong thị trường, xã hội."),
          ],
        ),
      ),


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