class PaginatedResponseModel<T> {
  final List<T> data;
  final int total;
  final int skip;
  final int limit;

  PaginatedResponseModel({
    required this.data,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory PaginatedResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
    String dataKey,
  ) {
    return PaginatedResponseModel(
      data: List<T>.from((json[dataKey] ?? []).map((x) => fromJsonT(x))),
      total: json['total'] ?? 0,
      skip: json['skip'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }
}
