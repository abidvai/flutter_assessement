import 'package:flutter_assessment_task/feature/cart/domain/models/cart_model.dart';

class CartState {
  final bool isLoading;
  final CartModel? cart;
  final String? error;

  CartState({
    required this.isLoading,
    this.cart,
    this.error,
  });

  CartState copyWith({
    bool? isLoading,
    CartModel? cart,
    String? error,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      cart: cart ?? this.cart,
      error: error, 
    );
  }
}
