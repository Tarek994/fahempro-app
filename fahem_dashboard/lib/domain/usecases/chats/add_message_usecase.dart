import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/chats/message_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class AddMessageUseCase extends BaseUseCase<void, AddMessageParameters> {
  final BaseRepository _baseRepository;

  AddMessageUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(AddMessageParameters parameters) async {
    return await _baseRepository.addMessage(parameters);
  }
}

class AddMessageParameters {
  final MessageModel messageModel;

  AddMessageParameters({required this.messageModel});
}