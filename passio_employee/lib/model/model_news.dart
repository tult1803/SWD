class DataNews {
  final int id, author_id;
  final String name, decription,content_html,date_create;
  final bool active;

  DataNews({this.id, this.name, this.decription, this.content_html, this.date_create, this.active, this.author_id});

  factory DataNews.fromJson(Map<dynamic, dynamic> json) {

    return DataNews(
      id: json['id'],
      name: json['title'],
      decription:  json['shortContent'],
      content_html:  json['content'],
      date_create: json['createDate'],
      active: json['active'],
      author_id: json['authorId']
      // data_store: store_emp,
    );
  }

}