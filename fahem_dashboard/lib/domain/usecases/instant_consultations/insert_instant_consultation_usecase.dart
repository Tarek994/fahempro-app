import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/instant_consultation_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class InsertInstantConsultationUseCase extends BaseUseCase<InstantConsultationModel, InsertInstantConsultationParameters> {
  final BaseRepository _baseRepository;

  InsertInstantConsultationUseCase(this._baseRepository);

  @override
  Future<Either<Failure, InstantConsultationModel>> call(InsertInstantConsultationParameters parameters) async {
    return await _baseRepository.insertInstantConsultation(parameters);
  }
}

class InsertInstantConsultationParameters {
  int userId;
  String consultation;
  bool isDone;
  int? bestAccountId;
  bool isViewed;
  List<String> images;
  String createdAt;

  InsertInstantConsultationParameters({
    required this.userId,
    required this.consultation,
    required this.isDone,
    required this.bestAccountId,
    required this.isViewed,
    required this.images,
    required this.createdAt,
  });
}