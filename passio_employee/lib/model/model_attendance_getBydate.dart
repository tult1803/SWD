class GetByDate{
  final int  id, employee_id, store_id, shift_id, status;
  final String store_name, note, shift_min, shift_max, present_time;
  final bool present;

  GetByDate({this.id, this.employee_id, this.store_id, this.store_name, this.present, this.shift_id, this.status, this.note, this.shift_min, this.shift_max, this.present_time});

  factory GetByDate.fromJson(Map<dynamic, dynamic> json){
    return GetByDate(
      id: json['id'],
      employee_id: json['employeeId'],
      store_id: json['storeId'],
      store_name: json['storeNm'],
      present: json['present'],
      shift_id: json['shiftId'],
      status: json['statusId'],
      note: json['note'],
      shift_min: json['start'],
      shift_max: json['end'],
      present_time: json['presentTime']
    );
  }
}