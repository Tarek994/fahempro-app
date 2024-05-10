import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/suggested_message_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class EditSuggestedMessageUseCase extends BaseUseCase<SuggestedMessageModel, EditSuggestedMessageParameters> {
  final BaseRepository _baseRepository;

  EditSuggestedMessageUseCase(this._baseRepository);

  @override
  Future<Either<Failure, SuggestedMessageModel>> call(EditSuggestedMessageParameters parameters) async {
    return await _baseRepository.editSuggestedMessage(parameters);
  }
}

class EditSuggestedMessageParameters {
  int suggestedMessageId;
  String messageAr;
  String messageEn;
  String answerAr;
  String answerEn;

  EditSuggestedMessageParameters({
    required this.suggestedMessageId,
    required this.messageAr,
    required this.messageEn,
    required this.answerAr,
    required this.answerEn,
  });
}