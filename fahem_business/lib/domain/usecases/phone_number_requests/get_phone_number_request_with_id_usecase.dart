import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/phone_number_request_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetPhoneNumberRequestWithIdUseCase extends BaseUseCase<PhoneNumberRequestModel, GetPhoneNumberRequestWithIdParameters> {
  final BaseRepository _baseRepository;

  GetPhoneNumberRequestWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, PhoneNumberRequestModel>> call(GetPhoneNumberRequestWithIdParameters parameters) async {
    return await _baseRepository.getPhoneNumberRequestWithId(parameters);
  }
}

class GetPhoneNumberRequestWithIdParameters {
  int phoneNumberRequestId;

  GetPhoneNumberRequestWithIdParameters({
    required this.phoneNumberRequestId,
  });
}