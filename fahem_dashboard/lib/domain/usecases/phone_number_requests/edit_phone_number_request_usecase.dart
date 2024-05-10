import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/phone_number_request_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class EditPhoneNumberRequestUseCase extends BaseUseCase<PhoneNumberRequestModel, EditPhoneNumberRequestParameters> {
  final BaseRepository _baseRepository;

  EditPhoneNumberRequestUseCase(this._baseRepository);

  @override
  Future<Either<Failure, PhoneNumberRequestModel>> call(EditPhoneNumberRequestParameters parameters) async {
    return await _baseRepository.editPhoneNumberRequest(parameters);
  }
}

class EditPhoneNumberRequestParameters {
  int phoneNumberRequestId;
  int accountId;
  int userId;
  bool isViewed;

  EditPhoneNumberRequestParameters({
    required this.phoneNumberRequestId,
    required this.accountId,
    required this.userId,
    required this.isViewed,
  });
}