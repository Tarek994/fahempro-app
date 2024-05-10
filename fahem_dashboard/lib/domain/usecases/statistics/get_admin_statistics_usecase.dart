import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/statistic_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class GetAdminStatisticsUseCase extends BaseUseCase<List<StatisticModel>, GetAdminStatisticsParameters> {
  final BaseRepository _baseRepository;

  GetAdminStatisticsUseCase(this._baseRepository);

  @override
  Future<Either<Failure, List<StatisticModel>>> call(GetAdminStatisticsParameters parameters) async {
    return await _baseRepository.getAdminStatistics(parameters);
  }
}

class GetAdminStatisticsParameters {
  int startTimeToday;
  int endTimeToday;
  int startThisMonth;
  int endThisMonth;
  int startLastMonth;
  int endLastMonth;

  GetAdminStatisticsParameters({
    required this.startTimeToday,
    required this.endTimeToday,
    required this.startThisMonth,
    required this.endThisMonth,
    required this.startLastMonth,
    required this.endLastMonth,
  });
}