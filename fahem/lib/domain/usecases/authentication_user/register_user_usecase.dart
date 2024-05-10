import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/models/user_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class RegisterUserUseCase extends BaseUseCase<UserModel, RegisterUserParameters> {
  final BaseRepository _baseRepository;

  RegisterUserUseCase(this._baseRepository);

  @override
  Future<Either<Failure, UserModel>> call(RegisterUserParameters parameters) async {
    return await _baseRepository.registerUser(parameters);
  }
}

class RegisterUserParameters {
  String fullName;
  String? emailAddress;
  String dialingCode;
  String phoneNumber;
  String? personalImage;
  SignInMethod signInMethod;
  String? reasonForRegistering;
  String createdAt;

  RegisterUserParameters({
    required this.fullName,
    required this.emailAddress,
    required this.dialingCode,
    required this.phoneNumber,
    required this.personalImage,
    required this.signInMethod,
    required this.reasonForRegistering,
    required this.createdAt,
  });
}