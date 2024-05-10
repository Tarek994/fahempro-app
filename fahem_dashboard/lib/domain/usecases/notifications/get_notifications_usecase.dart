import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/data/response/notifications_response.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class GetNotificationsUseCase extends BaseUseCase<NotificationsResponse, GetNotificationsParameters> {
  final BaseRepository _baseRepository;

  GetNotificationsUseCase(this._baseRepository);

  @override
  Future<Either<Failure, NotificationsResponse>> call(GetNotificationsParameters parameters) async {
    return await _baseRepository.getNotifications(parameters);
  }
}

class GetNotificationsParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;
  UserType userType;
  int? accountId;
  int? userId;
  String targetCreatedAt;

  GetNotificationsParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
    required this.userType,
    this.accountId,
    this.userId,
    required this.targetCreatedAt,
  });
}