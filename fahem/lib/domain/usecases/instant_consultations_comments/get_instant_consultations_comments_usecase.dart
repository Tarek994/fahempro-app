import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/response/instant_consultations_comments_response.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class GetInstantConsultationsCommentsUseCase extends BaseUseCase<InstantConsultationsCommentsResponse, GetInstantConsultationsCommentsParameters> {
  final BaseRepository _baseRepository;

  GetInstantConsultationsCommentsUseCase(this._baseRepository);

  @override
  Future<Either<Failure, InstantConsultationsCommentsResponse>> call(GetInstantConsultationsCommentsParameters parameters) async {
    return await _baseRepository.getInstantConsultationsComments(parameters);
  }
}

class GetInstantConsultationsCommentsParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetInstantConsultationsCommentsParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}