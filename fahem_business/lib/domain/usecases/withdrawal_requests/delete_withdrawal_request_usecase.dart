import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class DeleteWithdrawalRequestUseCase extends BaseUseCase<void, DeleteWithdrawalRequestParameters> {
  final BaseRepository _baseRepository;

  DeleteWithdrawalRequestUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteWithdrawalRequestParameters parameters) async {
    return await _baseRepository.deleteWithdrawalRequest(parameters);
  }
}

class DeleteWithdrawalRequestParameters {
  int withdrawalRequestId;

  DeleteWithdrawalRequestParameters({
    required this.withdrawalRequestId,
  });
}