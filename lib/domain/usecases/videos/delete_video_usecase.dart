import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class DeleteVideoUseCase extends BaseUseCase<void, DeleteVideoParameters> {
  final BaseRepository _baseRepository;

  DeleteVideoUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteVideoParameters parameters) async {
    return await _baseRepository.deleteVideo(parameters);
  }
}

class DeleteVideoParameters {
  int videoId;

  DeleteVideoParameters({
    required this.videoId,
  });
}