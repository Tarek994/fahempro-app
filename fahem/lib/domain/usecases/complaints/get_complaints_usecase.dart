import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/response/complaints_response.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class GetComplaintsUseCase extends BaseUseCase<ComplaintsResponse, GetComplaintsParameters> {
  final BaseRepository _baseRepository;

  GetComplaintsUseCase(this._baseRepository);

  @override
  Future<Either<Failure, ComplaintsResponse>> call(GetComplaintsParameters parameters) async {
    return await _baseRepository.getComplaints(parameters);
  }
}

class GetComplaintsParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetComplaintsParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}