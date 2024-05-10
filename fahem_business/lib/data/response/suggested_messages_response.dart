import 'package:fahem_business/data/models/static/base_model.dart';
import 'package:fahem_business/data/models/static/pagination_model.dart';
import 'package:fahem_business/data/models/suggested_message_model.dart';

class SuggestedMessagesResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<SuggestedMessageModel> suggestedMessages;

  SuggestedMessagesResponse({
    required this.base,
    required this.pagination,
    required this.suggestedMessages,
  });

  SuggestedMessagesResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    suggestedMessages = List.from(json['suggestedMessages']).map((e) => SuggestedMessageModel.fromJson(e)).toList();
  }
}