import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class DeleteBookingAppointmentUseCase extends BaseUseCase<void, DeleteBookingAppointmentParameters> {
  final BaseRepository _baseRepository;

  DeleteBookingAppointmentUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteBookingAppointmentParameters parameters) async {
    return await _baseRepository.deleteBookingAppointment(parameters);
  }
}

class DeleteBookingAppointmentParameters {
  int bookingAppointmentId;

  DeleteBookingAppointmentParameters({
    required this.bookingAppointmentId,
  });
}