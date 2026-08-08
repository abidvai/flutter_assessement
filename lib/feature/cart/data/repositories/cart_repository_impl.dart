import 'package:dartz/dartz.dart';
import 'package:flutter_assessment_task/core/error/exception.dart';
import 'package:flutter_assessment_task/core/error/failur.dart';
import 'package:flutter_assessment_task/feature/cart/data/datasources/cart_remote_datasource.dart';
import 'package:flutter_assessment_task/feature/cart/domain/models/cart_model.dart';
import 'package:flutter_assessment_task/feature/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, CartModel>> getCart(int id) async {
    try {
      final result = await remoteDataSource.getCart(id);
      return Right(result);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
