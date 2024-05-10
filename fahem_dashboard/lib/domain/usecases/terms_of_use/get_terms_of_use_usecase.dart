import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/terms_of_use_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class GetTermsOfUseUseCase extends BaseUseCase<TermsOfUseModel, NoParameters> {
  final BaseRepository _baseRepository;

  GetTermsOfUseUseCase(this._baseRepository);

  @override
  Future<Either<Failure, TermsOfUseModel>> call(NoParameters parameters) async {
    return await _baseRepository.getTermsOfUse();
  }
}