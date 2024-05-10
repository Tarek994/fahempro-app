import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class DeleteSuggestedMessageUseCase extends BaseUseCase<void, DeleteSuggestedMessageParameters> {
  final BaseRepository _baseRepository;

  DeleteSuggestedMessageUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteSuggestedMessageParameters parameters) async {
    return await _baseRepository.deleteSuggestedMessage(parameters);
  }
}

class DeleteSuggestedMessageParameters {
  int suggestedMessageId;

  DeleteSuggestedMessageParameters({
    required this.suggestedMessageId,
  });
}