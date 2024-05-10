class PaginationModel {
  late int total;
  late final int limit;
  late final int page;
  late final int pagesNumber;
  late final int offset;
  late final bool isPaginated;

  PaginationModel({
    required this.total,
    required this.limit,
    required this.page,
    required this.pagesNumber,
    required this.offset,
    required this.isPaginated,
  });

  PaginationModel.fromJson(Map<String, dynamic> json) {
    total = int.parse(json['total'].toString());
    limit = int.parse(json['limit'].toString());
    page = int.parse(json['page'].toString());
    pagesNumber = int.parse(json['pagesNumber'].toString());
    offset = int.parse(json['offset'].toString());
    isPaginated = json['isPaginated'];
  }
}