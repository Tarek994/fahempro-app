import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/data/response/sliders_response.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class GetSlidersUseCase extends BaseUseCase<SlidersResponse, GetSlidersParameters> {
  final BaseRepository _baseRepository;

  GetSlidersUseCase(this._baseRepository);

  @override
  Future<Either<Failure, SlidersResponse>> call(GetSlidersParameters parameters) async {
    return await _baseRepository.getSliders(parameters);
  }
}

class GetSlidersParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetSlidersParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.filtersMap,
    this.orderBy,
  });
}