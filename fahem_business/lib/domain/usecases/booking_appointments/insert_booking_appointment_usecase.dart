import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/booking_appointment_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class InsertBookingAppointmentUseCase extends BaseUseCase<BookingAppointmentModel, InsertBookingAppointmentParameters> {
  final BaseRepository _baseRepository;

  InsertBookingAppointmentUseCase(this._baseRepository);

  @override
  Future<Either<Failure, BookingAppointmentModel>> call(InsertBookingAppointmentParameters parameters) async {
    return await _baseRepository.insertBookingAppointment(parameters);
  }
}

class InsertBookingAppointmentParameters {
  int accountId;
  int userId;
  String bookingDate;
  bool isViewed;
  String createdAt;

  InsertBookingAppointmentParameters({
    required this.accountId,
    required this.userId,
    required this.bookingDate,
    required this.isViewed,
    required this.createdAt,
  });
}