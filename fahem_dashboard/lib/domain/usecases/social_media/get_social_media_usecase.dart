import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/data/response/social_media_response.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class GetSocialMediaUseCase extends BaseUseCase<SocialMediaResponse, GetSocialMediaParameters> {
  final BaseRepository _baseRepository;

  GetSocialMediaUseCase(this._baseRepository);

  @override
  Future<Either<Failure, SocialMediaResponse>> call(GetSocialMediaParameters parameters) async {
    return await _baseRepository.getSocialMedia(parameters);
  }
}

class GetSocialMediaParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetSocialMediaParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}