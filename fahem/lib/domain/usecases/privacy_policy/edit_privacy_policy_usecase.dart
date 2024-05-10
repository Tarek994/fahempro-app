import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/privacy_policy_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class EditPrivacyPolicyUseCase extends BaseUseCase<PrivacyPolicyModel, EditPrivacyPolicyParameters> {
  final BaseRepository _baseRepository;

  EditPrivacyPolicyUseCase(this._baseRepository);

  @override
  Future<Either<Failure, PrivacyPolicyModel>> call(EditPrivacyPolicyParameters parameters) async {
    return await _baseRepository.editPrivacyPolicy(parameters);
  }
}

class EditPrivacyPolicyParameters {
  String textAr;
  String textEn;

  EditPrivacyPolicyParameters({
    required this.textAr,
    required this.textEn,
  });
}