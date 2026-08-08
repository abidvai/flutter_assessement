import 'package:flutter_assessment_task/core/network/provider/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_assessment_task/feature/cart/data/datasources/cart_remote_datasource.dart';
import 'package:flutter_assessment_task/feature/cart/data/repositories/cart_repository_impl.dart';
import 'package:flutter_assessment_task/feature/cart/domain/repositories/cart_repository.dart';
import 'package:flutter_assessment_task/feature/cart/domain/usecases/cart_usecase.dart';
import 'package:flutter_assessment_task/feature/cart/presentation/state/cart_state.dart';

final cartRemoteSourceProvider = Provider<CartRemoteDataSource>(
  (ref) => CartRemoteDataSourceImpl(dio: ref.read(dioProvider)),
);

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepositoryImpl(
    remoteDataSource: ref.read(cartRemoteSourceProvider),
  );
});

final cartUsecaseProvider = Provider<CartUsecase>((ref) {
  return CartUsecase(ref.read(cartRepositoryProvider));
});

final cartProvider = NotifierProvider<CartNotifier, CartState>(
  () => CartNotifier(),
);

class CartNotifier extends Notifier<CartState> {
  @override
  CartState build() {
    return CartState(
      isLoading: false,
      cart: null,
      error: null,
    );
  }

  Future<void> fetchCart(int id) async {
    state = state.copyWith(isLoading: true, error: null);

    final usecase = ref.read(cartUsecaseProvider);
    final result = await usecase(id);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (cart) {
        state = state.copyWith(
          isLoading: false,
          cart: cart,
        );
      },
    );
  }
}
