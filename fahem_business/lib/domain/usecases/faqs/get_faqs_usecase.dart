import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/data/response/faqs_response.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetFaqsUseCase extends BaseUseCase<FaqsResponse, GetFaqsParameters> {
  final BaseRepository _baseRepository;

  GetFaqsUseCase(this._baseRepository);

  @override
  Future<Either<Failure, FaqsResponse>> call(GetFaqsParameters parameters) async {
    return await _baseRepository.getFaqs(parameters);
  }
}

class GetFaqsParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetFaqsParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}