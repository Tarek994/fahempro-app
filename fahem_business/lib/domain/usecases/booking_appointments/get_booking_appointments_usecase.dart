import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/data/response/booking_appointments_response.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetBookingAppointmentsUseCase extends BaseUseCase<BookingAppointmentsResponse, GetBookingAppointmentsParameters> {
  final BaseRepository _baseRepository;

  GetBookingAppointmentsUseCase(this._baseRepository);

  @override
  Future<Either<Failure, BookingAppointmentsResponse>> call(GetBookingAppointmentsParameters parameters) async {
    return await _baseRepository.getBookingAppointments(parameters);
  }
}

class GetBookingAppointmentsParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetBookingAppointmentsParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}