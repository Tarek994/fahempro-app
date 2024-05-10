import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/models/withdrawal_request_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class InsertWithdrawalRequestUseCase extends BaseUseCase<WithdrawalRequestModel, InsertWithdrawalRequestParameters> {
  final BaseRepository _baseRepository;

  InsertWithdrawalRequestUseCase(this._baseRepository);

  @override
  Future<Either<Failure, WithdrawalRequestModel>> call(InsertWithdrawalRequestParameters parameters) async {
    return await _baseRepository.insertWithdrawalRequest(parameters);
  }
}

class InsertWithdrawalRequestParameters {
  int accountId;
  WithdrawalRequestStatus withdrawalRequestStatus;
  String? reasonOfReject;
  int balance;
  PaymentType paymentType;
  String paymentTypeValue;
  String createdAt;

  InsertWithdrawalRequestParameters({
    required this.accountId,
    required this.withdrawalRequestStatus,
    required this.reasonOfReject,
    required this.balance,
    required this.paymentType,
    required this.paymentTypeValue,
    required this.createdAt,
  });
}