class AttendanceAPI{
  final int  status, id;
  final String employee_name, shift_min, shift_max, store_name;

  AttendanceAPI({this.employee_name, this.status, this.id, this.shift_min, this.shift_max, this.store_name});

  factory AttendanceAPI.fromJson(Map<dynamic, dynamic> json){
    return AttendanceAPI(
      employee_name: json['employee_name'],
      status: json['status'],
      shift_min: json['shift_min'],
      shift_max: json['shift_max'],
      id: json['id'],
      store_name: json['store_name'],
    );
  }


}