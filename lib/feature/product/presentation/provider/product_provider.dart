import 'package:flutter_assessment_task/core/network/provider/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_assessment_task/feature/product/data/datasources/product_remote_datasource.dart';
import 'package:flutter_assessment_task/feature/product/data/repositories/product_repository_impl.dart';
import 'package:flutter_assessment_task/feature/product/domain/repositories/product_repository.dart';
import 'package:flutter_assessment_task/feature/product/domain/usecases/product_usecase.dart';
import 'package:flutter_assessment_task/feature/product/presentation/state/product_state.dart';


final productRemoteSourceProvider = Provider<ProductRemoteDataSource>(
  (ref) => ProductRemoteDataSourceImpl(dio: ref.read(dioProvider)),
);

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(
    remoteDataSource: ref.read(productRemoteSourceProvider),
  );
});

final productUsecaseProvider = Provider<ProductUsecase>((ref) {
  return ProductUsecase(ref.read(productRepositoryProvider));
});

final productProvider = NotifierProvider<ProductNotifier, ProductState>(
  () => ProductNotifier(),
);

class ProductNotifier extends Notifier<ProductState> {
  @override
  ProductState build() {
    return ProductState(
      isLoading: false,
      products: [],
      error: null,
      hasMore: false,
    );
  }

  Future<void> fetchProducts({
    required int limit,
    required int skip,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final usecase = ref.read(productUsecaseProvider);
    final result = await usecase.getProducts(
      limit: limit,
      skip: skip,
    );

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (response) {
        state = state.copyWith(
          isLoading: false,
          products: [...state.products, ...response.data],
          hasMore: response.data.length == limit,
        );
      },
    );
  }


  Future<void> searchProducts(String query) async {
    state = state.copyWith(isLoading: true, error: null);

    final usecase = ref.read(productUsecaseProvider);
    final result = await usecase.searchProducts(query);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (response) {
        state = state.copyWith(
          isLoading: false,
          products: response.data,
          hasMore: false, 
        );
      },
    );
  }
}