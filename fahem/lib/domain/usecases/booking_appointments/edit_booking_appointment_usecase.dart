import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/booking_appointment_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class EditBookingAppointmentUseCase extends BaseUseCase<BookingAppointmentModel, EditBookingAppointmentParameters> {
  final BaseRepository _baseRepository;

  EditBookingAppointmentUseCase(this._baseRepository);

  @override
  Future<Either<Failure, BookingAppointmentModel>> call(EditBookingAppointmentParameters parameters) async {
    return await _baseRepository.editBookingAppointment(parameters);
  }
}

class EditBookingAppointmentParameters {
  int bookingAppointmentId;
  int accountId;
  int userId;
  String bookingDate;
  bool isViewed;

  EditBookingAppointmentParameters({
    required this.bookingAppointmentId,
    required this.accountId,
    required this.userId,
    required this.bookingDate,
    required this.isViewed,
  });
}