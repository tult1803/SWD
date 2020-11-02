

import 'package:passioemployee/model/url/url_color.dart';
import 'package:flutter/material.dart';
import 'package:passioemployee/model/model_news.dart';

class NewsDetails extends StatefulWidget {
  final DataNews dataNews;

  // NewsDetails(this.id);
  NewsDetails({Key key, @required this.dataNews}) : super(key: key);

  @override
  DetailNewsState createState() => DetailNewsState(dataNews);
}

class DetailNewsState extends State<NewsDetails> {
  final DataNews dataNews;
  DataNews data;
  String news_id, title, content, createDate, authorId;

  DetailNewsState(this.dataNews);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToken();
  }

  void _getToken() async {
    data = dataNews;
    setState(() {
      news_id = data.id.toString();
      title = data.decription;
      content = data.content_html;
      authorId = data.author_id.toString();
      createDate = '${data.date_create.substring(0, 10)}';
    });
    // print('${data.keys}');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 30,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: color_main,
        title: Text(
          "Chi tiết thông tin",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(10),
            // height: 200,
            width: size.width,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    // leading: Icon(Icons.arrow_drop_down_circle),
                    title: Text('$title', style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text(
                      'Ngày đăng: $createDate',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '$content',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      FlatButton(
                        onPressed: () {
                          // Perform some action
                        },
                        child: const Text('ACTION 1'),
                      ),
                      FlatButton(
                        onPressed: () {
                          // Perform some action
                        },
                        child: const Text('ACTION 2'),
                      ),
                    ],
                  ),
                  // Image.asset('assets/card-sample-image-2.jpg'),
                ],
              ),
            ),
            ),
          // ),
        ],
      ),
    );
  }

  Widget card(String tittle, String txt) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10),
      child: Row(
        children: [
          Text(
            '$tittle: ',
            style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w400),
          ),
          Text(
            '$txt',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  void _showDialog(String error) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thông báo"),
          content: new Text("$error",
              style: TextStyle(
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
    ).then((val) {
      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      // builder: (BuildContext context) => LoginScreen()), (
      // Route<dynamic> route) => false);
    });
  }
}