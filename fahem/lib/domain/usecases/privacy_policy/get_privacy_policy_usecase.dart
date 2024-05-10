import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/privacy_policy_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class GetPrivacyPolicyUseCase extends BaseUseCase<PrivacyPolicyModel, NoParameters> {
  final BaseRepository _baseRepository;

  GetPrivacyPolicyUseCase(this._baseRepository);

  @override
  Future<Either<Failure, PrivacyPolicyModel>> call(NoParameters parameters) async {
    return await _baseRepository.getPrivacyPolicy();
  }
}