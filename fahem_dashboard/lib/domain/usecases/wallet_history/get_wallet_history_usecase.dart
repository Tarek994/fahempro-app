import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/data/response/wallet_history_response.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class GetWalletHistoryUseCase extends BaseUseCase<WalletHistoryResponse, GetWalletHistoryParameters> {
  final BaseRepository _baseRepository;

  GetWalletHistoryUseCase(this._baseRepository);

  @override
  Future<Either<Failure, WalletHistoryResponse>> call(GetWalletHistoryParameters parameters) async {
    return await _baseRepository.getWalletHistory(parameters);
  }
}

class GetWalletHistoryParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetWalletHistoryParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}