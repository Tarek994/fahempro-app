class AppointmentBookingModel {
  final String appointmentBookingId;
  final String nameAr;
  final String nameEn;

  AppointmentBookingModel({
    required this.appointmentBookingId,
    required this.nameAr,
    required this.nameEn,
  });

  factory AppointmentBookingModel.fromJson(Map<String, dynamic> json) {
    return AppointmentBookingModel(
      appointmentBookingId: json['appointmentBookingId'],
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
    );
  }

  static Map<String, dynamic> toMap(AppointmentBookingModel appointmentBookingModel) {
    return {
      'appointmentBookingId': appointmentBookingModel.appointmentBookingId,
      'nameAr': appointmentBookingModel.nameAr,
      'nameEn': appointmentBookingModel.nameEn,
    };
  }

  static List<AppointmentBookingModel> fromJsonList (List<dynamic> list) => list.map<AppointmentBookingModel>((item) => AppointmentBookingModel.fromJson(item)).toList();

  static List<Map<String, dynamic>> toMapList(List<AppointmentBookingModel> list) => list.map<Map<String, dynamic>>((item) => AppointmentBookingModel.toMap(item)).toList();
}