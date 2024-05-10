import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/statistic_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class GetAccountStatisticsUseCase extends BaseUseCase<List<StatisticModel>, GetAccountStatisticsParameters> {
  final BaseRepository _baseRepository;

  GetAccountStatisticsUseCase(this._baseRepository);

  @override
  Future<Either<Failure, List<StatisticModel>>> call(GetAccountStatisticsParameters parameters) async {
    return await _baseRepository.getAccountStatistics(parameters);
  }
}

class GetAccountStatisticsParameters {
  int startTimeToday;
  int endTimeToday;
  int startThisMonth;
  int endThisMonth;
  int startLastMonth;
  int endLastMonth;
  int accountId;

  GetAccountStatisticsParameters({
    required this.startTimeToday,
    required this.endTimeToday,
    required this.startThisMonth,
    required this.endThisMonth,
    required this.startLastMonth,
    required this.endLastMonth,
    required this.accountId,
  });
}