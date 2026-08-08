import 'package:dartz/dartz.dart';
import 'package:flutter_assessment_task/feature/product/domain/models/product_details_model.dart';
import 'package:flutter_assessment_task/core/error/exception.dart';
import 'package:flutter_assessment_task/core/error/failur.dart';
import 'package:flutter_assessment_task/core/models/paginated_response_model.dart';
import 'package:flutter_assessment_task/feature/product/data/datasources/product_remote_datasource.dart';
import 'package:flutter_assessment_task/feature/product/domain/models/product_model.dart';
import 'package:flutter_assessment_task/feature/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PaginatedResponseModel<ProductModel>>> getProducts({int skip = 0, int limit = 30}) async {
    try {
      final result = await remoteDataSource.getProducts(skip: skip, limit: limit);
      return Right(result);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductDetailsModel>> getProductDetails(int id) async {
    try {
      final result = await remoteDataSource.getProductDetails(id);
      return Right(result);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponseModel<ProductModel>>> searchProducts(String query) async {
    try {
      final result = await remoteDataSource.searchProducts(query);
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
