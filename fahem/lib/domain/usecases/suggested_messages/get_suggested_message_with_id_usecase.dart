import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/suggested_message_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class GetSuggestedMessageWithIdUseCase extends BaseUseCase<SuggestedMessageModel, GetSuggestedMessageWithIdParameters> {
  final BaseRepository _baseRepository;

  GetSuggestedMessageWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, SuggestedMessageModel>> call(GetSuggestedMessageWithIdParameters parameters) async {
    return await _baseRepository.getSuggestedMessageWithId(parameters);
  }
}

class GetSuggestedMessageWithIdParameters {
  int suggestedMessageId;

  GetSuggestedMessageWithIdParameters({
    required this.suggestedMessageId,
  });
}