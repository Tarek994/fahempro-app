import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class DeleteWalletHistoryUseCase extends BaseUseCase<void, DeleteWalletHistoryParameters> {
  final BaseRepository _baseRepository;

  DeleteWalletHistoryUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteWalletHistoryParameters parameters) async {
    return await _baseRepository.deleteWalletHistory(parameters);
  }
}

class DeleteWalletHistoryParameters {
  int walletHistoryId;

  DeleteWalletHistoryParameters({
    required this.walletHistoryId,
  });
}