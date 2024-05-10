import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/data/response/suggested_messages_response.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetSuggestedMessagesUseCase extends BaseUseCase<SuggestedMessagesResponse, GetSuggestedMessagesParameters> {
  final BaseRepository _baseRepository;

  GetSuggestedMessagesUseCase(this._baseRepository);

  @override
  Future<Either<Failure, SuggestedMessagesResponse>> call(GetSuggestedMessagesParameters parameters) async {
    return await _baseRepository.getSuggestedMessages(parameters);
  }
}

class GetSuggestedMessagesParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetSuggestedMessagesParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}