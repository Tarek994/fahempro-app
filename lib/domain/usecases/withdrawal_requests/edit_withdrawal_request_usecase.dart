import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/models/withdrawal_request_model.dart';
import 'package:fahem/data/models/withdrawal_request_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class EditWithdrawalRequestUseCase extends BaseUseCase<WithdrawalRequestModel, EditWithdrawalRequestParameters> {
  final BaseRepository _baseRepository;

  EditWithdrawalRequestUseCase(this._baseRepository);

  @override
  Future<Either<Failure, WithdrawalRequestModel>> call(EditWithdrawalRequestParameters parameters) async {
    return await _baseRepository.editWithdrawalRequest(parameters);
  }
}

class EditWithdrawalRequestParameters {
  int withdrawalRequestId;
  int accountId;
  WithdrawalRequestStatus withdrawalRequestStatus;
  String? reasonOfReject;
  int balance;
  PaymentType paymentType;
  String paymentTypeValue;

  EditWithdrawalRequestParameters({
    required this.withdrawalRequestId,
    required this.accountId,
    required this.withdrawalRequestStatus,
    required this.reasonOfReject,
    required this.balance,
    required this.paymentType,
    required this.paymentTypeValue,
  });
}