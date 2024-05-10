import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/response/users_response.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class GetUsersUseCase extends BaseUseCase<UsersResponse, GetUsersParameters> {
  final BaseRepository _baseRepository;

  GetUsersUseCase(this._baseRepository);

  @override
  Future<Either<Failure, UsersResponse>> call(GetUsersParameters parameters) async {
    return await _baseRepository.getUsers(parameters);
  }
}

class GetUsersParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetUsersParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.filtersMap,
    this.orderBy,
  });
}