class GetByDate{
  final int  status, id, employee_id, store_id;
  final String shift_min, shift_max, store_name;

  GetByDate({this.id, this.employee_id, this.status, this.shift_min, this.shift_max, this.store_id, this.store_name});

  factory GetByDate.fromJson(Map<dynamic, dynamic> json){
    return GetByDate(
      id: json['id'],
      employee_id: json['employee_id'],
      status: json['status'],
      shift_min: json['shift_min'],
      shift_max: json['shift_max'],
      store_id: json['store_id'],
      store_name: json['store_name'],
    );
  }
}