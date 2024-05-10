import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/faq_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class InsertFaqUseCase extends BaseUseCase<FaqModel, InsertFaqParameters> {
  final BaseRepository _baseRepository;

  InsertFaqUseCase(this._baseRepository);

  @override
  Future<Either<Failure, FaqModel>> call(InsertFaqParameters parameters) async {
    return await _baseRepository.insertFaq(parameters);
  }
}

class InsertFaqParameters {
  String questionAr;
  String questionEn;
  String answerAr;
  String answerEn;
  String createdAt;

  InsertFaqParameters({
    required this.questionAr,
    required this.questionEn,
    required this.answerAr,
    required this.answerEn,
    required this.createdAt,
  });
}