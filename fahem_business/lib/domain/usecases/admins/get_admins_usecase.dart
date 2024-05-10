import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/data/response/admins_response.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetAdminsUseCase extends BaseUseCase<AdminsResponse, GetAdminsParameters> {
  final BaseRepository _baseRepository;

  GetAdminsUseCase(this._baseRepository);

  @override
  Future<Either<Failure, AdminsResponse>> call(GetAdminsParameters parameters) async {
    return await _baseRepository.getAdmins(parameters);
  }
}

class GetAdminsParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetAdminsParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.filtersMap,
    this.orderBy,
  });
}