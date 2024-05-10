import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/data/response/withdrawal_requests_response.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class GetWithdrawalRequestsUseCase extends BaseUseCase<WithdrawalRequestsResponse, GetWithdrawalRequestsParameters> {
  final BaseRepository _baseRepository;

  GetWithdrawalRequestsUseCase(this._baseRepository);

  @override
  Future<Either<Failure, WithdrawalRequestsResponse>> call(GetWithdrawalRequestsParameters parameters) async {
    return await _baseRepository.getWithdrawalRequests(parameters);
  }
}

class GetWithdrawalRequestsParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetWithdrawalRequestsParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}