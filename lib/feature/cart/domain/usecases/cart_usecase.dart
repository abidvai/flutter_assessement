import 'package:dartz/dartz.dart';
import 'package:flutter_assessment_task/core/error/failur.dart';
import 'package:flutter_assessment_task/feature/cart/domain/models/cart_model.dart';
import 'package:flutter_assessment_task/feature/cart/domain/repositories/cart_repository.dart';

class CartUsecase {
  final CartRepository repository;

  CartUsecase(this.repository);

  Future<Either<Failure, CartModel>> call(int id) async {
    return await repository.getCart(id);
  }
}
