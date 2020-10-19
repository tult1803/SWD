import 'package:passioemployee/model/store_model.dart';

class DataProfile {
  final int id, main_store_id;
  final String address, email, phone_number;
  final String name, short_name;
  final double salary;
  DataProfile({this.id, this.name, this.short_name, this.main_store_id, this.address, this.salary, this.phone_number, this.email});

  factory DataProfile.fromJson(Map<dynamic, dynamic> json) {


    return DataProfile(
      id: json['id'],
      name: json['name'],
      short_name: json['short_name'],
      main_store_id: json['main_store_id'],
      address:  json['address'],
      salary:  json['salary'],
      phone_number:  json['phone_number'],
      email: json['email'],
    );
  }

//  @override
//  String toString() {
//    return 'DataProfile{id: $id, main_store_id: $main_store_id, phone_number: $phone_number, address: $address, email: $email, name: $name, short_name: $short_name, salary: $salary, stores: $data_store}';
//  }
}