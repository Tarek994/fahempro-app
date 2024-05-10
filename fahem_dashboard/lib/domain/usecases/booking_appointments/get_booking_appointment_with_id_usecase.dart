import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/booking_appointment_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class GetBookingAppointmentWithIdUseCase extends BaseUseCase<BookingAppointmentModel, GetBookingAppointmentWithIdParameters> {
  final BaseRepository _baseRepository;

  GetBookingAppointmentWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, BookingAppointmentModel>> call(GetBookingAppointmentWithIdParameters parameters) async {
    return await _baseRepository.getBookingAppointmentWithId(parameters);
  }
}

class GetBookingAppointmentWithIdParameters {
  int bookingAppointmentId;

  GetBookingAppointmentWithIdParameters({
    required this.bookingAppointmentId,
  });
}