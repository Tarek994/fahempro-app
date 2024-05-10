import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/models/wallet_history_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class InsertWalletHistoryUseCase extends BaseUseCase<WalletHistoryModel, InsertWalletHistoryParameters> {
  final BaseRepository _baseRepository;

  InsertWalletHistoryUseCase(this._baseRepository);

  @override
  Future<Either<Failure, WalletHistoryModel>> call(InsertWalletHistoryParameters parameters) async {
    return await _baseRepository.insertWalletHistory(parameters);
  }
}

class InsertWalletHistoryParameters {
  UserType userType;
  int? accountId;
  int? userId;
  int amount;
  WalletTransactionType walletTransactionType;
  String textAr;
  String textEn;
  String createdAt;

  InsertWalletHistoryParameters({
    required this.userType,
    this.accountId,
    this.userId,
    required this.amount,
    required this.walletTransactionType,
    required this.textAr,
    required this.textEn,
    required this.createdAt,
  });
}