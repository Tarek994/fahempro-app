import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/terms_of_use_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetTermsOfUseUseCase extends BaseUseCase<TermsOfUseModel, NoParameters> {
  final BaseRepository _baseRepository;

  GetTermsOfUseUseCase(this._baseRepository);

  @override
  Future<Either<Failure, TermsOfUseModel>> call(NoParameters parameters) async {
    return await _baseRepository.getTermsOfUse();
  }
}