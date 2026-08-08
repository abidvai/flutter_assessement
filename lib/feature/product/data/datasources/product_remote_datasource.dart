import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_assessment_task/feature/product/domain/models/product_details_model.dart';
import 'package:flutter_assessment_task/core/constant/api_constant.dart';
import 'package:flutter_assessment_task/core/error/exception.dart';
import 'package:flutter_assessment_task/core/models/paginated_response_model.dart';
import 'package:flutter_assessment_task/feature/product/domain/models/product_model.dart';

PaginatedResponseModel<ProductModel> _parsePaginatedProducts(Map<String, dynamic> data) {
  return PaginatedResponseModel<ProductModel>.fromJson(
    data,
    (json) => ProductModel.fromJson(json),
    'products',
  );
}

ProductDetailsModel _parseProductDetails(Map<String, dynamic> data) {
  return ProductDetailsModel.fromJson(data);
}

abstract class ProductRemoteDataSource {
  Future<PaginatedResponseModel<ProductModel>> getProducts({int skip = 0, int limit = 30});
  Future<ProductDetailsModel> getProductDetails(int id);
  Future<PaginatedResponseModel<ProductModel>> searchProducts(String query);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<PaginatedResponseModel<ProductModel>> getProducts({int skip = 0, int limit = 30}) async {
    try {
      final response = await dio.get(
        ApiConstant.products,
        queryParameters: {'skip': skip, 'limit': limit},
      );
      if (response.statusCode == 200) {
        return await compute(_parsePaginatedProducts, response.data as Map<String, dynamic>);
      }
      throw ServerException();
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        throw e.error as NetworkException;
      }
      throw ServerException(e.message ?? 'Unknown Error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ProductDetailsModel> getProductDetails(int id) async {
    try {
      final response = await dio.get(ApiConstant.productDetail(id));
      if (response.statusCode == 200) {
        return await compute(_parseProductDetails, response.data as Map<String, dynamic>);
      }
      throw ServerException();
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        throw e.error as NetworkException;
      }
      throw ServerException(e.message ?? 'Unknown Error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<PaginatedResponseModel<ProductModel>> searchProducts(String query) async {
    try {
      final response = await dio.get(
        ApiConstant.productSearch,
        queryParameters: {'q': query},
      );
      if (response.statusCode == 200) {
        return await compute(_parsePaginatedProducts, response.data as Map<String, dynamic>);
      }
      throw ServerException();
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        throw e.error as NetworkException;
      }
      throw ServerException(e.message ?? 'Unknown Error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

