import 'package:fahem/data/models/static/base_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';
import 'package:fahem/data/models/wallet_history_model.dart';

class WalletHistoryResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<WalletHistoryModel> walletHistory;

  WalletHistoryResponse({
    required this.base,
    required this.pagination,
    required this.walletHistory,
  });

  WalletHistoryResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    walletHistory = List.from(json['walletHistory']).map((e) => WalletHistoryModel.fromJson(e)).toList();
  }
}