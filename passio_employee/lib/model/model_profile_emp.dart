import 'package:passioemployee/model/store_model.dart';

class DataProfile {
  final int id, main_store_id;
  final String address, email, phone_number, bank_number;
  final String name;
  final double salary;
  final bool gender, active;

  DataProfile({this.id, this.name, this.gender, this.address, this.phone_number, this.main_store_id, this.bank_number, this.email, this.salary,  this.active});

  factory DataProfile.fromJson(Map<dynamic, dynamic> json) {
    return DataProfile(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      address:  json['address'],
      phone_number:  json['phone'],
      main_store_id: json['storeId'],
      bank_number: json['bankNumber'],
      email: json['email'],
      salary:  json['salary'],
      active: json['active']
    );
  }

//  @override
//  String toString() {
//    return 'DataProfile{id: $id, main_store_id: $main_store_id, phone_number: $phone_number, address: $address, email: $email, name: $name, short_name: $short_name, salary: $salary, stores: $data_store}';
//  }
}