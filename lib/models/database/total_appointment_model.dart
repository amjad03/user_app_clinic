class TotalAppointmentModel {
  TotalAppointmentModel({
    required this.name,
    required this.age,
    required this.blood,
    required this.gender,
    required this.phone,
    required this.address,
    required this.date,
    required this.time,
    required this.scanAmount,
    required this.scanType,
    required this.paymentStatus,
    required this.appointmentStatus,
  });

  final String name;
  final String age;
  final String blood;
  final String gender;
  final String phone;
  final String address;
  final String date;
  final String time;
  final String scanAmount;
  final String scanType;
  final String paymentStatus;
  final String appointmentStatus;

  TotalAppointmentModel.fromJson(Map<String, Object?> json)
      : this(
            name: json['name']! as String,
            age: json['age']! as String,
            blood: json['blood']! as String,
            gender: json['gender']! as String,
            phone: json['phone']! as String,
            address: json['address']! as String,
            date: json['date']! as String,
            time: json['time']! as String,
            scanAmount: json['scanAmount']! as String,
            scanType: json['scanType']! as String,
            paymentStatus: json['paymentStatus']! as String,
            appointmentStatus: json['appointmentStatus']! as String);

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'age': age,
      'blood': blood,
      'gender': gender,
      'phone': phone,
      'address': address,
      'date': date,
      'time': time,
      'scanAmount': scanAmount,
      'paymentMode': scanType,
      'paymentStatus': paymentStatus,
      'appointmentStatus': appointmentStatus
    };
  }
}
