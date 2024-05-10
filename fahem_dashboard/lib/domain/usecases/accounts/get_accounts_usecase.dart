import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/data/response/accounts_response.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class GetAccountsUseCase extends BaseUseCase<AccountsResponse, GetAccountsParameters> {
  final BaseRepository _baseRepository;

  GetAccountsUseCase(this._baseRepository);

  @override
  Future<Either<Failure, AccountsResponse>> call(GetAccountsParameters parameters) async {
    return await _baseRepository.getAccounts(parameters);
  }
}

class GetAccountsParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetAccountsParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.filtersMap,
    this.orderBy,
  });
}