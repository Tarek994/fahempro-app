import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/response/phone_number_requests_response.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class GetPhoneNumberRequestsUseCase extends BaseUseCase<PhoneNumberRequestsResponse, GetPhoneNumberRequestsParameters> {
  final BaseRepository _baseRepository;

  GetPhoneNumberRequestsUseCase(this._baseRepository);

  @override
  Future<Either<Failure, PhoneNumberRequestsResponse>> call(GetPhoneNumberRequestsParameters parameters) async {
    return await _baseRepository.getPhoneNumberRequests(parameters);
  }
}

class GetPhoneNumberRequestsParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetPhoneNumberRequestsParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}