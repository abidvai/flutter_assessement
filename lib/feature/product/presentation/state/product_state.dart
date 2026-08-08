import 'package:flutter_assessment_task/feature/product/domain/models/product_model.dart';

class ProductState {
  final List<ProductModel> products;
  final bool isLoading;
  final String? error;
  final bool hasMore;

  ProductState({
    this.products = const [],
    this.isLoading = false,
    this.error,
    this.hasMore = true,
  });

  ProductState copyWith({
    List<ProductModel>? products,
    bool? isLoading,
    String? error,
    bool? hasMore,
  }) {
    return ProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
