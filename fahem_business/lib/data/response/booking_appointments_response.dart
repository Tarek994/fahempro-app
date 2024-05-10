import 'package:fahem_business/data/models/booking_appointment_model.dart';
import 'package:fahem_business/data/models/static/base_model.dart';
import 'package:fahem_business/data/models/static/pagination_model.dart';

class BookingAppointmentsResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<BookingAppointmentModel> bookingAppointments;

  BookingAppointmentsResponse({
    required this.base,
    required this.pagination,
    required this.bookingAppointments,
  });

  BookingAppointmentsResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    bookingAppointments = List.from(json['bookingAppointments']).map((e) => BookingAppointmentModel.fromJson(e)).toList();
  }
}