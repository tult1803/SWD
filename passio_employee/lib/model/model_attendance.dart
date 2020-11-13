class AttendanceAPI{
  final int id, employeeId, storeId, shiftId, status;
  final String note, shift_min, shift_max, store_name, present_time;
  final bool present;

  AttendanceAPI({this.id, this.employeeId, this.storeId, this.store_name, this.present, this.shiftId, this.status, this.note, this.shift_min, this.shift_max, this.present_time});

  factory AttendanceAPI.fromJson(Map<dynamic, dynamic> json){
    return AttendanceAPI(
      id: json['id'],
      employeeId: json['employeeId'],
      storeId: json['storeId'],
      store_name: json['storeNm'],
      present: json['present'],
      shiftId: json['shiftId'],
      status: json['statusId'],
      note: json['note'],
      shift_min: json['start'],
      shift_max: json['end'],
      present_time: json['presentTime'],
    );
  }


}