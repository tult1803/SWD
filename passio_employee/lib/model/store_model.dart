class store{
  final int id;
  final String name;

  store({this.id, this.name});

  factory store.fromJson(Map<String, dynamic> json) {
    return store(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  String toString() {
    return 'store{id: $id, name: $name}';
  }
}