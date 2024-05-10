import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/faq_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class EditFaqUseCase extends BaseUseCase<FaqModel, EditFaqParameters> {
  final BaseRepository _baseRepository;

  EditFaqUseCase(this._baseRepository);

  @override
  Future<Either<Failure, FaqModel>> call(EditFaqParameters parameters) async {
    return await _baseRepository.editFaq(parameters);
  }
}

class EditFaqParameters {
  int faqId;
  String questionAr;
  String questionEn;
  String answerAr;
  String answerEn;

  EditFaqParameters({
    required this.faqId,
    required this.questionAr,
    required this.questionEn,
    required this.answerAr,
    required this.answerEn,
  });
}