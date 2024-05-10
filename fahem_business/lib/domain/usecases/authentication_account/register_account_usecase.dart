import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/data/models/account_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class RegisterAccountUseCase extends BaseUseCase<AccountModel, RegisterAccountParameters> {
  final BaseRepository _baseRepository;

  RegisterAccountUseCase(this._baseRepository);

  @override
  Future<Either<Failure, AccountModel>> call(RegisterAccountParameters parameters) async {
    return await _baseRepository.registerAccount(parameters);
  }
}

class RegisterAccountParameters {
  int mainCategoryId;
  String fullName;
  String? personalImage;
  String emailAddress;
  String password;
  SignInMethod signInMethod;
  String createdAt;

  RegisterAccountParameters({
    required this.mainCategoryId,
    required this.fullName,
    required this.personalImage,
    required this.emailAddress,
    required this.password,
    required this.signInMethod,
    required this.createdAt,
  });
}