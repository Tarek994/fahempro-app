import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/admin_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetAdminWithIdUseCase extends BaseUseCase<AdminModel, GetAdminWithIdParameters> {
  final BaseRepository _baseRepository;

  GetAdminWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, AdminModel>> call(GetAdminWithIdParameters parameters) async {
    return await _baseRepository.getAdminWithId(parameters);
  }
}

class GetAdminWithIdParameters {
  int adminId;

  GetAdminWithIdParameters({
    required this.adminId,
  });
}