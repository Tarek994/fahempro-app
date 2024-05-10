import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/wallet_history_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class GetWalletHistoryWithIdUseCase extends BaseUseCase<WalletHistoryModel, GetWalletHistoryWithIdParameters> {
  final BaseRepository _baseRepository;

  GetWalletHistoryWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, WalletHistoryModel>> call(GetWalletHistoryWithIdParameters parameters) async {
    return await _baseRepository.getWalletHistoryWithId(parameters);
  }
}

class GetWalletHistoryWithIdParameters {
  int walletHistoryId;

  GetWalletHistoryWithIdParameters({
    required this.walletHistoryId,
  });
}