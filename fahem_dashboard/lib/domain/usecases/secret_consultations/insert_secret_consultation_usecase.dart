import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/data/models/secret_consultation_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class InsertSecretConsultationUseCase extends BaseUseCase<SecretConsultationModel, InsertSecretConsultationParameters> {
  final BaseRepository _baseRepository;

  InsertSecretConsultationUseCase(this._baseRepository);

  @override
  Future<Either<Failure, SecretConsultationModel>> call(InsertSecretConsultationParameters parameters) async {
    return await _baseRepository.insertSecretConsultation(parameters);
  }
}

class InsertSecretConsultationParameters {
  int userId;
  String consultation;
  bool isViewed;
  bool isReplied;
  SecretConsultationReplyType secretConsultationReplyType;
  String replyTypeValue;
  List<String> images;
  String createdAt;

  InsertSecretConsultationParameters({
    required this.userId,
    required this.consultation,
    required this.isViewed,
    required this.isReplied,
    required this.secretConsultationReplyType,
    required this.replyTypeValue,
    required this.images,
    required this.createdAt,
  });
}