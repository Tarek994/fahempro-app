import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/faq_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetFaqWithIdUseCase extends BaseUseCase<FaqModel, GetFaqWithIdParameters> {
  final BaseRepository _baseRepository;

  GetFaqWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, FaqModel>> call(GetFaqWithIdParameters parameters) async {
    return await _baseRepository.getFaqWithId(parameters);
  }
}

class GetFaqWithIdParameters {
  int faqId;

  GetFaqWithIdParameters({
    required this.faqId,
  });
}