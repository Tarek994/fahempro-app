import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/models/wallet_history_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class EditWalletHistoryUseCase extends BaseUseCase<WalletHistoryModel, EditWalletHistoryParameters> {
  final BaseRepository _baseRepository;

  EditWalletHistoryUseCase(this._baseRepository);

  @override
  Future<Either<Failure, WalletHistoryModel>> call(EditWalletHistoryParameters parameters) async {
    return await _baseRepository.editWalletHistory(parameters);
  }
}

class EditWalletHistoryParameters {
  int walletHistoryId;
  UserType userType;
  int? accountId;
  int? userId;
  int amount;
  WalletTransactionType walletTransactionType;
  String textAr;
  String textEn;

  EditWalletHistoryParameters({
    required this.walletHistoryId,
    required this.userType,
    this.accountId,
    this.userId,
    required this.amount,
    required this.walletTransactionType,
    required this.textAr,
    required this.textEn,
  });
}