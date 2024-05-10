import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/data/models/version_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class EditVersionUseCase extends BaseUseCase<VersionModel, EditVersionParameters> {
  final BaseRepository _baseRepository;

  EditVersionUseCase(this._baseRepository);

  @override
  Future<Either<Failure, VersionModel>> call(EditVersionParameters parameters) async {
    return await _baseRepository.editVersion(parameters);
  }
}

class EditVersionParameters {
  App app;
  String version;
  bool isForceUpdate;
  bool isClearCache;
  bool isMaintenanceNow;
  bool inReview;

  EditVersionParameters({
    required this.app,
    required this.version,
    required this.isForceUpdate,
    required this.isClearCache,
    required this.isMaintenanceNow,
    required this.inReview,
  });
}