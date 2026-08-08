import 'package:dartz/dartz.dart';
import 'package:flutter_assessment_task/core/error/failur.dart';
import 'package:flutter_assessment_task/feature/cart/domain/models/cart_model.dart';

abstract class CartRepository {
  Future<Either<Failure, CartModel>> getCart(int id);
}
