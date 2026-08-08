import 'package:dartz/dartz.dart';
import 'package:flutter_assessment_task/core/error/failur.dart';
import 'package:flutter_assessment_task/core/models/paginated_response_model.dart';
import 'package:flutter_assessment_task/feature/product/domain/models/product_model.dart';
import 'package:flutter_assessment_task/feature/product/domain/repositories/product_repository.dart';

class ProductUsecase {
  final ProductRepository productRepository;
  
  ProductUsecase(this.productRepository);

  Future<Either<Failure, PaginatedResponseModel<ProductModel>>> getProducts({int skip = 0, int limit = 30}) async {
      return await productRepository.getProducts(skip: skip, limit: limit);
  }

  Future<Either<Failure, PaginatedResponseModel<ProductModel>>> searchProducts(String query) async {
      return await productRepository.searchProducts(query);
  }
}