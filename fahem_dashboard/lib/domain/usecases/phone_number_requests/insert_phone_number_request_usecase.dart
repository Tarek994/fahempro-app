import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/phone_number_request_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class InsertPhoneNumberRequestUseCase extends BaseUseCase<PhoneNumberRequestModel, InsertPhoneNumberRequestParameters> {
  final BaseRepository _baseRepository;

  InsertPhoneNumberRequestUseCase(this._baseRepository);

  @override
  Future<Either<Failure, PhoneNumberRequestModel>> call(InsertPhoneNumberRequestParameters parameters) async {
    return await _baseRepository.insertPhoneNumberRequest(parameters);
  }
}

class InsertPhoneNumberRequestParameters {
  int accountId;
  int userId;
  bool isViewed;
  String createdAt;

  InsertPhoneNumberRequestParameters({
    required this.accountId,
    required this.userId,
    required this.isViewed,
    required this.createdAt,
  });
}