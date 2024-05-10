import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/data/models/secret_consultation_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class EditSecretConsultationUseCase extends BaseUseCase<SecretConsultationModel, EditSecretConsultationParameters> {
  final BaseRepository _baseRepository;

  EditSecretConsultationUseCase(this._baseRepository);

  @override
  Future<Either<Failure, SecretConsultationModel>> call(EditSecretConsultationParameters parameters) async {
    return await _baseRepository.editSecretConsultation(parameters);
  }
}

class EditSecretConsultationParameters {
  int secretConsultationId;
  int userId;
  String consultation;
  bool isViewed;
  bool isReplied;
  SecretConsultationReplyType secretConsultationReplyType;
  String replyTypeValue;
  List<String> images;

  EditSecretConsultationParameters({
    required this.secretConsultationId,
    required this.userId,
    required this.consultation,
    required this.isViewed,
    required this.isReplied,
    required this.secretConsultationReplyType,
    required this.replyTypeValue,
    required this.images,
  });
}