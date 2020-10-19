class DataNews {
  final int id;
  final String name, decription,content_html,date_create;
  DataNews({this.id, this.name, this.decription, this.content_html, this.date_create});

  factory DataNews.fromJson(Map<dynamic, dynamic> json) {

    return DataNews(
      id: json['id'],
      name: json['name'],
      decription:  json['decription'],
      content_html:  json['content_html'],
        date_create: json['date_create'],
      // data_store: store_emp,
    );
  }

}