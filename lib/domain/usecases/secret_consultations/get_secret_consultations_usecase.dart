import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/response/secret_consultations_response.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class GetSecretConsultationsUseCase extends BaseUseCase<SecretConsultationsResponse, GetSecretConsultationsParameters> {
  final BaseRepository _baseRepository;

  GetSecretConsultationsUseCase(this._baseRepository);

  @override
  Future<Either<Failure, SecretConsultationsResponse>> call(GetSecretConsultationsParameters parameters) async {
    return await _baseRepository.getSecretConsultations(parameters);
  }
}

class GetSecretConsultationsParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetSecretConsultationsParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}