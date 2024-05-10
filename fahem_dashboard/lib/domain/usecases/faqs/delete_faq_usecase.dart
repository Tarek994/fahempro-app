import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class DeleteFaqUseCase extends BaseUseCase<void, DeleteFaqParameters> {
  final BaseRepository _baseRepository;

  DeleteFaqUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteFaqParameters parameters) async {
    return await _baseRepository.deleteFaq(parameters);
  }
}

class DeleteFaqParameters {
  int faqId;

  DeleteFaqParameters({
    required this.faqId,
  });
}