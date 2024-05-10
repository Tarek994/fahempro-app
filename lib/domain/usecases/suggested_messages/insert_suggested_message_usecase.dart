import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/suggested_message_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class InsertSuggestedMessageUseCase extends BaseUseCase<SuggestedMessageModel, InsertSuggestedMessageParameters> {
  final BaseRepository _baseRepository;

  InsertSuggestedMessageUseCase(this._baseRepository);

  @override
  Future<Either<Failure, SuggestedMessageModel>> call(InsertSuggestedMessageParameters parameters) async {
    return await _baseRepository.insertSuggestedMessage(parameters);
  }
}

class InsertSuggestedMessageParameters {
  String messageAr;
  String messageEn;
  String answerAr;
  String answerEn;
  String createdAt;

  InsertSuggestedMessageParameters({
    required this.messageAr,
    required this.messageEn,
    required this.answerAr,
    required this.answerEn,
    required this.createdAt,
  });
}