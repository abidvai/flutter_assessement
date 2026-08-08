import 'package:dartz/dartz.dart';
import 'package:flutter_assessment_task/core/error/failur.dart';
import 'package:flutter_assessment_task/core/models/paginated_response_model.dart';
import 'package:flutter_assessment_task/feature/product/domain/models/product_model.dart';
import 'package:flutter_assessment_task/feature/product/domain/models/product_details_model.dart';

abstract class ProductRepository {
  Future<Either<Failure, PaginatedResponseModel<ProductModel>>> getProducts({int skip = 0, int limit = 30});
  
  Future<Either<Failure, ProductDetailsModel>> getProductDetails(int id);
  
  Future<Either<Failure, PaginatedResponseModel<ProductModel>>> searchProducts(String query);
}
